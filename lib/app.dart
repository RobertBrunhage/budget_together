import 'package:budget_together/Authentication/auth/auth_controller.dart';
import 'package:budget_together/Authentication/login.dart';
import 'package:budget_together/Authentication/splash.dart';
import 'package:budget_together/Household/views/household_add_expense_view.dart';
import 'package:budget_together/Household/views/household_create_view.dart';
import 'package:budget_together/Household/views/household_invite_view.dart';
import 'package:budget_together/Household/views/household_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

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
        pageBuilder: (context, state) => MaterialPage<void>(
          key: state.pageKey,
          name: 'splash',
          child: const SplashView(),
        ),
      ),
      GoRoute(
        path: '/household',
        pageBuilder: (context, state) => MaterialPage<void>(
          key: state.pageKey,
          name: 'household',
          child: const HouseholdView(),
        ),
        routes: [
          GoRoute(
            path: 'create',
            pageBuilder: (context, state) => MaterialPage<void>(
              key: state.pageKey,
              name: 'householdCreateView',
              child: const HouseholdCreateView(),
            ),
          ),
          GoRoute(
            path: 'add-expense',
            pageBuilder: (context, state) => MaterialPage<void>(
              key: state.pageKey,
              name: 'addExpense',
              child: const AddExpenseView(),
            ),
          ),
          GoRoute(
            path: 'invite',
            pageBuilder: (context, state) => MaterialPage<void>(
              key: state.pageKey,
              name: 'invite',
              child: const HouseholdInviteView(),
            ),
          ),
        ],
      ),
      GoRoute(
        path: '/login',
        pageBuilder: (context, state) => MaterialPage<void>(
          key: state.pageKey,
          name: 'login',
          child: const LoginView(),
        ),
      ),
    ],
    errorPageBuilder: (BuildContext context, GoRouterState state) {
      return MaterialPage<void>(
        key: state.pageKey,
        child: const Scaffold(
          body: Center(child: Text('ERROR')),
        ),
      );
    },
    redirect: (state) {
      final loggedIn =
          ref.watch(authControllerProvider).session == null ? false : true;

      final goingToLogin = state.location == '/login';

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
      onGenerateTitle: (BuildContext context) =>
          AppLocalizations.of(context)!.appTitle,
      theme: ThemeData(),
      darkTheme: ThemeData.dark(),
    );
  }
}
