// Package imports:
import 'package:cli_util/cli_logging.dart';

// Project imports:
import 'package:pwgen/argument_keys.dart';
import 'package:pwgen/utils.dart';
import 'package:pwgen/version.dart';

void main(List<String> arguments) {
  final logger = Logger.standard();
  try {
    // Parse arguments
    var parser = createParser();
    var argResults = parser.parse(arguments);

    // --help will override any other argument.
    if (argResults.wasParsed(ArgumentKeys.argHelp)) {
      logger.stdout(
        "pwgen $packageVersion"
        "\nGenerates easily memorizable, strong password strings randomly."
        "\nPreviously generated passwords cannot be recovered."
        "\n\nOptions:"
        "\n\t${parser.usage.split('\n').join('\n\t')}"
        "\n\nUse '--help' to display this page again.",
      );
    } else if (argResults.wasParsed(ArgumentKeys.argVersion)) {
      logger.stdout(packageVersion);
    } else {
      logger.stdout(generatePassword(argResults));
    }
  } catch (e) {
    logger.stderr(e.toString());
  }
}
