import 'package:budget_together/Household/entities/expense/expense.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'household.freezed.dart';
part 'household.g.dart';

@freezed
class Household with _$Household {
  @JsonSerializable(explicitToJson: true)
  factory Household({
    required int id,
    required String creator,
    required String name,
    @JsonKey(name: 'expenses') required List<Expense> expenses,
  }) = _Household;

  factory Household.fromJson(Map<String, dynamic> json) =>
      _$HouseholdFromJson(json);
}
