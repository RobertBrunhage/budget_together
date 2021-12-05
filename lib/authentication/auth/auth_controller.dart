import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide User;

import '../login_view.dart';
import '../models/user.dart';
import 'auth_service.dart';

final authControllerProvider = ChangeNotifierProvider<AuthController>((ref) {
  return AuthController(ref.watch(authServiceProvider));
});

class AuthController extends ChangeNotifier {
  AuthController(this._authService) : super() {
    supabase.auth.refreshSession();
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
