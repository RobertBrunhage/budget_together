import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../entities/household/household_entity.dart';
import '../expense/expense.dart';

part 'household.freezed.dart';

@freezed
class Household with _$Household {
  factory Household({
    required int id,
    required String creator,
    required String name,
    required List<Expense> expenses,
  }) = _Household;
  const Household._();

  factory Household.fromEntity(HouseholdEntity householdEntity) {
    return Household(
      id: householdEntity.id,
      creator: householdEntity.creator,
      name: householdEntity.name,
      expenses: householdEntity.expenses.map((expense) => Expense.fromEntity(expense)).toList(),
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
