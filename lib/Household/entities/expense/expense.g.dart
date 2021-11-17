// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Expense _$$_ExpenseFromJson(Map<String, dynamic> json) => _$_Expense(
      id: json['id'] as int,
      amount: json['amount'] as int,
      category: Category.fromJson(json['categories'] as Map<String, dynamic>),
      user: User.fromJson(json['profiles'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_ExpenseToJson(_$_Expense instance) =>
    <String, dynamic>{
      'id': instance.id,
      'amount': instance.amount,
      'categories': instance.category.toJson(),
      'profiles': instance.user.toJson(),
    };
