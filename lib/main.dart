import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'app.dart';
import 'config.dart';

Future<void> main() async {
  // Run the app and pass in the SettingsController. The app listens to the
  // SettingsController for changes, then passes it further down to the
  // SettingsView.
  WidgetsFlutterBinding.ensureInitialized();
  final config = Config();

  await Supabase.initialize(
    url: config.url,
    anonKey: config.anonKey,
    authCallbackUrlHostname: 'login-callback', // optional
  );

  runApp(const ProviderScope(child: MyApp()));
}
