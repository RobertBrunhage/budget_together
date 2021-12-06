import 'package:budget_together/authentication/models/user.dart';
import 'package:budget_together/authentication/services/auth_service.dart';
import 'package:budget_together/authentication/supabase/supabase_provider.dart';
import 'package:budget_together/household/controllers/household_controller.dart';
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
}
