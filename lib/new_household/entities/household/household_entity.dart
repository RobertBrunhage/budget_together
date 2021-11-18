import 'package:budget_together/new_household/entities/expense/expense_entity.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'household_entity.freezed.dart';
part 'household_entity.g.dart';

@freezed
class HouseholdEntity with _$HouseholdEntity {
  @JsonSerializable(explicitToJson: true)
  factory HouseholdEntity({
    required int id,
    required String creator,
    required String name,
    @JsonKey(name: 'expenses') required List<ExpenseEntity> expenses,
  }) = _HouseholdEntity;

  factory HouseholdEntity.fromJson(Map<String, dynamic> json) =>
      _$HouseholdEntityFromJson(json);
}
