import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../localization/generated/l10n.dart';
import 'supabase/auth_state.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);
  static String get route => 'login';

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends AuthState<LoginView> {
  bool _isLoading = false;
  late final TextEditingController _emailController;
  final _log = Logger('Login View');

  Future<void> _signIn() async {
    setState(() {
      _isLoading = true;
    });
    final response = await Supabase.instance.client.auth.signIn(
      email: _emailController.text,
      options: AuthOptions(redirectTo: kIsWeb ? null : 'io.supabase.flutterquickstart://login-callback/'),
    );
    final error = response.error;
    if (error != null) {
      _log.warning(error.message);
      showSnackbar(error.message);
    } else {
      _log.info('Check your email for login link!');
      if (mounted) {
        showSnackbar(S.of(context).checkEmailForLink);
      }
      _emailController.clear();
    }

    setState(() {
      _isLoading = false;
    });
  }

  void showSnackbar(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).signIn)),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
        children: [
          Text(S.of(context).signInViaMagicLink),
          const SizedBox(height: 18),
          TextFormField(
            controller: _emailController,
          ),
          const SizedBox(height: 18),
          ElevatedButton(
            onPressed: _isLoading ? null : _signIn,
            child: Text(_isLoading ? S.of(context).loading : S.of(context).sendMagicLink),
          ),
        ],
      ),
    );
  }
}
