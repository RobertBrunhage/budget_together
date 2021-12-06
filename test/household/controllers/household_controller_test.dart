import 'package:budget_together/authentication/models/user.dart';
import 'package:budget_together/authentication/services/auth_service.dart';
import 'package:budget_together/authentication/supabase/supabase_provider.dart';
import 'package:budget_together/household/controllers/household_controller.dart';
import 'package:budget_together/household/models/category/category.dart';
import 'package:budget_together/household/models/expense/expense.dart';
import 'package:budget_together/household/models/household/household.dart';
import 'package:budget_together/household/services/household_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supa;

import '../../shared.dart';
import '../../shared_mocks.dart';

void main() {
  late AuthService mockedAuthService;
  late HouseholdService mockedHouseholdService;
  late supa.SupabaseClient mockedSupabaseClient;
  late ProviderContainer container;

  setUp(() {
    mockedAuthService = MockAuthService();
    mockedHouseholdService = MockHouseholdService();
    mockedSupabaseClient = MockSupabaseClient();

    container = ProviderContainer(
      overrides: [
        authServiceProvider.overrideWithValue(mockedAuthService),
        householdServiceProvider.overrideWithValue(mockedHouseholdService),
        supabaseProvider.overrideWithValue(mockedSupabaseClient),
      ],
    );

    // common
    when(() => mockedSupabaseClient.auth).thenReturn(stubGoTrueClient());
    when(() => mockedAuthService.createOrUpdateUser(User(id: '', name: 'test')))
        .thenAnswer((invocation) => Future.value(const Success(null)));

    when(() => mockedHouseholdService.fetchHousehold('')).thenAnswer((invocation) => Future.value(const Success(null)));
  });

  tearDown(() {
    container.dispose();
  });

  test('When setting up controller Then verify initial state', () async {
    // ASSERT
    expect(container.read(householdControllerProvider).selectedMonth, DateTime.now().month);
    expect(container.read(householdControllerProvider).selectedYear, DateTime.now().year);
    expect(container.read(householdControllerProvider).household, isA<AsyncLoading>());
    expect(container.read(householdControllerProvider).categories, isA<AsyncLoading>());
  });

  test('When setting selected year Then year is correct in state', () async {
    // ASSERT
    expect(container.read(householdControllerProvider).selectedYear, DateTime.now().year);
    container.read(householdControllerProvider.notifier).setYear(2010);
    expect(container.read(householdControllerProvider).selectedYear, 2010);
  });

  test('When setting selected month Then month is correct in state', () async {
    // ASSERT
    expect(container.read(householdControllerProvider).selectedMonth, DateTime.now().month);
    container.read(householdControllerProvider.notifier).setMonth(4);
    expect(container.read(householdControllerProvider).selectedMonth, 4);
  });

  test('When creating household successfully Then fetch household is called', () async {
    // ASSEMBLE
    when(() => mockedHouseholdService.createHousehold('1', 'testingHousehold'))
        .thenAnswer((invocation) => Future.value(const Success(null)));
    expect(container.read(householdControllerProvider).household, isA<AsyncLoading>());

    // ACT
    await container.read(householdControllerProvider.notifier).createHousehold('1', 'testingHousehold');

    // ASSERT
    verify(() => container.read(householdServiceProvider).createHousehold('1', 'testingHousehold')).called(1);
  });

  test('When fetching household successfully Then verify state is set', () async {
    // ASSEMBLE
    final household = Household(id: 1, creator: '', name: '', expenses: []);
    when(() => mockedHouseholdService.fetchHousehold(any())).thenAnswer(
      (invocation) => Future.value(
        Success(
          household,
        ),
      ),
    );

    expect(container.read(householdControllerProvider).household, isA<AsyncLoading>());

    // ACT
    await container.read(householdControllerProvider.notifier).fetchHousehold();

    // ASSERT
    expect(container.read(householdControllerProvider).household.value, household);
  });

  test('When fetching expenses successfully Then verify state is set', () async {
    // ASSEMBLE
    final expenses = [
      Expense(
        id: 1,
        amount: 100,
        category: Category(id: 1, name: ''),
        user: User(id: '', name: ''),
        date: DateTime.now(),
      )
    ];
    final household = Household(id: 1, creator: '', name: '', expenses: []);
    when(() => mockedHouseholdService.fetchHousehold(any())).thenAnswer(
      (invocation) => Future.value(
        Success(
          household,
        ),
      ),
    );
    when(() => mockedHouseholdService.fetchExpenses(any(), any(), any())).thenAnswer(
      (invocation) => Future.value(
        Success(expenses),
      ),
    );

    // ACT
    await container.read(householdControllerProvider.notifier).fetchHousehold();
    await container.read(householdControllerProvider.notifier).fetchExpenses();

    // ASSERT
    expect(container.read(householdControllerProvider).household.value!.expenses, expenses);
  });

  test('When creating expense successfully Then verify fetch expenses is called', () async {
    // ASSEMBLE
    final expenses = [
      Expense(
        id: 1,
        amount: 100,
        category: Category(id: 1, name: ''),
        user: User(id: '', name: ''),
        date: DateTime.now(),
      )
    ];
    final newExpense = Expense(
      id: 2,
      amount: 100,
      category: Category(id: 1, name: ''),
      user: User(id: '', name: ''),
      date: DateTime.now(),
    );
    final household = Household(id: 1, creator: '', name: '', expenses: []);
    when(() => mockedHouseholdService.fetchHousehold(any())).thenAnswer(
      (invocation) => Future.value(
        Success(
          household,
        ),
      ),
    );
    when(() => mockedHouseholdService.fetchExpenses(any(), any(), any())).thenAnswer(
      (invocation) => Future.value(
        Success(expenses),
      ),
    );
    when(() => mockedHouseholdService.createExpense(any(), 100, Category(id: -1, name: ''), any(), any())).thenAnswer(
      (invocation) => Future.value(
        const Success(null),
      ),
    );

    // ACT
    await container.read(householdControllerProvider.notifier).fetchHousehold();
    await container.read(householdControllerProvider.notifier).createExpense(100, DateTime.now());

    // ASSERT
    verify(() => container.read(householdServiceProvider).fetchExpenses(any(), any(), any())).called(1);
  });

  test('When deleting expense successfully Then verify delete and fetch is called', () async {
    // ASSEMBLE
    final expenses = [
      Expense(
        id: 1,
        amount: 100,
        category: Category(id: 1, name: ''),
        user: User(id: '', name: ''),
        date: DateTime.now(),
      )
    ];
    final household = Household(id: 1, creator: '', name: '', expenses: []);
    when(() => mockedHouseholdService.fetchHousehold(any())).thenAnswer(
      (invocation) => Future.value(
        Success(
          household,
        ),
      ),
    );
    when(() => mockedHouseholdService.fetchExpenses(any(), any(), any())).thenAnswer(
      (invocation) => Future.value(
        Success(expenses),
      ),
    );
    when(() => mockedHouseholdService.deleteExpense(any())).thenAnswer(
      (invocation) => Future.value(
        const Success(null),
      ),
    );

    // ACT
    await container.read(householdControllerProvider.notifier).deleteExpense(1);

    // ASSERT
    verify(() => container.read(householdServiceProvider).deleteExpense(any())).called(1);
    verify(() => container.read(householdServiceProvider).fetchExpenses(any(), any(), any())).called(1);
  });
}
