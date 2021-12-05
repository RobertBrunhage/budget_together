import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide User;

import '../models/user.dart';
import '../services/auth_service.dart';
import '../supabase/supabase_provider.dart';

final authControllerProvider = ChangeNotifierProvider<AuthController>((ref) {
  return AuthController(
    ref.watch(authServiceProvider),
    ref.watch(supabaseProvider),
  );
});

class AuthController extends ChangeNotifier {
  AuthController(
    this._authService,
    this._supabaseClient,
  ) : super() {
    _supabaseClient.auth.refreshSession();
    _sub = _supabaseClient.auth.onAuthStateChange((event, session) {
      setAuthState(session);
    });
  }

  final AuthService _authService;
  final SupabaseClient _supabaseClient;

  late final GotrueSubscription _sub;
  Session? session;

  void setAuthState(Session? session) {
    this.session = session;
    createOrUpdateUser();
    notifyListeners();
  }

  Future<void> createOrUpdateUser() async {
    if (session != null) {
      await _authService.createOrUpdateUser(
        User(
          id: session!.user!.id,
          name: session!.user!.email!.split('@')[0],
        ),
      );
    }
  }

  @override
  void dispose() {
    _sub.data?.unsubscribe();
    super.dispose();
  }
}
