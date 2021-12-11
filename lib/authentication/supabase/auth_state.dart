import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:supabase/supabase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthState<T extends StatefulWidget> extends SupabaseAuthState<T> {
  final _log = Logger('AuthState Supabase');
  @override
  void onUnauthenticated() {}

  @override
  void onAuthenticated(Session session) {}

  @override
  void onPasswordRecovery(Session session) {}

  @override
  void onErrorAuthenticating(String message) {
    _log.info(message);
  }
}
