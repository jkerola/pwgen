// Generate a password based on arguments. Uses the english_words package.

// Package imports:
import 'package:args/args.dart';
import 'package:english_words/english_words.dart';

// Project imports:
import 'package:pwgen/argument_keys.dart';

/// Returns a password based on the parsed [ArgResults].
String generatePassword(ArgResults argResults) {
  // parse arguments
  int wordCount = int.parse(argResults[ArgumentKeys.argWordCount]);
  String separator = argResults[ArgumentKeys.argSeparator];

  // Words are generated in pairs, this ensures odd numbered request can be made
  var count = (wordCount / 2).floor() + 1;
  // Generate words using the english_words package
  Iterable<WordPair> pairs = generateWordPairs(maxSyllables: 8).take(count);

  // Separate each word
  List<String> wordList = [];
  for (var pair in pairs) {
    wordList.addAll([pair.first, pair.second]);
  }

  // Shuffle the list
  wordList.shuffle();

  // Even, remove the last pair. Odd, remove only the last word.
  if (wordCount.isEven) {
    wordList.removeLast();
  }
  wordList.removeLast();

  // Perform capitalization and concatenate words to string
  if (argResults.wasParsed(ArgumentKeys.argIsCapitalized)) {
    return wordList
        .map((e) => e.replaceFirst(e[0], e[0].toUpperCase()))
        .join(separator);
  } else {
    return wordList.map((e) => e.toLowerCase()).join(separator);
  }
}

/// Returns a preconfigured [ArgParser].
ArgParser createParser() {
  var parser = ArgParser()
    ..addOption(ArgumentKeys.argWordCount,
        abbr: ArgumentKeys.argWordCount[0],
        help: ArgumentKeys.argWordCount,
        mandatory: false,
        defaultsTo: "4")
    ..addOption(ArgumentKeys.argSeparator,
        abbr: ArgumentKeys.argSeparator[0],
        mandatory: false,
        help: ArgumentKeys.helpSeparator,
        defaultsTo: '-')
    ..addFlag(
      ArgumentKeys.argIsCapitalized,
      help: ArgumentKeys.helpIsCapitalized,
      negatable: false,
      abbr: ArgumentKeys.argIsCapitalized[0],
    )
    ..addFlag(
      ArgumentKeys.argVersion,
      help: ArgumentKeys.helpVersion,
      negatable: false,
      abbr: ArgumentKeys.argVersion[0],
    )
    ..addFlag(
      ArgumentKeys.argHelp,
      help: ArgumentKeys.helpHelp,
      negatable: false,
      abbr: ArgumentKeys.argHelp[0],
    );
  return parser;
}
