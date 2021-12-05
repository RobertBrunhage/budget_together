import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../expense/expense_entity.dart';

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

  factory HouseholdEntity.fromJson(Map<String, dynamic> json) => _$HouseholdEntityFromJson(json);
}
