import 'package:budget_together/Authentication/entities/user.dart';
import 'package:budget_together/Household/entities/category/category.dart';
import 'package:flutter/foundation.dart' hide Category;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'expense.freezed.dart';
part 'expense.g.dart';

@freezed
class Expense with _$Expense {
  @JsonSerializable(explicitToJson: true)
  factory Expense({
    required int id,
    required int amount,
    @JsonKey(name: 'categories') required Category category,
    @JsonKey(name: 'profiles') required User user,
  }) = _Expense;

  factory Expense.fromJson(Map<String, dynamic> json) =>
      _$ExpenseFromJson(json);
}
