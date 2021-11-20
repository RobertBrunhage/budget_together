// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'household_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_HouseholdEntity _$$_HouseholdEntityFromJson(Map<String, dynamic> json) =>
    _$_HouseholdEntity(
      id: json['id'] as int,
      creator: json['creator'] as String,
      name: json['name'] as String,
      expenses: (json['expenses'] as List<dynamic>)
          .map((e) => ExpenseEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_HouseholdEntityToJson(_$_HouseholdEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'creator': instance.creator,
      'name': instance.name,
      'expenses': instance.expenses.map((e) => e.toJson()).toList(),
    };
