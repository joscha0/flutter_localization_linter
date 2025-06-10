# Flutter Localization Linter

[![Pub Version](https://img.shields.io/pub/v/flutter_localization_linter)](https://pub.dev/packages/flutter_localization_linter)

A Flutter linter plugin that ensures all Text and AutoSizeText widgets use app localizations instead of hardcoded strings.

## Installation

Add this to your `pubspec.yaml`:

```yaml
dev_dependencies:
  custom_lint: ^latest_version
  flutter_localization_linter: ^1.0.0
```

Then, run `flutter pub get` to fetch the package.

## Configuration

Add to your `analysis_options.yaml`:

```yaml
analyzer:
  plugins:
    - custom_lint

custom_lint:
  rules:
    - flutter_localization_linter_rule: true # true for enabled, false for disabled
```

This will enable the linting rules in your Flutter project.

## Usage

The linter will flag hardcoded strings in Text and AutoSizeText widgets:

❌ **Bad:**

```dart
Text('Hello World') // Will be flagged
```

✅ **Good:**

```dart
Text(AppLocalizations.of(context).helloWorld)
Text(context.l10n.helloWorld)
Text(S.of(context).helloWorld)
Text(S.current.helloWorld)
```

## Ignoring Specific Cases

Use the `// ignore: flutter_localization_linter_rule` comment to suppress warnings:

```dart
// ignore: flutter_localization_linter_rule
Text('Hello World')

Text('Hello World') // ignore: flutter_localization_linter_rule
```

## Supported Localization Patterns

- `AppLocalizations.of(context).key`
- `context.l10n.key` (extension method)
- `S.of(context).key` (intl_utils generated)
- `S.current.key` (intl_utils)

## Usage Example

Here's how the linter works in practice:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:auto_size_text/auto_size_text.dart';

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ❌ This will be flagged by the linter
        Text('Hello World'),

        // ❌ This will also be flagged
        AutoSizeText('Welcome to our app'),

        // ✅ This is correct
        Text(AppLocalizations.of(context).helloWorld),

        // ✅ This is also correct
        AutoSizeText(context.l10n.welcomeMessage),

        // ✅ Empty strings and whitespace only strings will be ignored
        Text(''),

        // ✅ This will be ignored due to comment
        // ignore: flutter_localization_linter_rule
        Text('Debug: Version 1.0.0'),

        // ✅ This will also be ignored
        Text('Test string'), // ignore: flutter_localization_linter_rule
      ],
    );
  }
}
```

This linter plugin will help ensure consistent use of localization throughout your Flutter app, making it easier to maintain and translate your application.

## Attribution

https://github.com/wolfe719/intl_translation_linter
