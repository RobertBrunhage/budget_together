import 'package:flutter/material.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'app.dart';
import 'config.dart';
import 'core/error_handling/app_logger.dart';

Future<void> main() async {
  // Run the app and pass in the SettingsController. The app listens to the
  // SettingsController for changes, then passes it further down to the
  // SettingsView.
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDisplayMode.setHighRefreshRate();
  final config = Config();
  final logger = AppLogger();
  logger.initLogging();

  await Supabase.initialize(
    url: config.url,
    anonKey: config.anonKey,
    authCallbackUrlHostname: 'login-callback', // optional
  );
  await SentryFlutter.init(
    (options) {
      options.dsn = config.sentryDns;
      // Set tracesSampleRate to 1.0 to capture 100% of transactions for performance monitoring.
      // We recommend adjusting this value in production.
      options.tracesSampleRate = 1.0;
    },
    appRunner: () => runApp(const ProviderScope(child: MyApp())),
  );
}
