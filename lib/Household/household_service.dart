import 'package:budget_together/Authentication/login.dart';
import 'package:budget_together/Authentication/user.dart';
import 'package:budget_together/Household/category.dart';
import 'package:budget_together/Household/expense.dart';
import 'package:budget_together/Household/expense_repository.dart';
import 'package:budget_together/Household/household_repository.dart';
import 'package:budget_together/Household/invite_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'household.dart';

final householdServiceProvider = Provider<HouseholdService>((ref) {
  return HouseholdService(
    ref.watch(householdRepositoryProvider),
    ref.watch(expenseRepositoryProvider),
    ref.watch(inviteRepositoryProvider),
  );
});

class HouseholdService {
  final HouseholdRepository _householdRepository;
  final ExpenseRepository _expenseRepository;
  final InviteRepository _inviteRepository;

  HouseholdService(
    this._householdRepository,
    this._expenseRepository,
    this._inviteRepository,
  );

  Future<void> createHousehold(String userId, String householdName) async {
    return _householdRepository.createHousehold(userId, householdName);
  }

  Future<void> inviteUserToHousehold(String email, int householdId) async {
    return _inviteRepository.invite(email, householdId);
  }

  Future<void> acceptAllInvites() {
    return _inviteRepository
        .acceptAllInvites(supabase.auth.currentUser!.email!);
  }

  Future<Household?> fetchHousehold(String userId) async {
    return _householdRepository.fetchHousehold(userId);
  }

  Future<List<Expense>?> fetchExpenses(int householdId) async {
    return _expenseRepository.fetchExpenses(householdId);
  }

  Future<void> createExpense(
      String userId, int amount, Category? category, int householdId) async {
    final expense = Expense(
      id: -1,
      amount: amount,
      category: category,
      user: User(id: userId, name: ''),
    );
    await _expenseRepository.createExpense(expense, householdId);
  }

  Future<void> deleteExpense(int expenseId) async {
    _expenseRepository.deleteExpense(expenseId);
  }
}
