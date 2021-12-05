import 'package:flutter/foundation.dart' hide Category;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/category/category.dart';
import '../services/household_service.dart';

@immutable
class CategoryState {
  const CategoryState({
    required this.category,
    required this.categories,
  });
  final Category category;
  final AsyncValue<List<Category>?> categories;

  CategoryState copyWith({
    Category? category,
    AsyncValue<List<Category>?>? categories,
  }) {
    return CategoryState(
      category: category ?? this.category,
      categories: categories ?? this.categories,
    );
  }

  @override
  String toString() => 'HouseholdState(household: $category)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CategoryState && other.category == category;
  }

  @override
  int get hashCode => category.hashCode;
}

final categoryControllerProvider = StateNotifierProvider<CategoryController, CategoryState>((ref) {
  return CategoryController(
    ref.watch(householdServiceProvider),
  );
});

class CategoryController extends StateNotifier<CategoryState> {
  CategoryController(this._householdService)
      : super(
          CategoryState(
            category: Category(id: -1, name: ''),
            categories: const AsyncValue.loading(),
          ),
        );

  final HouseholdService _householdService;

  Future<void> fetchCategories(int householdId) async {
    final categories = await _householdService.fetchAllCategories(
      householdId,
    );
    state = state.copyWith(
      categories: AsyncValue.data(categories),
      category: categories!.first,
    );
  }

  Future<Category> createCategory(int householdId, String name) async {
    final category = await _householdService.createCategory(name, householdId);
    state = state.copyWith(
      category: category,
      categories: AsyncValue.data([...state.categories.value!, category]),
    );
    return category;
  }

  void setCategory(Category category) {
    state = state.copyWith(category: category);
  }
}