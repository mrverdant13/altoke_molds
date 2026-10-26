/*remove-start*/
// freezed_annotation exports the same elements while every approach shares
// this file.
// ignore_for_file: unnecessary_import
/*remove-end-x*/
/*{% if use_dart_mappable -%}*/
import 'package:dart_mappable/dart_mappable.dart';
/*{% endif %}*/
/*{%- if use_equatable -%}*/
import 'package:equatable/equatable.dart';
/*{% endif %}*/
/*{%- if use_freezed -%}*/
import 'package:freezed_annotation/freezed_annotation.dart';
/*{% endif %}*/
/*{%- if use_meta -%}*/
import 'package:meta/meta.dart';

/*{% endif -%}*/
/*{%- if use_freezed %}*/
part 'optional.freezed.dart';

/*{% endif %}*/
/*{%- if use_dart_mappable %}*/
part 'optional.mapper.dart';

/*{% endif %}*/
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
/*{%- if use_dart_mappable %}*/
/// {@template common.optional}
/// A representation of an optional value.
/// {@endtemplate}
@MappableClass()
@immutable
sealed class DmOptional<T extends Object?> with DmOptionalMappable<T> {
  /// {@macro common.optional}
  const DmOptional();

  /// Creates an [DmOptional] with a present value.
  const factory DmOptional.some(T value) = DmSome<T>;

  /// Creates an [DmOptional] with an absent value.
  const factory DmOptional.none() = DmNone<T>;

  Type get _typeArgument => T;
}

/// {@template common.some}
/// A representation of a present value.
/// {@endtemplate}
@MappableClass()
@immutable
class DmSome<T extends Object?> extends DmOptional<T> with DmSomeMappable<T> {
  /// {@macro common.some}
  const DmSome(this.value);

  /// The underlying value.
  final T value;

  // dart_mappable compares `runtimeType.base`, which drops type arguments,
  // and hashes only the fields. These operators compare `T` as well.
  @override
  bool operator ==(Object other) {
    if (other is! DmSome) return false;
    if (other._typeArgument != T) return false;
    if (identical(this, other)) return true;
    return other.value == value;
  }

  @override
  int get hashCode => Object.hashAll([DmSome, T, value]);
}

/// {@template common.none}
/// A representation of an absent value.
/// {@endtemplate}
@MappableClass()
@immutable
class DmNone<T extends Object?> extends DmOptional<T> with DmNoneMappable<T> {
  /// {@macro common.none}
  const DmNone();

  // dart_mappable compares `runtimeType.base`, which drops type arguments,
  // and hashes only the fields. These operators compare `T` as well.
  @override
  bool operator ==(Object other) {
    if (other is! DmNone) return false;
    if (other._typeArgument != T) return false;
    return true;
  }

  @override
  int get hashCode => Object.hashAll([DmNone, T]);
}

/*x{% endif %}*/
/*{%- if use_freezed %}*/
/// {@template common.optional}
/// A representation of an optional value.
/// {@endtemplate}
@Freezed(copyWith: false)
class FOptional<T extends Object?> with _$FOptional<T> {
  /// {@macro common.optional}
  const FOptional._();

  /// Creates an [FOptional] with a present value.
  const factory FOptional.some(
    /// The underlying value.
    T value,
  ) = FSome<T>;

  /// Creates an [FOptional] with an absent value.
  const factory FOptional.none() = FNone<T>;
}
/*x{% endif %}*/
