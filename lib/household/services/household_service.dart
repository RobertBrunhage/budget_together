import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../authentication/entities/user_entity.dart';
import '../../core/failure.dart';
import '../../core/supabase_exception.dart';
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

  Future<Result<Failure, void>> createHousehold(final String userId, final String householdName) async {
    try {
      final householdId = await _householdRepository.createHousehold(userId, householdName);
      await _categoryRepository.createCategory(CategoryEntity(name: 'annat', id: -1), householdId);
      return const Success(null);
    } on SupabaseException catch (e) {
      return Error(Failure(e.message));
    }
  }

  Future<Result<Failure, Household?>> fetchHousehold(final String userId) async {
    try {
      final householdEntity = await _householdRepository.fetchHousehold(userId);
      if (householdEntity == null) return Error(Failure('no entities exists'));
      return Success(Household.fromEntity(householdEntity));
    } on SupabaseException catch (e) {
      return Error(Failure(e.message));
    }
  }

  Future<Result<Failure, List<Expense>?>> fetchExpenses(
    final int householdId,
    final int year,
    final int month,
  ) async {
    try {
      final startDate = DateTime(year, month);
      final endDate = DateTime(year, month + 1, 0);
      final expenseEntities = await _expenseRepository.fetchExpenses(
        householdId,
        startDate,
        endDate,
      );
      if (expenseEntities == null) return Error(Failure('No expenses'));

      return Success(expenseEntities.map((final e) => Expense.fromEntity(e)).toList());
    } on SupabaseException catch (e) {
      return Error(Failure(e.message));
    }
  }

  Future<Result<Failure, void>> createExpense(
    final String userId,
    final double amount,
    final Category category,
    final int householdId,
    final DateTime date,
  ) async {
    try {
      final expense = ExpenseEntity(
        id: -1,
        amount: (amount * 100).toInt(),
        category: category.toEntity(),
        user: UserEntity(id: userId, name: ''),
        transactionDate: date,
      );
      await _expenseRepository.createExpense(expense, householdId);
      return const Success(null);
    } on SupabaseException catch (e) {
      return Error(Failure(e.message));
    }
  }

  Future<Result<Failure, Category>> createCategory(final String name, final int householdId) async {
    try {
      final categoryEntity = await _categoryRepository.createCategory(
        CategoryEntity(id: -1, name: name),
        householdId,
      );

      return Success(Category.fromEntity(categoryEntity));
    } on SupabaseException catch (e) {
      return Error(Failure(e.message));
    }
  }

  Future<Result<Failure, void>> deleteExpense(final int expenseId) async {
    try {
      await _expenseRepository.deleteExpense(expenseId);
      return const Success(null);
    } on SupabaseException catch (e) {
      return Error(Failure(e.message));
    }
  }

  Future<Result<Failure, List<Category>?>> fetchAllCategories(final int householdId) async {
    try {
      final categoryEntities = await _categoryRepository.fetchCategories(householdId);
      final categories = categoryEntities?.map((final e) => Category.fromEntity(e)).toList();
      return Success(categories);
    } on SupabaseException catch (e) {
      return Error(Failure(e.message));
    }
  }
}
