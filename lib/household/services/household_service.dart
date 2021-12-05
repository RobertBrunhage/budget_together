import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../authentication/entities/user_entity.dart';
import '../entities/category/category_entity.dart';
import '../entities/expense/expense_entity.dart';
import '../models/category/category.dart';
import '../models/expense/expense.dart';
import '../models/household/household.dart';
import '../repositories/category_repository.dart';
import '../repositories/expense_repository.dart';
import '../repositories/household_repository.dart';

final householdServiceProvider = Provider<HouseholdService>((final ref) {
  return HouseholdService(
    ref.watch(householdRepositoryProvider),
    ref.watch(expenseRepositoryProvider),
    ref.watch(categoryRepositoryProvider),
  );
});

class HouseholdService {
  HouseholdService(
    this._householdRepository,
    this._expenseRepository,
    this._categoryRepository,
  );

  final HouseholdRepository _householdRepository;
  final ExpenseRepository _expenseRepository;
  final CategoryRepository _categoryRepository;

  Future<void> createHousehold(final String userId, final String householdName) async {
    final householdId = await _householdRepository.createHousehold(userId, householdName);
    await _categoryRepository.createCategory(CategoryEntity(name: 'annat', id: -1), householdId);
  }

  Future<Household?> fetchHousehold(final String userId) async {
    final householdEntity = await _householdRepository.fetchHousehold(userId);
    if (householdEntity == null) return null;
    return Household.fromEntity(householdEntity);
  }

  Future<List<Expense>?> fetchExpenses(
    final int householdId,
    final int year,
    final int month,
  ) async {
    final startDate = DateTime(year, month);
    final endDate = DateTime(year, month + 1, 0);
    final expenseEntities = await _expenseRepository.fetchExpenses(
      householdId,
      startDate,
      endDate,
    );
    if (expenseEntities == null) return null;

    return expenseEntities.map((final e) => Expense.fromEntity(e)).toList();
  }

  Future<void> createExpense(
    final String userId,
    final double amount,
    final Category category,
    final int householdId,
    final DateTime date,
  ) async {
    final expense = ExpenseEntity(
      id: -1,
      amount: (amount * 100).toInt(),
      category: category.toEntity(),
      user: UserEntity(id: userId, name: ''),
      transactionDate: date,
    );
    await _expenseRepository.createExpense(expense, householdId);
  }

  Future<Category> createCategory(final String name, final int householdId) async {
    final categoryEntity = await _categoryRepository.createCategory(
      CategoryEntity(id: -1, name: name),
      householdId,
    );

    return Category.fromEntity(categoryEntity);
  }

  Future<void> deleteExpense(final int expenseId) async {
    await _expenseRepository.deleteExpense(expenseId);
  }

  Future<List<Category>?> fetchAllCategories(final int householdId) async {
    final categoryEntities = await _categoryRepository.fetchCategories(householdId);
    final categories = categoryEntities?.map((final e) => Category.fromEntity(e)).toList();
    return categories;
  }
}
