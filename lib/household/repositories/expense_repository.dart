import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../authentication/login_view.dart';
import '../entities/expense/expense_entity.dart';

final expenseRepositoryProvider = Provider<ExpenseRepository>((final ref) {
  return ExpenseRepository();
});

class ExpenseRepository {
  Future<List<ExpenseEntity>?> fetchExpenses(
    final int householdId,
    final DateTime startDate,
    final DateTime endDate,
  ) async {
    final response = await supabase
        .from('expenses')
        .select('id, amount, transaction_date, categories (id, name), profiles (id, name)')
        .eq('household_id', householdId)
        .gte('transaction_date', startDate.millisecondsSinceEpoch)
        .lte('transaction_date', endDate.millisecondsSinceEpoch)
        .execute();

    final data = List<Map<String, dynamic>>.from(response.data as List<Map<String, dynamic>>);

    final expenses = data.map((final e) => ExpenseEntity.fromJson(e)).toList();
    return expenses;
  }

  Future<ExpenseEntity> createExpense(final ExpenseEntity expense, final int householdId) async {
    // TODO(Robert): This is not the correct approach. We need to use toJson in some way.
    final response = await supabase.from('expenses').insert(<String, dynamic>{
      'amount': expense.amount,
      'profile_id': expense.user.id,
      'household_id': householdId,
      'transaction_date': expense.transactionDate.millisecondsSinceEpoch,
      'category_id': expense.category.id,
    }).execute();

    if (response.error != null) {
      throw HttpException(response.error!.message);
    }

    final data = List<Map<String, dynamic>>.from(response.data as List<Map<String, dynamic>>);

    return expense.copyWith(id: data[0]['id']! as int);
  }

  Future<void> deleteExpense(final int expenseId) async {
    final response = await supabase.from('expenses').delete().eq('id', expenseId).execute();
    if (response.error != null) {
      throw HttpException(response.error!.message);
    }
  }
}
