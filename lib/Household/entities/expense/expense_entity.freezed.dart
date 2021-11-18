// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'expense_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ExpenseEntity _$ExpenseEntityFromJson(Map<String, dynamic> json) {
  return _ExpenseEntity.fromJson(json);
}

/// @nodoc
class _$ExpenseEntityTearOff {
  const _$ExpenseEntityTearOff();

  _ExpenseEntity call(
      {required int id,
      required int amount,
      @JsonKey(name: 'categories') required CategoryEntity category,
      @JsonKey(name: 'profiles') required UserEntity user,
      @JsonKey(name: 'transaction_date') required DateTime transactionDate}) {
    return _ExpenseEntity(
      id: id,
      amount: amount,
      category: category,
      user: user,
      transactionDate: transactionDate,
    );
  }

  ExpenseEntity fromJson(Map<String, Object?> json) {
    return ExpenseEntity.fromJson(json);
  }
}

/// @nodoc
const $ExpenseEntity = _$ExpenseEntityTearOff();

/// @nodoc
mixin _$ExpenseEntity {
  int get id => throw _privateConstructorUsedError;
  int get amount => throw _privateConstructorUsedError;
  @JsonKey(name: 'categories')
  CategoryEntity get category => throw _privateConstructorUsedError;
  @JsonKey(name: 'profiles')
  UserEntity get user => throw _privateConstructorUsedError;
  @JsonKey(name: 'transaction_date')
  DateTime get transactionDate => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ExpenseEntityCopyWith<ExpenseEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExpenseEntityCopyWith<$Res> {
  factory $ExpenseEntityCopyWith(
          ExpenseEntity value, $Res Function(ExpenseEntity) then) =
      _$ExpenseEntityCopyWithImpl<$Res>;
  $Res call(
      {int id,
      int amount,
      @JsonKey(name: 'categories') CategoryEntity category,
      @JsonKey(name: 'profiles') UserEntity user,
      @JsonKey(name: 'transaction_date') DateTime transactionDate});

  $CategoryEntityCopyWith<$Res> get category;
  $UserEntityCopyWith<$Res> get user;
}

/// @nodoc
class _$ExpenseEntityCopyWithImpl<$Res>
    implements $ExpenseEntityCopyWith<$Res> {
  _$ExpenseEntityCopyWithImpl(this._value, this._then);

  final ExpenseEntity _value;
  // ignore: unused_field
  final $Res Function(ExpenseEntity) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? amount = freezed,
    Object? category = freezed,
    Object? user = freezed,
    Object? transactionDate = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      amount: amount == freezed
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int,
      category: category == freezed
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as CategoryEntity,
      user: user == freezed
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserEntity,
      transactionDate: transactionDate == freezed
          ? _value.transactionDate
          : transactionDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }

  @override
  $CategoryEntityCopyWith<$Res> get category {
    return $CategoryEntityCopyWith<$Res>(_value.category, (value) {
      return _then(_value.copyWith(category: value));
    });
  }

  @override
  $UserEntityCopyWith<$Res> get user {
    return $UserEntityCopyWith<$Res>(_value.user, (value) {
      return _then(_value.copyWith(user: value));
    });
  }
}

/// @nodoc
abstract class _$ExpenseEntityCopyWith<$Res>
    implements $ExpenseEntityCopyWith<$Res> {
  factory _$ExpenseEntityCopyWith(
          _ExpenseEntity value, $Res Function(_ExpenseEntity) then) =
      __$ExpenseEntityCopyWithImpl<$Res>;
  @override
  $Res call(
      {int id,
      int amount,
      @JsonKey(name: 'categories') CategoryEntity category,
      @JsonKey(name: 'profiles') UserEntity user,
      @JsonKey(name: 'transaction_date') DateTime transactionDate});

  @override
  $CategoryEntityCopyWith<$Res> get category;
  @override
  $UserEntityCopyWith<$Res> get user;
}

/// @nodoc
class __$ExpenseEntityCopyWithImpl<$Res>
    extends _$ExpenseEntityCopyWithImpl<$Res>
    implements _$ExpenseEntityCopyWith<$Res> {
  __$ExpenseEntityCopyWithImpl(
      _ExpenseEntity _value, $Res Function(_ExpenseEntity) _then)
      : super(_value, (v) => _then(v as _ExpenseEntity));

  @override
  _ExpenseEntity get _value => super._value as _ExpenseEntity;

  @override
  $Res call({
    Object? id = freezed,
    Object? amount = freezed,
    Object? category = freezed,
    Object? user = freezed,
    Object? transactionDate = freezed,
  }) {
    return _then(_ExpenseEntity(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      amount: amount == freezed
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int,
      category: category == freezed
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as CategoryEntity,
      user: user == freezed
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserEntity,
      transactionDate: transactionDate == freezed
          ? _value.transactionDate
          : transactionDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_ExpenseEntity with DiagnosticableTreeMixin implements _ExpenseEntity {
  _$_ExpenseEntity(
      {required this.id,
      required this.amount,
      @JsonKey(name: 'categories') required this.category,
      @JsonKey(name: 'profiles') required this.user,
      @JsonKey(name: 'transaction_date') required this.transactionDate});

  factory _$_ExpenseEntity.fromJson(Map<String, dynamic> json) =>
      _$$_ExpenseEntityFromJson(json);

  @override
  final int id;
  @override
  final int amount;
  @override
  @JsonKey(name: 'categories')
  final CategoryEntity category;
  @override
  @JsonKey(name: 'profiles')
  final UserEntity user;
  @override
  @JsonKey(name: 'transaction_date')
  final DateTime transactionDate;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ExpenseEntity(id: $id, amount: $amount, category: $category, user: $user, transactionDate: $transactionDate)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ExpenseEntity'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('amount', amount))
      ..add(DiagnosticsProperty('category', category))
      ..add(DiagnosticsProperty('user', user))
      ..add(DiagnosticsProperty('transactionDate', transactionDate));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ExpenseEntity &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.transactionDate, transactionDate) ||
                other.transactionDate == transactionDate));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, id, amount, category, user, transactionDate);

  @JsonKey(ignore: true)
  @override
  _$ExpenseEntityCopyWith<_ExpenseEntity> get copyWith =>
      __$ExpenseEntityCopyWithImpl<_ExpenseEntity>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ExpenseEntityToJson(this);
  }
}

abstract class _ExpenseEntity implements ExpenseEntity {
  factory _ExpenseEntity(
      {required int id,
      required int amount,
      @JsonKey(name: 'categories')
          required CategoryEntity category,
      @JsonKey(name: 'profiles')
          required UserEntity user,
      @JsonKey(name: 'transaction_date')
          required DateTime transactionDate}) = _$_ExpenseEntity;

  factory _ExpenseEntity.fromJson(Map<String, dynamic> json) =
      _$_ExpenseEntity.fromJson;

  @override
  int get id;
  @override
  int get amount;
  @override
  @JsonKey(name: 'categories')
  CategoryEntity get category;
  @override
  @JsonKey(name: 'profiles')
  UserEntity get user;
  @override
  @JsonKey(name: 'transaction_date')
  DateTime get transactionDate;
  @override
  @JsonKey(ignore: true)
  _$ExpenseEntityCopyWith<_ExpenseEntity> get copyWith =>
      throw _privateConstructorUsedError;
}
