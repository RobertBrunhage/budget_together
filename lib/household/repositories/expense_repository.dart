import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supa;

import '../../authentication/supabase/supabase_provider.dart';
import '../../core/error_handling/supabase_exception.dart';
import '../entities/expense/expense_entity.dart';

final expenseRepositoryProvider = Provider<ExpenseRepository>((final ref) {
  return ExpenseRepository(
    ref.watch(supabaseProvider),
  );
});

class ExpenseRepository {
  ExpenseRepository(this._supabaseClient);

  final supa.SupabaseClient _supabaseClient;
  Future<List<ExpenseEntity>?> fetchExpenses(
    final int householdId,
    final DateTime startDate,
    final DateTime endDate,
  ) async {
    final response = await _supabaseClient
        .from('expenses')
        .select('id, amount, transaction_date, categories (id, name), profiles (id, name)')
        .eq('household_id', householdId)
        .gte('transaction_date', startDate.millisecondsSinceEpoch)
        .lte('transaction_date', endDate.millisecondsSinceEpoch)
        .execute();

    if (response.error != null) {
      throw SupabaseException(response.error!);
    }

    final data = List<Map<String, dynamic>>.from(response.data as List<dynamic>);

    final expenses = data.map((final e) => ExpenseEntity.fromJson(e)).toList();
    return expenses;
  }

  Future<ExpenseEntity> createExpense(final ExpenseEntity expense, final int householdId) async {
    // TODO(Robert): This is not the correct approach. We need to use toJson in some way.
    final response = await _supabaseClient.from('expenses').insert(<String, dynamic>{
      'amount': expense.amount,
      'profile_id': expense.user.id,
      'household_id': householdId,
      'transaction_date': expense.transactionDate.millisecondsSinceEpoch,
      'category_id': expense.category.id,
    }).execute();

    if (response.error != null) {
      throw SupabaseException(response.error!);
    }

    final data = List<Map<String, dynamic>>.from(response.data as List<dynamic>);

    return expense.copyWith(id: data[0]['id']! as int);
  }

  Future<void> deleteExpense(final int expenseId) async {
    final response = await _supabaseClient.from('expenses').delete().eq('id', expenseId).execute();
    if (response.error != null) {
      throw SupabaseException(response.error!);
    }
  }
}
