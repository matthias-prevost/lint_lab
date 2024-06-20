import 'package:analyzer/error/error.dart';
import 'package:analyzer/error/listener.dart';
import 'package:analyzer/source/source_range.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class NoListRule extends DartLintRule {
  NoListRule() : super(code: _code);

  static const _code = LintCode(
    name: 'No list',
    problemMessage: 'Do not use List, use IList instead',
    correctionMessage:
        'Use immutable list from fast_immutable_collection instead of List',
  );

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addVariableDeclaration((node) {
      final initializerType = node.initializer?.staticType;

      if (initializerType != null && initializerType.isDartCoreList) {
        reporter.reportErrorForNode(
          NoListRule._code,
          node,
        );
      }
    });
  }

  @override
  List<Fix> getFixes() {
    return [_NoListRuleFix()];
  }
}

class _NoListRuleFix extends DartFix {
  @override
  void run(
    CustomLintResolver resolver,
    ChangeReporter reporter,
    CustomLintContext context,
    AnalysisError analysisError,
    List<AnalysisError> others,
  ) {
    context.registry.addVariableDeclaration((node) {
      if (!analysisError.sourceRange.intersects(node.sourceRange)) {
        return;
      }

      final changeBuilder = reporter.createChangeBuilder(
        message: 'Replace with : IList(${node.initializer})',
        priority: 99,
      );

      changeBuilder.addDartFileEdit((builder) {
        builder.importLibrary(
          Uri.parse('package:fast_immutable_collections/fast_immutable_collections.dart'),
        );

        builder.addSimpleReplacement(
          SourceRange(node.initializer!.offset, node.initializer!.length + 1),
          'IList(${node.initializer});',
        );
      });
    });
  }
}
