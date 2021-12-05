import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'authentication/auth/auth_controller.dart';
import 'authentication/login_view.dart';
import 'authentication/splash_view.dart';
import 'household/views/household_create_view.dart';
import 'household/views/household_view.dart';
import 'invite/household_invite_view.dart';
import 'theme/custom_theme.dart';

/// The Widget that configures your application.
class MyApp extends ConsumerStatefulWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  late final _router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        name: SplashView.route,
        builder: (context, state) => const SplashView(),
      ),
      GoRoute(
        path: '/household',
        name: HouseholdView.route,
        builder: (context, state) => const HouseholdView(),
        routes: [
          GoRoute(
            path: 'create',
            name: HouseholdCreateView.route,
            builder: (context, state) => const HouseholdCreateView(),
          ),
          GoRoute(
            path: 'invite',
            name: HouseholdInviteView.route,
            builder: (context, state) => const HouseholdInviteView(),
          ),
        ],
      ),
      GoRoute(
        path: '/login',
        name: LoginView.route,
        builder: (context, state) => const LoginView(),
      ),
    ],
    redirect: (state) {
      final bool loggedIn;
      if (ref.watch(authControllerProvider).session == null) {
        loggedIn = false;
      } else {
        loggedIn = true;
      }

      final goingToLogin = state.location == '/login';
      log('loggedIn: $loggedIn');
      log('goingToLogin: $goingToLogin');

      // the user is not logged in and not headed to /login, they need to login
      if (!loggedIn && !goingToLogin) return '/login';

      // the user is logged in and headed to /login, no need to login again
      if (loggedIn && goingToLogin) return '/household';

      // no need to redirect at all
      return null;
    },
    refreshListenable: ref.watch(authControllerProvider),
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationParser: _router.routeInformationParser,
      routerDelegate: _router.routerDelegate,
      restorationScopeId: 'app',
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''), // English, no country code
      ],
      scrollBehavior: const ScrollBehaviorModified(),
      onGenerateTitle: (context) => AppLocalizations.of(context)!.appTitle,
      theme: lightTheme(context),
    );
  }
}

class ScrollBehaviorModified extends ScrollBehavior {
  const ScrollBehaviorModified();
  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    switch (getPlatform(context)) {
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
      case TargetPlatform.android:
        return const BouncingScrollPhysics();
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return const ClampingScrollPhysics();
    }
  }
}
