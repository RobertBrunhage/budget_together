import 'package:budget_together/Authentication/entities/user_entity.dart';
import 'package:budget_together/Household/entities/category/category_entity.dart';
import 'package:flutter/foundation.dart' hide Category;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'expense_entity.freezed.dart';
part 'expense_entity.g.dart';

@freezed
class ExpenseEntity with _$ExpenseEntity {
  @JsonSerializable(explicitToJson: true)
  factory ExpenseEntity({
    required int id,
    required int amount,
    @JsonKey(name: 'categories') required CategoryEntity category,
    @JsonKey(name: 'profiles') required UserEntity user,
  }) = _ExpenseEntity;

  factory ExpenseEntity.fromJson(Map<String, dynamic> json) =>
      _$ExpenseEntityFromJson(json);
}
