import 'package:budget_together/Authentication/login.dart';
import 'package:budget_together/Household/household.dart';
import 'package:budget_together/Household/household_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HouseholdState {
  final AsyncValue<Household?> household;
  HouseholdState({
    required this.household,
  });

  HouseholdState copyWith({
    AsyncValue<Household?>? household,
  }) {
    return HouseholdState(
      household: household ?? this.household,
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
  return HouseholdController(ref.watch(householdServiceProvider));
});

class HouseholdController extends StateNotifier<HouseholdState> {
  HouseholdController(this._householdService)
      : super(HouseholdState(household: const AsyncValue.loading())) {
    fetchHousehold();
  }

  final HouseholdService _householdService;

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
            state.household.value!.copyWith(expenses: expenses)));
  }

  Future<void> createExpense(int amount) async {
    final household = state.household.value!;
    await _householdService.createExpense(
        supabase.auth.currentUser!.id, amount, null, household.id);
    await fetchExpenses();
  }

  Future<void> deleteExpense(int expenseId) async {
    await _householdService.deleteExpense(expenseId);
    await fetchExpenses();
  }
}
