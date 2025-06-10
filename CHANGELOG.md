## 1.0.4

- Updated to Flutter 3.24.4 / Dart 3.5.4
- Ignore Ignore extra LintCode in analyzer/error/error.dart
- Updated to custom_lint 0.6.8
- Updated to analyzer 6.7.0
- Update to custom_lint_builder 0.6.8
- Renamed generic MyCustomLintCode class to IntlTranslationLintRule

## 1.0.3

- Reverted ErrorReporter.atToken() call to deprecated call
  ErrorReporter.reportErrorForToken() because some projects
  still need analyzer v6.4.1

## 1.0.2

- Changed name from smarter_translate_lint to flutter_localization_linter
- Changed warning identifier from smarter_translate_lint_use_s_role to
  flutter_localization_linter_use_s_role

## 1.0.1

- Change smarter_translate_lint_use_s_role to WARNING

## 1.0.0

- Initial version.
