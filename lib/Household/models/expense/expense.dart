import 'package:budget_together/Authentication/models/user.dart';
import 'package:budget_together/Household/entities/expense/expense_entity.dart';
import 'package:budget_together/Household/models/category/category.dart';
import 'package:flutter/foundation.dart' hide Category;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'expense.freezed.dart';

@freezed
class Expense with _$Expense {
  const Expense._();
  factory Expense({
    required int id,
    required double amount,
    required Category category,
    required User user,
    required DateTime date,
  }) = _Expense;

  factory Expense.fromEntity(ExpenseEntity expenseEntity) {
    return Expense(
      id: expenseEntity.id,
      amount: (expenseEntity.amount / 100),
      category: Category.fromEntity(expenseEntity.category),
      user: User.fromEntity(expenseEntity.user),
      date: expenseEntity.transactionDate,
    );
  }

  ExpenseEntity toEntity() {
    return ExpenseEntity(
      id: id,
      amount: (amount * 100).toInt(),
      category: category.toEntity(),
      user: user.toEntity(),
      transactionDate: date,
    );
  }
}
