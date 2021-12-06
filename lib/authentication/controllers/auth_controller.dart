import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide User;

import '../../core/error_handling/failure.dart';
import '../../core/error_handling/snackbar_controller.dart';
import '../models/user.dart';
import '../services/auth_service.dart';
import '../supabase/supabase_provider.dart';

final authControllerProvider = ChangeNotifierProvider<AuthController>((ref) {
  return AuthController(
    ref.watch(authServiceProvider),
    ref.watch(supabaseProvider),
    ref.watch(snackbarControllerProvider.notifier),
  );
});

class AuthController extends ChangeNotifier {
  AuthController(
    this._authService,
    this._supabaseClient,
    this._snackbarController,
  ) : super() {
    _supabaseClient.auth.refreshSession();
    _sub = _supabaseClient.auth.onAuthStateChange((event, session) {
      setAuthState(session);
    });
  }

  final AuthService _authService;
  final SupabaseClient _supabaseClient;
  final SnackbarController _snackbarController;
  final _log = Logger('Auth Controller');

  late final GotrueSubscription _sub;
  Session? session;

  void setAuthState(Session? session) {
    this.session = session;
    createOrUpdateUser();
    notifyListeners();
  }

  Future<Result<Failure, void>> createOrUpdateUser() async {
    if (session == null) return Error(Failure('No session'));
    final result = await _authService.createOrUpdateUser(
      User(
        id: session!.user!.id,
        name: session!.user!.email!.split('@')[0],
      ),
    );

    result.when(
      (error) => _snackbarController.setSnackbarMessage(error.message),
      (_) {
        _log.info('Succeessfully accepted all invites');
      },
    );
    return result;
  }

  @override
  void dispose() {
    _sub.data?.unsubscribe();
    super.dispose();
  }
}
