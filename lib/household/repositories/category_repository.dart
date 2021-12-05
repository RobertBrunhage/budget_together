import 'dart:io';

import 'package:budget_together/authentication/login_view.dart';
import 'package:budget_together/household/entities/category/category_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final categoryRepositoryProvider = Provider<CategoryRepository>((ref) {
  return CategoryRepository();
});

class CategoryRepository {
  Future<List<CategoryEntity>?> fetchCategories(int householdId) async {
    final response = await supabase.from('categories').select('id, name').eq('household_id', householdId).execute();

    final categories = List.from(response.data).map((e) => CategoryEntity.fromJson(e)).toList();

    return categories;
  }

  Future<CategoryEntity> createCategory(CategoryEntity category, householdId) async {
    try {
      final response = await supabase.from('categories').upsert({
        'household_id': householdId,
        'name': category.name,
      }).execute();

      return CategoryEntity.fromJson(response.data[0]);
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
