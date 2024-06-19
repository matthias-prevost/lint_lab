import 'package:analyzer/error/error.dart';
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class SkeletonRule extends DartLintRule {
  SkeletonRule() : super(code: _code);

  static const _code = LintCode(
    name: '', // The name of the rule
    problemMessage:
        '', // The message that will be displayed when the rule is violated
    correctionMessage: '', // The message to indicate how to fix the violation
  );

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    // Add a listener
  }

  @override
  List<Fix> getFixes() {
    return [_SkeletonRuleFix()];
  }
}

class _SkeletonRuleFix extends DartFix {
  @override
  void run(
    CustomLintResolver resolver,
    ChangeReporter reporter,
    CustomLintContext context,
    AnalysisError analysisError,
    List<AnalysisError> others,
  ) {
    // Listen to the same listener as the rule
  }
}
