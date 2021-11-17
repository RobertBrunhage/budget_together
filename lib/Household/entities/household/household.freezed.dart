// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'household.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Household _$HouseholdFromJson(Map<String, dynamic> json) {
  return _Household.fromJson(json);
}

/// @nodoc
class _$HouseholdTearOff {
  const _$HouseholdTearOff();

  _Household call(
      {required int id,
      required String creator,
      required String name,
      @JsonKey(name: 'expenses') required List<Expense> expenses}) {
    return _Household(
      id: id,
      creator: creator,
      name: name,
      expenses: expenses,
    );
  }

  Household fromJson(Map<String, Object?> json) {
    return Household.fromJson(json);
  }
}

/// @nodoc
const $Household = _$HouseholdTearOff();

/// @nodoc
mixin _$Household {
  int get id => throw _privateConstructorUsedError;
  String get creator => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'expenses')
  List<Expense> get expenses => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $HouseholdCopyWith<Household> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HouseholdCopyWith<$Res> {
  factory $HouseholdCopyWith(Household value, $Res Function(Household) then) =
      _$HouseholdCopyWithImpl<$Res>;
  $Res call(
      {int id,
      String creator,
      String name,
      @JsonKey(name: 'expenses') List<Expense> expenses});
}

/// @nodoc
class _$HouseholdCopyWithImpl<$Res> implements $HouseholdCopyWith<$Res> {
  _$HouseholdCopyWithImpl(this._value, this._then);

  final Household _value;
  // ignore: unused_field
  final $Res Function(Household) _then;

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
              as List<Expense>,
    ));
  }
}

/// @nodoc
abstract class _$HouseholdCopyWith<$Res> implements $HouseholdCopyWith<$Res> {
  factory _$HouseholdCopyWith(
          _Household value, $Res Function(_Household) then) =
      __$HouseholdCopyWithImpl<$Res>;
  @override
  $Res call(
      {int id,
      String creator,
      String name,
      @JsonKey(name: 'expenses') List<Expense> expenses});
}

/// @nodoc
class __$HouseholdCopyWithImpl<$Res> extends _$HouseholdCopyWithImpl<$Res>
    implements _$HouseholdCopyWith<$Res> {
  __$HouseholdCopyWithImpl(_Household _value, $Res Function(_Household) _then)
      : super(_value, (v) => _then(v as _Household));

  @override
  _Household get _value => super._value as _Household;

  @override
  $Res call({
    Object? id = freezed,
    Object? creator = freezed,
    Object? name = freezed,
    Object? expenses = freezed,
  }) {
    return _then(_Household(
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
              as List<Expense>,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_Household with DiagnosticableTreeMixin implements _Household {
  _$_Household(
      {required this.id,
      required this.creator,
      required this.name,
      @JsonKey(name: 'expenses') required this.expenses});

  factory _$_Household.fromJson(Map<String, dynamic> json) =>
      _$$_HouseholdFromJson(json);

  @override
  final int id;
  @override
  final String creator;
  @override
  final String name;
  @override
  @JsonKey(name: 'expenses')
  final List<Expense> expenses;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Household(id: $id, creator: $creator, name: $name, expenses: $expenses)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Household'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('creator', creator))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('expenses', expenses));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Household &&
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
  _$HouseholdCopyWith<_Household> get copyWith =>
      __$HouseholdCopyWithImpl<_Household>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_HouseholdToJson(this);
  }
}

abstract class _Household implements Household {
  factory _Household(
          {required int id,
          required String creator,
          required String name,
          @JsonKey(name: 'expenses') required List<Expense> expenses}) =
      _$_Household;

  factory _Household.fromJson(Map<String, dynamic> json) =
      _$_Household.fromJson;

  @override
  int get id;
  @override
  String get creator;
  @override
  String get name;
  @override
  @JsonKey(name: 'expenses')
  List<Expense> get expenses;
  @override
  @JsonKey(ignore: true)
  _$HouseholdCopyWith<_Household> get copyWith =>
      throw _privateConstructorUsedError;
}
