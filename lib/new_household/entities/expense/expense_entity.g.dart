// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ExpenseEntity _$$_ExpenseEntityFromJson(Map<String, dynamic> json) =>
    _$_ExpenseEntity(
      id: json['id'] as int,
      amount: json['amount'] as int,
      category:
          CategoryEntity.fromJson(json['categories'] as Map<String, dynamic>),
      user: UserEntity.fromJson(json['profiles'] as Map<String, dynamic>),
      transactionDate: DateTime.parse(json['transaction_date'] as String),
    );

Map<String, dynamic> _$$_ExpenseEntityToJson(_$_ExpenseEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'amount': instance.amount,
      'categories': instance.category.toJson(),
      'profiles': instance.user.toJson(),
      'transaction_date': instance.transactionDate.toIso8601String(),
    };
