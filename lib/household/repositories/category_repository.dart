import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supa;

import '../../authentication/supabase/supabase_provider.dart';
import '../../core/supabase_exception.dart';
import '../entities/category/category_entity.dart';

final categoryRepositoryProvider = Provider<CategoryRepository>((final ref) {
  return CategoryRepository(
    ref.watch(supabaseProvider),
  );
});

class CategoryRepository {
  CategoryRepository(this._supabaseClient);

  final supa.SupabaseClient _supabaseClient;
  Future<List<CategoryEntity>?> fetchCategories(final int householdId) async {
    final response =
        await _supabaseClient.from('categories').select('id, name').eq('household_id', householdId).execute();

    final categories = List<Map<String, dynamic>>.from(response.data as List<dynamic>)
        .map((final e) => CategoryEntity.fromJson(e))
        .toList();

    return categories;
  }

  Future<CategoryEntity> createCategory(final CategoryEntity category, final int householdId) async {
    final response = await _supabaseClient.from('categories').upsert(<String, dynamic>{
      'household_id': householdId,
      'name': category.name,
    }).execute();

    final data = List<Map<String, dynamic>>.from(response.data as List<dynamic>);

    if (response.error != null) {
      throw SupabaseException(response.error!);
    }

    return CategoryEntity.fromJson(data[0]);
  }

  Future<void> deleteExpense(final int expenseId) async {
    final response = await _supabaseClient.from('expenses').delete().eq('id', expenseId).execute();
    if (response.error != null) {
      throw SupabaseException(response.error!);
    }
  }
}
