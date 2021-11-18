import 'package:budget_together/Household/entities/household/household_entity.dart';
import 'package:budget_together/Household/models/expense/expense.dart';
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

  HouseholdEntity toEntity() {
    return HouseholdEntity(
      id: id,
      creator: creator,
      name: name,
      expenses: expenses.map((expense) => expense.toEntity()).toList(),
    );
  }
}
