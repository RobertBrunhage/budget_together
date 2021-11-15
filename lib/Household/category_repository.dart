import 'dart:io';

import 'package:budget_together/Authentication/login.dart';
import 'package:budget_together/Household/category.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final categoryRepositoryProvider = Provider<CategoryRepository>((ref) {
  return CategoryRepository();
});

class CategoryRepository {
  Future<List<Category>?> fetchCategories(int householdId) async {
    final response = await supabase
        .from('categories')
        .select('id, name')
        .eq('household_id', householdId)
        .execute();

    final categories =
        List.from(response.data).map((e) => Category.fromMap(e)).toList();

    return categories;
  }

  Future<Category> createCategory(Category category, householdId) async {
    try {
      final response = await supabase.from('categories').upsert({
        'household_id': householdId,
        'name': category.name,
      }).execute();

      return Category.fromMap(response.data);
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
