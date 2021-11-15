import 'dart:io';

import 'package:budget_together/Authentication/login.dart';
import 'package:budget_together/Household/expense.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final expenseRepositoryProvider = Provider<ExpenseRepository>((ref) {
  return ExpenseRepository();
});

class ExpenseRepository {
  Future<List<Expense>?> fetchExpenses(int householdId) async {
    final response = await supabase
        .from('expenses')
        .select('id, amount, categories (id, name), profiles (id, name)')
        .eq('household_id', householdId)
        .execute();

    final expenses =
        List.from(response.data).map((e) => Expense.fromMap(e)).toList();

    return expenses;
  }

  Future<Expense> createExpense(Expense expense, householdId) async {
    try {
      final response = await supabase.from('expenses').insert({
        'amount': expense.amount,
        'profile_id': expense.user.id,
        'household_id': householdId,
        'transaction_date': DateTime.now().toIso8601String(),
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
