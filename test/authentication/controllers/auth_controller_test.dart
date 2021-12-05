import 'package:budget_together/authentication/controllers/auth_controller.dart';
import 'package:budget_together/authentication/models/user.dart';
import 'package:budget_together/authentication/services/auth_service.dart';
import 'package:budget_together/authentication/supabase/supabase_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supa;

import '../../shared.dart';
import '../../shared_mocks.dart';

void main() {
  late AuthService mockedAuthService;
  late supa.SupabaseClient mockedSupabaseClient;
  late ProviderContainer container;

  setUp(() {
    mockedAuthService = MockAuthService();
    mockedSupabaseClient = MockSupabaseClient();

    container = ProviderContainer(
      overrides: [
        authServiceProvider.overrideWithValue(mockedAuthService),
        supabaseProvider.overrideWithValue(mockedSupabaseClient),
      ],
    );

    // common
    when(() => mockedSupabaseClient.auth).thenReturn(stubGoTrueClient());
    when(() => mockedAuthService.createOrUpdateUser(User(id: '', name: 'test')))
        .thenAnswer((invocation) => Future.value(null));
  });

  tearDown(() {
    container.dispose();
  });

  test('When calling setAuthState Then verify createOrUpdateUser is called', () async {
    // ARRANGE
    final session = supa.Session(
      accessToken: '',
      user: supa.User(
        id: '',
        appMetadata: <String, dynamic>{},
        userMetadata: <String, dynamic>{},
        aud: '',
        email: 'test@gmail.com',
        phone: '',
        createdAt: '',
        role: '',
        updatedAt: '',
      ),
    );

    // ACT
    expect(container.read(authControllerProvider).session, null);
    container.read(authControllerProvider.notifier).setAuthState(session);

    // ASSERT
    verify(
      () => container.read(authServiceProvider).createOrUpdateUser(User(id: '', name: 'test')),
    ).called(1);
  });
}
