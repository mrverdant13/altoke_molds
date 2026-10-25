/*{% if use_equatable -%}*/
import 'package:equatable/equatable.dart';
/*{% endif %}*/
/*{%- if use_meta -%}*/
import 'package:meta/meta.dart';

/*{% endif -%}*/
/*{%- if use_overrides -%}*/
/// {@template common.optional}
/// A representation of an optional value.
/// {@endtemplate}
@immutable
sealed class Optional<T extends Object?> {
  /// {@macro common.optional}
  const Optional();

  /// Creates an [Optional] with a present value.
  const factory Optional.some(T value) = Some<T>;

  /// Creates an [Optional] with an absent value.
  const factory Optional.none() = None<T>;

  Type get _typeArgument => T;
}

/// {@template common.some}
/// A representation of a present value.
/// {@endtemplate}
@immutable
class Some<T extends Object?> extends Optional<T> {
  /// {@macro common.some}
  const Some(this.value);

  /// The underlying value.
  final T value;

  @override
  String toString() => 'Some<$T>(value: $value)';

  @override
  bool operator ==(Object other) {
    if (other is! Some) return false;
    if (other._typeArgument != T) return false;
    if (identical(this, other)) return true;
    return other.value == value;
  }

  @override
  int get hashCode => Object.hashAll([Some, T, value]);
}

/// {@template common.none}
/// A representation of an absent value.
/// {@endtemplate}
@immutable
class None<T extends Object?> extends Optional<T> {
  /// {@macro common.none}
  const None();

  @override
  String toString() => 'None<$T>()';

  @override
  bool operator ==(Object other) {
    if (other is! None) return false;
    if (other._typeArgument != T) return false;
    return true;
  }

  @override
  int get hashCode => Object.hashAll([None, T]);
}

/*x{% endif %}*/
/*{%- if use_equatable %}*/
/// {@template common.optional}
/// A representation of an optional value.
/// {@endtemplate}
sealed class EOptional<T extends Object?> extends Equatable {
  /// {@macro common.optional}
  const EOptional();

  /// Creates an [EOptional] with a present value.
  const factory EOptional.some(T value) = ESome<T>;

  /// Creates an [EOptional] with an absent value.
  const factory EOptional.none() = ENone<T>;
}

/// {@template common.some}
/// A representation of a present value.
/// {@endtemplate}
class ESome<T extends Object?> extends EOptional<T> {
  /// {@macro common.some}
  const ESome(this.value);

  /// The underlying value.
  final T value;

  @override
  String toString() => 'ESome<$T>(value: $value)';

  /// The values used to determine equality.
  @override
  List<Object?> get props => [value];
}

/// {@template common.none}
/// A representation of an absent value.
/// {@endtemplate}
class ENone<T extends Object?> extends EOptional<T> {
  /// {@macro common.none}
  const ENone();

  @override
  String toString() => 'ENone<$T>()';

  /// The values used to determine equality.
  @override
  List<Object?> get props => const [];
}
/*x{% endif %}*/
