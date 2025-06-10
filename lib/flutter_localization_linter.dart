import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/error.dart' hide LintCode;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

PluginBase createPlugin() => FlutterLocalizationLinter();

class FlutterLocalizationLinter extends PluginBase {
  @override
  List<LintRule> getLintRules(CustomLintConfigs configs) => [
    FlutterLocalizationLintRule(),
  ];
}

class FlutterLocalizationLintRule extends DartLintRule {
  FlutterLocalizationLintRule() : super(code: _code);

  static final _code = LintCode(
    name: 'flutter_localization_linter_rule',
    problemMessage:
        'You are using hardcoded strings. Use S.of(context).helloWorld, S.current.helloWorld, context.l10n.helloWorld or AppLocalizations.of(context).helloWorld instead',
    errorSeverity: ErrorSeverity.WARNING,
  );

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addArgumentList((node) {
      for (final argument in node.arguments) {
        if (getArguments(argument) &&
            argument.staticParameterElement?.type.getDisplayString(
                  withNullability: false,
                ) ==
                'String' &&
            isStringLiteral(argument)) {
          if (!argument.toSource().contains('S.of(context)') &&
              !argument.toSource().contains('S.current') &&
              !argument.toSource().contains('context.l10n') &&
              !argument.toSource().contains('AppLocalizations.of(context)')) {
            reporter.atToken(
              argument.beginToken,
              _code,
              arguments: [],
              contextMessages: [],
            );
          }
        }
      }
    });
    context.registry.addInstanceCreationExpression((node) {
      final constructorName = node.constructorName;
      if ((constructorName.type.element?.name == 'Text' ||
          constructorName.type.element?.name == 'AutoSizeText')) {
        // Check if there are any arguments
        if (node.argumentList.arguments.isNotEmpty) {
          final firstArg = node.argumentList.arguments.first;

          // Only report issues for string literals
          if (isStringLiteral(firstArg) &&
              !node.argumentList.toString().contains('S.of(context)') &&
              !node.argumentList.toString().contains('S.current') &&
              !node.argumentList.toString().contains('context.l10n') &&
              !node.argumentList.toString().contains(
                'AppLocalizations.of(context)',
              )) {
            reporter.atNode(node, _code, arguments: []);
          }
        }
      }
    });
  }

  // Helper method to check if an expression is a string literal or a modified string
  bool isStringLiteral(Expression expression) {
    // Direct string literals
    if (expression is StringLiteral) {
      return true;
    }

    // String interpolation without variables
    if (expression is StringInterpolation &&
        !expression.elements.any(
          (element) => element is! InterpolationString,
        )) {
      return true;
    }

    // String manipulation operations (method calls on strings)
    if (expression is MethodInvocation) {
      // Check if it's a method call on a string or another method call
      if (expression.target is StringLiteral ||
          expression.target is MethodInvocation ||
          (expression.target is SimpleIdentifier)) {
        // Common string manipulation methods
        final methodName = expression.methodName.name;
        final stringMethods = [
          'toLowerCase',
          'toUpperCase',
          'trim',
          'substring',
          'replaceAll',
          'replaceFirst',
          'split',
          'join',
          'padLeft',
          'padRight',
          'contains',
          'startsWith',
          'endsWith',
          'concat',
        ];

        if (stringMethods.contains(methodName)) {
          return true;
        }
      }
    }

    // Binary expressions for string concatenation (string + string)
    if (expression is BinaryExpression &&
        expression.operator.type.toString() == 'PLUS') {
      return true;
    }

    return false;
  }

  bool getArguments(Expression argument) {
    return argument.staticParameterElement?.name == 'label' ||
        argument.staticParameterElement?.name == 'hintText' ||
        argument.staticParameterElement?.name == 'tooltip' ||
        argument.staticParameterElement?.name == 'title' ||
        argument.staticParameterElement?.name == 'text' ||
        argument.staticParameterElement?.name == 'placeholder' ||
        argument.staticParameterElement?.name == 'labelText';
  }
}
