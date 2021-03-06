import 'package:flutter/material.dart';

import 'supabase/auth_state.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);
  static String get route => 'splash';

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends AuthState<SplashView> {
  @override
  void initState() {
    super.initState();
    recoverSupabaseSession();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
