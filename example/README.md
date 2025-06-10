# example

An example project illustrating the use of the Flutter Localization Linter.

## Getting Started

To include the Flutter Localization Linter, you will need to modify your pubspec.yaml to add:

```yaml
dev_dependencies:
  custom_lint: ^latest_version
  flutter_localization_linter: ^latest_version
```

You will also need to create an `analysis_options.yaml` file in the top-level directory of your project.

Here is an example file with the needed custom_lint linter plugin, as well as the flutter_localization_linter
custom linter.

```yaml
# analysis_options.yaml
# This file configures the analyzer, which statically analyzes Dart code to
# check for errors, warnings, and lints.
#
# The issues identified by the analyzer are surfaced in the UI of Dart-enabled
# IDEs (https://dart.dev/tools#ides-and-editors). The analyzer can also be
# invoked from the command line by running `flutter analyze`.

# The following line activates a set of recommended lints for Flutter apps,
# packages, and plugins designed to encourage good coding practices.
include: package:flutter_lints/flutter.yaml

linter:
  # The lint rules applied to this project can be customized in the
  # section below to disable rules from the `package:flutter_lints/flutter.yaml`
  # included above or to enable additional rules. A list of all available lints
  # and their documentation is published at https://dart.dev/lints.
  #
  # Instead of disabling a lint rule for the entire project in the
  # section below, it can also be suppressed for a single line of code
  # or a specific dart file by using the `// ignore: name_of_lint` and
  # `// ignore_for_file: name_of_lint` syntax on the line or in the file
  # producing the lint.
  rules:
    # avoid_print: false  # Uncomment to disable the `avoid_print` rule
    # prefer_single_quotes: true  # Uncomment to enable the `prefer_single_quotes` rule
analyzer:
  plugins:
    - custom_lint

custom_lint:
  rules:
    - flutter_localization_linter_role: true # for enabled or false for disabled
# Additional information about this file can be found at
# https://dart.dev/guides/language/analysis-options
```
