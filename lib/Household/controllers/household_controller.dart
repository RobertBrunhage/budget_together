import 'package:budget_together/Authentication/login.dart';
import 'package:budget_together/Household/controllers/category_controller.dart';
import 'package:budget_together/Household/entities/category/category.dart';
import 'package:budget_together/Household/entities/household/household.dart';
import 'package:budget_together/Household/services/household_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HouseholdState {
  final AsyncValue<Household?> household;
  final AsyncValue<List<Category>?> categories;
  HouseholdState({
    required this.household,
    required this.categories,
  });

  HouseholdState copyWith({
    AsyncValue<Household?>? household,
    AsyncValue<List<Category>?>? categories,
  }) {
    return HouseholdState(
      household: household ?? this.household,
      categories: categories ?? this.categories,
    );
  }

  @override
  String toString() => 'HouseholdState(household: $household)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HouseholdState && other.household == household;
  }

  @override
  int get hashCode => household.hashCode;
}

final householdControllerProvider =
    StateNotifierProvider<HouseholdController, HouseholdState>((ref) {
  return HouseholdController(
    ref.watch(householdServiceProvider),
    ref.watch(categoryControllerProvider.notifier),
  );
});

class HouseholdController extends StateNotifier<HouseholdState> {
  HouseholdController(this._householdService, this._categoryController)
      : super(HouseholdState(
          household: const AsyncValue.loading(),
          categories: const AsyncValue.loading(),
        )) {
    fetchHousehold();
  }

  final HouseholdService _householdService;
  final CategoryController _categoryController;

  Future<void> createHousehold(String userId, String householdName) async {
    await _householdService.createHousehold(userId, householdName);
    await fetchHousehold();
  }

  Future<void> invite(String email) async {
    await _householdService.inviteUserToHousehold(
      email,
      state.household.value!.id,
    );
  }

  Future<void> acceptAllInvites() async {
    await _householdService.acceptAllInvites();
    await fetchHousehold();
  }

  Future<void> fetchHousehold() async {
    state = state.copyWith(household: const AsyncValue.loading());
    final household =
        await _householdService.fetchHousehold(supabase.auth.currentUser!.id);

    state = state.copyWith(household: AsyncValue.data(household));
  }

  Future<void> fetchExpenses() async {
    final expenses =
        await _householdService.fetchExpenses(state.household.value!.id);

    state = state.copyWith(
        household: AsyncValue.data(
            state.household.value!.copyWith(expenses: expenses ?? [])));
  }

  Future<void> createExpense(double amount) async {
    final household = state.household.value!;
    await _householdService.createExpense(
      supabase.auth.currentUser!.id,
      amount,
      _categoryController.state.category,
      household.id,
    );
    await fetchExpenses();
  }

  Future<void> deleteExpense(int expenseId) async {
    await _householdService.deleteExpense(expenseId);
    await fetchExpenses();
  }
}
