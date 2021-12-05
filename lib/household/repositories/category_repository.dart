import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../authentication/login_view.dart';
import '../entities/category/category_entity.dart';

final categoryRepositoryProvider = Provider<CategoryRepository>((final ref) {
  return CategoryRepository();
});

class CategoryRepository {
  Future<List<CategoryEntity>?> fetchCategories(final int householdId) async {
    final response = await supabase.from('categories').select('id, name').eq('household_id', householdId).execute();

    final categories = List<Map<String, dynamic>>.from(response.data as List<Map<String, dynamic>>)
        .map((final e) => CategoryEntity.fromJson(e))
        .toList();

    return categories;
  }

  Future<CategoryEntity> createCategory(final CategoryEntity category, final int householdId) async {
    final response = await supabase.from('categories').upsert(<String, dynamic>{
      'household_id': householdId,
      'name': category.name,
    }).execute();

    final data = List<Map<String, dynamic>>.from(response.data as List<Map<String, dynamic>>);

    if (response.error != null) {
      throw HttpException(response.error!.message);
    }

    return CategoryEntity.fromJson(data[0]);
  }

  Future<void> deleteExpense(final int expenseId) async {
    final response = await supabase.from('expenses').delete().eq('id', expenseId).execute();
    if (response.error != null) {
      throw HttpException(response.error!.message);
    }
  }
}
