import 'package:budget_together/Authentication/auth/auth_service.dart';
import 'package:budget_together/Authentication/login.dart';
import 'package:budget_together/Authentication/user.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide User;

final authControllerProvider = ChangeNotifierProvider<AuthController>((ref) {
  return AuthController(ref.watch(authServiceProvider));
});

class AuthController extends ChangeNotifier {
  AuthController(this._authService) : super() {
    recoverSupabaseSession();
    _sub = supabase.auth.onAuthStateChange((event, session) {
      setAuthState(session);
    });
  }

  final AuthService _authService;

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
        User(id: session!.user!.id, name: session!.user!.email!.split('@')[0]),
      );
    }
  }

  Future<bool> recoverSupabaseSession() async {
    final bool exist =
        await SupabaseAuth.instance.localStorage.hasAccessToken();
    if (!exist) {
      return false;
    }

    final String? jsonStr =
        await SupabaseAuth.instance.localStorage.accessToken();
    if (jsonStr == null) {
      return false;
    }

    final response =
        await Supabase.instance.client.auth.recoverSession(jsonStr);
    if (response.error != null) {
      SupabaseAuth.instance.localStorage.removePersistedSession();
      return false;
    } else {
      return true;
    }
  }

  @override
  void dispose() {
    _sub.data?.unsubscribe();
    super.dispose();
  }
}
