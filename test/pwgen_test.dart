// Package imports:
import 'package:args/args.dart';
import 'package:test/test.dart';

// Project imports:
import 'package:pwgen/argument_keys.dart';
import 'package:pwgen/utils.dart';

void main() {
  ArgParser parser = createParser();
  group('Argument parsing', () {
    ArgResults args = parser.parse([]);
    test('has default separator "-"', () {
      expect(args[ArgumentKeys.argSeparator], equals('-'));
    });
    test('has default word-count of 4', () {
      expect(int.parse(args[ArgumentKeys.argWordCount]), equals(4));
    });
    test('should accept word-count argument', () {
      args = parser.parse(['-w', '6']);
      expect(int.parse(args[ArgumentKeys.argWordCount]), equals(6));
    });
    test('should accept separator argument', () {
      args = parser.parse(['-s', '.']);
      expect(args[ArgumentKeys.argSeparator], equals('.'));
    });
    test('should accept version argument', () {
      args = parser.parse(['-v']);
      expect(args.wasParsed(ArgumentKeys.argVersion), isTrue);
    });
    test('should accept help argument', () {
      args = parser.parse(['-h']);
      expect(args[ArgumentKeys.argHelp], equals(true));
    });
    test('should accept capitalize argument', () {
      args = parser.parse(['-c']);
      expect(args[ArgumentKeys.argIsCapitalized], equals(true));
    });
    test('should throw error with missing arguments', () {
      expect(() => parser.parse(['-s']), throwsFormatException);
    });
  });

  group('Password generation', () {
    var args = parser.parse([]);
    test('should work with defaults', () {
      var words = generatePassword(args).split('-');
      expect(words.length, equals(4));
    });
    test('should work with different word-count', () {
      var args = parser.parse(['-w', '6']);
      var words = generatePassword(args).split('-');
      expect(words.length, equals(6));
    });
    test('should work with different separator', () {
      var args = parser.parse(['-s', '!']);
      var words = generatePassword(args).split('!');
      expect(words.length, equals(4));
    });
    test('should be capitalizable', () {
      var args = parser.parse(['-c']);
      var words = generatePassword(args).split('-');

      // check each word is capitalized
      for (var word in words) {
        expect(word, startsWith(word[0].toUpperCase()));
      }
    });
  });
}
