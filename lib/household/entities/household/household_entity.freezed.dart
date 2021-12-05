// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'household_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

HouseholdEntity _$HouseholdEntityFromJson(Map<String, dynamic> json) {
  return _HouseholdEntity.fromJson(json);
}

/// @nodoc
class _$HouseholdEntityTearOff {
  const _$HouseholdEntityTearOff();

  _HouseholdEntity call(
      {required int id,
      required String creator,
      required String name,
      @JsonKey(name: 'expenses') required List<ExpenseEntity> expenses}) {
    return _HouseholdEntity(
      id: id,
      creator: creator,
      name: name,
      expenses: expenses,
    );
  }

  HouseholdEntity fromJson(Map<String, Object?> json) {
    return HouseholdEntity.fromJson(json);
  }
}

/// @nodoc
const $HouseholdEntity = _$HouseholdEntityTearOff();

/// @nodoc
mixin _$HouseholdEntity {
  int get id => throw _privateConstructorUsedError;
  String get creator => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'expenses')
  List<ExpenseEntity> get expenses => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $HouseholdEntityCopyWith<HouseholdEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HouseholdEntityCopyWith<$Res> {
  factory $HouseholdEntityCopyWith(
          HouseholdEntity value, $Res Function(HouseholdEntity) then) =
      _$HouseholdEntityCopyWithImpl<$Res>;
  $Res call(
      {int id,
      String creator,
      String name,
      @JsonKey(name: 'expenses') List<ExpenseEntity> expenses});
}

/// @nodoc
class _$HouseholdEntityCopyWithImpl<$Res>
    implements $HouseholdEntityCopyWith<$Res> {
  _$HouseholdEntityCopyWithImpl(this._value, this._then);

  final HouseholdEntity _value;
  // ignore: unused_field
  final $Res Function(HouseholdEntity) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? creator = freezed,
    Object? name = freezed,
    Object? expenses = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      creator: creator == freezed
          ? _value.creator
          : creator // ignore: cast_nullable_to_non_nullable
              as String,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      expenses: expenses == freezed
          ? _value.expenses
          : expenses // ignore: cast_nullable_to_non_nullable
              as List<ExpenseEntity>,
    ));
  }
}

/// @nodoc
abstract class _$HouseholdEntityCopyWith<$Res>
    implements $HouseholdEntityCopyWith<$Res> {
  factory _$HouseholdEntityCopyWith(
          _HouseholdEntity value, $Res Function(_HouseholdEntity) then) =
      __$HouseholdEntityCopyWithImpl<$Res>;
  @override
  $Res call(
      {int id,
      String creator,
      String name,
      @JsonKey(name: 'expenses') List<ExpenseEntity> expenses});
}

/// @nodoc
class __$HouseholdEntityCopyWithImpl<$Res>
    extends _$HouseholdEntityCopyWithImpl<$Res>
    implements _$HouseholdEntityCopyWith<$Res> {
  __$HouseholdEntityCopyWithImpl(
      _HouseholdEntity _value, $Res Function(_HouseholdEntity) _then)
      : super(_value, (v) => _then(v as _HouseholdEntity));

  @override
  _HouseholdEntity get _value => super._value as _HouseholdEntity;

  @override
  $Res call({
    Object? id = freezed,
    Object? creator = freezed,
    Object? name = freezed,
    Object? expenses = freezed,
  }) {
    return _then(_HouseholdEntity(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      creator: creator == freezed
          ? _value.creator
          : creator // ignore: cast_nullable_to_non_nullable
              as String,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      expenses: expenses == freezed
          ? _value.expenses
          : expenses // ignore: cast_nullable_to_non_nullable
              as List<ExpenseEntity>,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_HouseholdEntity
    with DiagnosticableTreeMixin
    implements _HouseholdEntity {
  _$_HouseholdEntity(
      {required this.id,
      required this.creator,
      required this.name,
      @JsonKey(name: 'expenses') required this.expenses});

  factory _$_HouseholdEntity.fromJson(Map<String, dynamic> json) =>
      _$$_HouseholdEntityFromJson(json);

  @override
  final int id;
  @override
  final String creator;
  @override
  final String name;
  @override
  @JsonKey(name: 'expenses')
  final List<ExpenseEntity> expenses;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'HouseholdEntity(id: $id, creator: $creator, name: $name, expenses: $expenses)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'HouseholdEntity'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('creator', creator))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('expenses', expenses));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _HouseholdEntity &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.creator, creator) || other.creator == creator) &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality().equals(other.expenses, expenses));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, creator, name,
      const DeepCollectionEquality().hash(expenses));

  @JsonKey(ignore: true)
  @override
  _$HouseholdEntityCopyWith<_HouseholdEntity> get copyWith =>
      __$HouseholdEntityCopyWithImpl<_HouseholdEntity>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_HouseholdEntityToJson(this);
  }
}

abstract class _HouseholdEntity implements HouseholdEntity {
  factory _HouseholdEntity(
          {required int id,
          required String creator,
          required String name,
          @JsonKey(name: 'expenses') required List<ExpenseEntity> expenses}) =
      _$_HouseholdEntity;

  factory _HouseholdEntity.fromJson(Map<String, dynamic> json) =
      _$_HouseholdEntity.fromJson;

  @override
  int get id;
  @override
  String get creator;
  @override
  String get name;
  @override
  @JsonKey(name: 'expenses')
  List<ExpenseEntity> get expenses;
  @override
  @JsonKey(ignore: true)
  _$HouseholdEntityCopyWith<_HouseholdEntity> get copyWith =>
      throw _privateConstructorUsedError;
}
