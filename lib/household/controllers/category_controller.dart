import 'package:flutter/foundation.dart' hide Category;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../core/error_handling/failure.dart';
import '../../core/error_handling/snackbar_controller.dart';
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
    ref.watch(snackbarControllerProvider.notifier),
  );
});

class CategoryController extends StateNotifier<CategoryState> {
  CategoryController(
    this._householdService,
    this._snackbarController,
  ) : super(
          CategoryState(
            category: Category(id: -1, name: ''),
            categories: const AsyncValue.loading(),
          ),
        );

  final HouseholdService _householdService;
  final SnackbarController _snackbarController;

  Future<Result<Failure, void>> fetchCategories(int householdId) async {
    final result = await _householdService.fetchAllCategories(
      householdId,
    );
    result.when(
      (error) => _snackbarController.setSnackbarMessage(error.message),
      (categories) {
        state = state.copyWith(
          categories: AsyncValue.data(categories),
          category: categories!.first,
        );
      },
    );
    return result;
  }

  Future<Result<Failure, Category>> createCategory(int householdId, String name) async {
    final result = await _householdService.createCategory(name, householdId);

    result.when(
      (error) => _snackbarController.setSnackbarMessage(error.message),
      (category) {
        state = state.copyWith(
          category: category,
          categories: AsyncValue.data([...state.categories.value!, category]),
        );
      },
    );
    return result;
  }

  void setCategory(Category category) {
    state = state.copyWith(category: category);
  }
}
