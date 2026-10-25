import 'package:altoke_common/value_equality_approach.dart';
import 'package:foundry_core/foundry_core.dart';

Future<void> run(FoundryContext context) async {
  context.set('requirements_met', true);

  final selectedId = context.requiredString(ValueEqualityApproach.variableKey);
  final selected = ValueEqualityApproach.byId(selectedId);
  if (selected == null) {
    throw FoundryHookException(
      'Unknown value equality approach "$selectedId".',
    );
  }

  for (final approach in ValueEqualityApproach.values) {
    context.set('use_${approach.id}', approach == selected);
  }
  context.set('use_meta', selected.usesMeta);
  context.set('use_code_generation', selected.usesCodeGeneration);
}
