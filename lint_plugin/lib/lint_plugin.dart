import 'package:custom_lint_builder/custom_lint_builder.dart';
import 'package:lint_plugin/src/rules/first_where_usage_rule.dart';
import 'package:lint_plugin/src/rules/no_list_rule.dart';

PluginBase createPlugin() => _LintPlugin();

class _LintPlugin extends PluginBase {
  @override
  List<LintRule> getLintRules(CustomLintConfigs configs) {
    return [
      FirstWhereUsageRule(),
      NoListRule(),
    ];
  }
}