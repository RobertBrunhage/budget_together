// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'expense.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$ExpenseTearOff {
  const _$ExpenseTearOff();

  _Expense call(
      {required int id,
      required double amount,
      required Category category,
      required User user,
      required DateTime date}) {
    return _Expense(
      id: id,
      amount: amount,
      category: category,
      user: user,
      date: date,
    );
  }
}

/// @nodoc
const $Expense = _$ExpenseTearOff();

/// @nodoc
mixin _$Expense {
  int get id => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;
  Category get category => throw _privateConstructorUsedError;
  User get user => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ExpenseCopyWith<Expense> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExpenseCopyWith<$Res> {
  factory $ExpenseCopyWith(Expense value, $Res Function(Expense) then) =
      _$ExpenseCopyWithImpl<$Res>;
  $Res call(
      {int id, double amount, Category category, User user, DateTime date});

  $CategoryCopyWith<$Res> get category;
  $UserCopyWith<$Res> get user;
}

/// @nodoc
class _$ExpenseCopyWithImpl<$Res> implements $ExpenseCopyWith<$Res> {
  _$ExpenseCopyWithImpl(this._value, this._then);

  final Expense _value;
  // ignore: unused_field
  final $Res Function(Expense) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? amount = freezed,
    Object? category = freezed,
    Object? user = freezed,
    Object? date = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      amount: amount == freezed
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      category: category == freezed
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as Category,
      user: user == freezed
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User,
      date: date == freezed
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }

  @override
  $CategoryCopyWith<$Res> get category {
    return $CategoryCopyWith<$Res>(_value.category, (value) {
      return _then(_value.copyWith(category: value));
    });
  }

  @override
  $UserCopyWith<$Res> get user {
    return $UserCopyWith<$Res>(_value.user, (value) {
      return _then(_value.copyWith(user: value));
    });
  }
}

/// @nodoc
abstract class _$ExpenseCopyWith<$Res> implements $ExpenseCopyWith<$Res> {
  factory _$ExpenseCopyWith(_Expense value, $Res Function(_Expense) then) =
      __$ExpenseCopyWithImpl<$Res>;
  @override
  $Res call(
      {int id, double amount, Category category, User user, DateTime date});

  @override
  $CategoryCopyWith<$Res> get category;
  @override
  $UserCopyWith<$Res> get user;
}

/// @nodoc
class __$ExpenseCopyWithImpl<$Res> extends _$ExpenseCopyWithImpl<$Res>
    implements _$ExpenseCopyWith<$Res> {
  __$ExpenseCopyWithImpl(_Expense _value, $Res Function(_Expense) _then)
      : super(_value, (v) => _then(v as _Expense));

  @override
  _Expense get _value => super._value as _Expense;

  @override
  $Res call({
    Object? id = freezed,
    Object? amount = freezed,
    Object? category = freezed,
    Object? user = freezed,
    Object? date = freezed,
  }) {
    return _then(_Expense(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      amount: amount == freezed
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      category: category == freezed
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as Category,
      user: user == freezed
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User,
      date: date == freezed
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc

class _$_Expense extends _Expense with DiagnosticableTreeMixin {
  _$_Expense(
      {required this.id,
      required this.amount,
      required this.category,
      required this.user,
      required this.date})
      : super._();

  @override
  final int id;
  @override
  final double amount;
  @override
  final Category category;
  @override
  final User user;
  @override
  final DateTime date;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Expense(id: $id, amount: $amount, category: $category, user: $user, date: $date)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Expense'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('amount', amount))
      ..add(DiagnosticsProperty('category', category))
      ..add(DiagnosticsProperty('user', user))
      ..add(DiagnosticsProperty('date', date));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Expense &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.date, date) || other.date == date));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, id, amount, category, user, date);

  @JsonKey(ignore: true)
  @override
  _$ExpenseCopyWith<_Expense> get copyWith =>
      __$ExpenseCopyWithImpl<_Expense>(this, _$identity);
}

abstract class _Expense extends Expense {
  factory _Expense(
      {required int id,
      required double amount,
      required Category category,
      required User user,
      required DateTime date}) = _$_Expense;
  _Expense._() : super._();

  @override
  int get id;
  @override
  double get amount;
  @override
  Category get category;
  @override
  User get user;
  @override
  DateTime get date;
  @override
  @JsonKey(ignore: true)
  _$ExpenseCopyWith<_Expense> get copyWith =>
      throw _privateConstructorUsedError;
}
