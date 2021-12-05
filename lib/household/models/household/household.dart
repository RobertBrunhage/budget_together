import 'package:budget_together/household/entities/household/household_entity.dart';
import 'package:budget_together/household/models/expense/expense.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'household.freezed.dart';

@freezed
class Household with _$Household {
  const Household._();
  factory Household({
    required int id,
    required String creator,
    required String name,
    required List<Expense> expenses,
  }) = _Household;

  factory Household.fromEntity(HouseholdEntity householdEntity) {
    return Household(
      id: householdEntity.id,
      creator: householdEntity.creator,
      name: householdEntity.name,
      expenses: householdEntity.expenses
          .map((expense) => Expense.fromEntity(expense))
          .toList(),
    );
  }

  double get spentThisMonth {
    return expenses.fold<double>(0, (previousValue, element) {
      if (element.date.month == DateTime.now().month) {
        return previousValue + element.amount;
      }
      return previousValue;
    });
  }

  HouseholdEntity toEntity() {
    return HouseholdEntity(
      id: id,
      creator: creator,
      name: name,
      expenses: expenses.map((expense) => expense.toEntity()).toList(),
    );
  }
}
