/// Value-equality approaches the mold can generate.
enum ValueEqualityApproach {
  /// `dart_mappable` value equality.
  dartMappable(
    id: 'dart_mappable',
    label: 'dart_mappable',
    usesMeta: true,
    usesCodeGeneration: true,
  ),

  /// Manual `==` and `hashCode` overrides.
  overrides(
    id: 'overrides',
    label: 'Overrides',
    usesMeta: true,
    usesCodeGeneration: false,
  ),

  /// `Equatable` value equality.
  equatable(
    id: 'equatable',
    label: 'Equatable',
    usesMeta: false,
    usesCodeGeneration: false,
  ),

  /// `freezed` value equality.
  freezed(
    id: 'freezed',
    label: 'freezed',
    usesMeta: false,
    usesCodeGeneration: true,
  );

  /// Creates an approach identified by [id].
  const ValueEqualityApproach({
    required this.id,
    required this.label,
    this.usesMeta = false,
    this.usesCodeGeneration = false,
  });

  /// Context key for the selected approach.
  static const variableKey = 'value_equality_approach';

  /// Approach used when the caller does not choose one.
  static const defaultApproach = ValueEqualityApproach.dartMappable;

  /// Stable value stored for this approach.
  final String id;

  /// Label shown when asking for an approach.
  final String label;

  /// Whether generated code depends on `package:meta`.
  final bool usesMeta;

  /// Whether generated code runs `build_runner`.
  final bool usesCodeGeneration;

  /// Returns the approach whose [id] is [value], if one exists.
  static ValueEqualityApproach? byId(String value) {
    for (final approach in values) {
      if (approach.id == value) {
        return approach;
      }
    }
    return null;
  }
}
