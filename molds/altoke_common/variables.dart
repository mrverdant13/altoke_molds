import 'package:altoke_common/value_equality_approach.dart';
import 'package:foundry_core/foundry_core.dart';

final moldVariables = FoundryVariableGroup(
  variables: {
    ValueEqualityApproach.variableKey: FoundrySingleChoiceVariable<String>(
      label: 'What approach to use for value equality?',
      description: 'The approach to use for value equality.',
      options: [
        for (final approach in ValueEqualityApproach.values) approach.id,
      ],
      displayLabel: _displayValueEqualityApproach,
      defaultValue: (_) => ValueEqualityApproach.defaultApproach.id,
    ),
  },
);

String _displayValueEqualityApproach(String id) {
  return ValueEqualityApproach.byId(id)?.label ?? id;
}
