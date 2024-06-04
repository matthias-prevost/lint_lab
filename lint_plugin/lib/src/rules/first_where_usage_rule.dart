import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';
import 'package:lint_plugin/src/utils/is_type_or_subtype_of.dart';

/// A lint rule that prevent from using `firstWhere` method on [Iterable]
class FirstWhereUsageRule extends DartLintRule {
  /// Default constructor for lint rule
  const FirstWhereUsageRule() : super(code: _code);

  static const _code = LintCode(
    name: 'first_where_usage',
    problemMessage: 'Use firstWhereOrNull instead of firstWhere',
    correctionMessage: 'Replace firstWhere with firstWhereOrNull',
  );

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addMethodInvocation(
      (node) {
        // Check if the method name is 'firstWhere'
        if (node.methodName.name == 'firstWhere') {
          // Only catch the methods which are associated to a type
          final staticType = node.realTarget?.staticType;
          if (staticType == null) {
            return;
          }

          if (isTypeOrSubtypeOf<Iterable<Object?>>(staticType)) {
            // Report a lint warning at the location of the method invocation
            //
            // Use [node.methodName] to only underline the "firstWhere" and not
            // all its invocation
            reporter.reportErrorForNode(
              FirstWhereUsageRule._code,
              node.methodName,
            );
          }
        }
      },
    );
  }
}
