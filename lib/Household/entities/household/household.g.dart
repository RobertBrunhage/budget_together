// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'household.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Household _$$_HouseholdFromJson(Map<String, dynamic> json) => _$_Household(
      id: json['id'] as int,
      creator: json['creator'] as String,
      name: json['name'] as String,
      expenses: (json['expenses'] as List<dynamic>)
          .map((e) => Expense.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_HouseholdToJson(_$_Household instance) =>
    <String, dynamic>{
      'id': instance.id,
      'creator': instance.creator,
      'name': instance.name,
      'expenses': instance.expenses.map((e) => e.toJson()).toList(),
    };
