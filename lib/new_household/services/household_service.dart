import 'package:budget_together/new_authentication/entities/user_entity.dart';
import 'package:budget_together/new_authentication/login.dart';
import 'package:budget_together/new_household/entities/category/category_entity.dart';
import 'package:budget_together/new_household/entities/expense/expense_entity.dart';
import 'package:budget_together/new_household/models/category/category.dart';
import 'package:budget_together/new_household/models/expense/expense.dart';
import 'package:budget_together/new_household/models/household/household.dart';
import 'package:budget_together/new_household/repositories/category_repository.dart';
import 'package:budget_together/new_household/repositories/expense_repository.dart';
import 'package:budget_together/new_household/repositories/household_repository.dart';
import 'package:budget_together/new_household/repositories/invite_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final householdServiceProvider = Provider<HouseholdService>((ref) {
  return HouseholdService(
    ref.watch(householdRepositoryProvider),
    ref.watch(expenseRepositoryProvider),
    ref.watch(inviteRepositoryProvider),
    ref.watch(categoryRepositoryProvider),
  );
});

class HouseholdService {
  final HouseholdRepository _householdRepository;
  final ExpenseRepository _expenseRepository;
  final InviteRepository _inviteRepository;
  final CategoryRepository _categoryRepository;

  HouseholdService(
    this._householdRepository,
    this._expenseRepository,
    this._inviteRepository,
    this._categoryRepository,
  );

  Future<void> createHousehold(String userId, String householdName) async {
    final householdId =
        await _householdRepository.createHousehold(userId, householdName);
    await _categoryRepository.createCategory(
        CategoryEntity(name: 'annat', id: -1), householdId);
  }

  Future<void> inviteUserToHousehold(String email, int householdId) async {
    return _inviteRepository.invite(email, householdId);
  }

  Future<void> acceptAllInvites() {
    return _inviteRepository
        .acceptAllInvites(supabase.auth.currentUser!.email!);
  }

  Future<Household?> fetchHousehold(String userId) async {
    final householdEntity = await _householdRepository.fetchHousehold(userId);
    if (householdEntity == null) return null;
    return Household.fromEntity(householdEntity);
  }

  Future<List<Expense>?> fetchExpenses(int householdId) async {
    final expenseEntities = await _expenseRepository.fetchExpenses(householdId);
    if (expenseEntities == null) return null;

    return expenseEntities.map((e) => Expense.fromEntity(e)).toList();
  }

  Future<void> createExpense(
    String userId,
    double amount,
    Category category,
    int householdId,
    DateTime date,
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

  Future<Category> createCategory(String name, int householdId) async {
    final categoryEntity = await _categoryRepository.createCategory(
      CategoryEntity(id: -1, name: name),
      householdId,
    );

    return Category.fromEntity(categoryEntity);
  }

  Future<void> deleteExpense(int expenseId) async {
    await _expenseRepository.deleteExpense(expenseId);
  }

  Future<List<Category>?> fetchAllCategories(int householdId) async {
    final categoryEntities =
        await _categoryRepository.fetchCategories(householdId);
    final categories =
        categoryEntities?.map((e) => Category.fromEntity(e)).toList();
    return categories;
  }
}
