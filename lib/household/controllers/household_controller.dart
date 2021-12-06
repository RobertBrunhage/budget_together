import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../authentication/supabase/supabase_provider.dart';
import '../../core/error_handling/failure.dart';
import '../../core/error_handling/snackbar_controller.dart';
import '../models/category/category.dart';
import '../models/household/household.dart';
import '../services/household_service.dart';
import 'category_controller.dart';

@immutable
class HouseholdState {
  const HouseholdState({
    required this.household,
    required this.categories,
    required this.selectedYear,
    required this.selectedMonth,
  });
  final AsyncValue<Household?> household;
  final AsyncValue<List<Category>?> categories;
  final int selectedYear;
  final int selectedMonth;

  HouseholdState copyWith({
    AsyncValue<Household?>? household,
    AsyncValue<List<Category>?>? categories,
    int? selectedYear,
    int? selectedMonth,
  }) {
    return HouseholdState(
      household: household ?? this.household,
      categories: categories ?? this.categories,
      selectedYear: selectedYear ?? this.selectedYear,
      selectedMonth: selectedMonth ?? this.selectedMonth,
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

final householdControllerProvider = StateNotifierProvider<HouseholdController, HouseholdState>((ref) {
  return HouseholdController(
    ref.watch(householdServiceProvider),
    ref.watch(categoryControllerProvider.notifier),
    ref.watch(supabaseProvider),
    ref.watch(snackbarControllerProvider.notifier),
  );
});

class HouseholdController extends StateNotifier<HouseholdState> {
  HouseholdController(
    this._householdService,
    this._categoryController,
    this._supabaseClient,
    this._snackbarController,
  ) : super(
          HouseholdState(
            household: const AsyncValue.loading(),
            categories: const AsyncValue.loading(),
            selectedYear: DateTime.now().year,
            selectedMonth: DateTime.now().month,
          ),
        ) {
    fetchHousehold();
  }

  final HouseholdService _householdService;
  final CategoryController _categoryController;
  final SupabaseClient _supabaseClient;
  final SnackbarController _snackbarController;

  Future<Result<Failure, void>> createHousehold(String userId, String householdName) async {
    final result = await _householdService.createHousehold(userId, householdName);
    result.when(
      (error) => _snackbarController.setSnackbarMessage(error.message),
      (household) async {
        await fetchHousehold();
      },
    );
    return result;
  }

  void setYear(int year) {
    state = state.copyWith(selectedYear: year);
  }

  void setMonth(int month) {
    state = state.copyWith(selectedMonth: month);
  }

  Future<Result<Failure, void>> fetchHousehold() async {
    state = state.copyWith(household: const AsyncValue.loading());
    final result = await _householdService.fetchHousehold(_supabaseClient.auth.currentUser!.id);
    result.when(
      (error) => _snackbarController.setSnackbarMessage(error.message),
      (household) {
        state = state.copyWith(household: AsyncValue.data(household));
      },
    );
    return result;
  }

  Future<Result<Failure, void>> fetchExpenses() async {
    final result = await _householdService.fetchExpenses(
      state.household.value!.id,
      state.selectedYear,
      state.selectedMonth,
    );

    result.when(
      (error) => _snackbarController.setSnackbarMessage(error.message),
      (success) {
        state = state.copyWith(household: AsyncValue.data(state.household.value!.copyWith(expenses: success ?? [])));
      },
    );
    return result;
  }

  Future<Result<Failure, void>> createExpense(double amount, DateTime date) async {
    final household = state.household.value!;
    final result = await _householdService.createExpense(
      _supabaseClient.auth.currentUser!.id,
      amount,
      _categoryController.state.category,
      household.id,
      date,
    );

    result.when(
      (error) => _snackbarController.setSnackbarMessage(error.message),
      (success) async {
        await fetchExpenses();
      },
    );
    return result;
  }

  Future<Result<Failure, void>> deleteExpense(int expenseId) async {
    final result = await _householdService.deleteExpense(expenseId);
    result.when(
      (error) => _snackbarController.setSnackbarMessage(error.message),
      (success) async {
        await fetchExpenses();
      },
    );
    return result;
  }
}
