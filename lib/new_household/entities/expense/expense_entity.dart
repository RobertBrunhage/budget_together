import 'package:budget_together/new_authentication/entities/user_entity.dart';
import 'package:budget_together/new_household/entities/category/category_entity.dart';
import 'package:flutter/foundation.dart' hide Category;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'expense_entity.freezed.dart';
part 'expense_entity.g.dart';

@freezed
class ExpenseEntity with _$ExpenseEntity {
  const ExpenseEntity._();
  @JsonSerializable(explicitToJson: true)
  factory ExpenseEntity({
    required int id,
    required int amount,
    @JsonKey(name: 'categories') required CategoryEntity category,
    @JsonKey(name: 'profiles') required UserEntity user,
    @JsonKey(name: 'transaction_date', fromJson: _fromMilliseconds, toJson: _toMilliseconds)
        required DateTime transactionDate,
  }) = _ExpenseEntity;

  factory ExpenseEntity.fromJson(Map<String, dynamic> json) =>
      _$ExpenseEntityFromJson(json);
}

DateTime _fromMilliseconds(int int) => DateTime.fromMillisecondsSinceEpoch(int);
int _toMilliseconds(DateTime time) => time.millisecondsSinceEpoch;
