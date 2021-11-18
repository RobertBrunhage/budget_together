import 'dart:io';

import 'package:budget_together/Authentication/login.dart';
import 'package:budget_together/Household/entities/expense/expense_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final expenseRepositoryProvider = Provider<ExpenseRepository>((ref) {
  return ExpenseRepository();
});

class ExpenseRepository {
  Future<List<ExpenseEntity>?> fetchExpenses(int householdId) async {
    final response = await supabase
        .from('expenses')
        .select(
            'id, amount, transaction_date, categories (id, name), profiles (id, name)')
        .eq('household_id', householdId)
        .execute();

    final expenses =
        List.from(response.data).map((e) => ExpenseEntity.fromJson(e)).toList();

    return expenses;
  }

  Future<ExpenseEntity> createExpense(
      ExpenseEntity expense, householdId) async {
    try {
      // TODO: This is not the correct approach. We need to use toJson in some way.
      final response = await supabase.from('expenses').insert({
        'amount': expense.amount,
        'profile_id': expense.user.id,
        'household_id': householdId,
        'transaction_date': expense.transactionDate.toIso8601String(),
        'category_id': expense.category.id,
      }).execute();

      return expense.copyWith(id: response.data[0]['id']);
    } catch (e) {
      throw HttpException(e.toString());
    }
  }

  Future<void> deleteExpense(int expenseId) async {
    try {
      await supabase.from('expenses').delete().eq('id', expenseId).execute();
    } catch (e) {
      throw HttpException(e.toString());
    }
  }
}
