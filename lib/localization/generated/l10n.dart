// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Expense Tracker`
  String get appTitle {
    return Intl.message(
      'Expense Tracker',
      name: 'appTitle',
      desc: '',
      args: [],
    );
  }

  /// `No internet connection`
  String get noInternetConnection {
    return Intl.message(
      'No internet connection',
      name: 'noInternetConnection',
      desc: '',
      args: [],
    );
  }

  /// `Invite`
  String get invite {
    return Intl.message(
      'Invite',
      name: 'invite',
      desc: '',
      args: [],
    );
  }

  /// `Budget together`
  String get appName {
    return Intl.message(
      'Budget together',
      name: 'appName',
      desc: '',
      args: [],
    );
  }

  /// `Sign out`
  String get signOut {
    return Intl.message(
      'Sign out',
      name: 'signOut',
      desc: '',
      args: [],
    );
  }

  /// `Expenses`
  String get expenses {
    return Intl.message(
      'Expenses',
      name: 'expenses',
      desc: '',
      args: [],
    );
  }

  /// `Spent this month`
  String get spentThisMonth {
    return Intl.message(
      'Spent this month',
      name: 'spentThisMonth',
      desc: '',
      args: [],
    );
  }

  /// `Household name`
  String get householdName {
    return Intl.message(
      'Household name',
      name: 'householdName',
      desc: '',
      args: [],
    );
  }

  /// `Field is required`
  String get fieldIsRequiredMessage {
    return Intl.message(
      'Field is required',
      name: 'fieldIsRequiredMessage',
      desc: '',
      args: [],
    );
  }

  /// `Submit`
  String get submit {
    return Intl.message(
      'Submit',
      name: 'submit',
      desc: '',
      args: [],
    );
  }

  /// `Sign In`
  String get signIn {
    return Intl.message(
      'Sign In',
      name: 'signIn',
      desc: '',
      args: [],
    );
  }

  /// `Sign in via the magic link with your email below`
  String get signInViaMagicLink {
    return Intl.message(
      'Sign in via the magic link with your email below',
      name: 'signInViaMagicLink',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Loading`
  String get loading {
    return Intl.message(
      'Loading',
      name: 'loading',
      desc: '',
      args: [],
    );
  }

  /// `Send Magic Link`
  String get sendMagicLink {
    return Intl.message(
      'Send Magic Link',
      name: 'sendMagicLink',
      desc: '',
      args: [],
    );
  }

  /// `Check your email for login link!`
  String get checkEmailForLink {
    return Intl.message(
      'Check your email for login link!',
      name: 'checkEmailForLink',
      desc: '',
      args: [],
    );
  }

  /// `add`
  String get add {
    return Intl.message(
      'add',
      name: 'add',
      desc: '',
      args: [],
    );
  }

  /// `add expense`
  String get addExpense {
    return Intl.message(
      'add expense',
      name: 'addExpense',
      desc: '',
      args: [],
    );
  }

  /// `Sum *`
  String get sumLabelNotRequired {
    return Intl.message(
      'Sum *',
      name: 'sumLabelNotRequired',
      desc: '',
      args: [],
    );
  }

  /// `Sum is required`
  String get sumRequiredMessage {
    return Intl.message(
      'Sum is required',
      name: 'sumRequiredMessage',
      desc: '',
      args: [],
    );
  }

  /// `New category`
  String get newCategory {
    return Intl.message(
      'New category',
      name: 'newCategory',
      desc: '',
      args: [],
    );
  }

  /// `Category`
  String get category {
    return Intl.message(
      'Category',
      name: 'category',
      desc: '',
      args: [],
    );
  }

  /// `Category *`
  String get categoryNotRequiredLabel {
    return Intl.message(
      'Category *',
      name: 'categoryNotRequiredLabel',
      desc: '',
      args: [],
    );
  }

  /// `Your new category needs a name`
  String get categoryRequiredMessage {
    return Intl.message(
      'Your new category needs a name',
      name: 'categoryRequiredMessage',
      desc: '',
      args: [],
    );
  }

  /// `Category budget`
  String get categoryBudget {
    return Intl.message(
      'Category budget',
      name: 'categoryBudget',
      desc: '',
      args: [],
    );
  }

  /// `error`
  String get genericErrorMessage {
    return Intl.message(
      'error',
      name: 'genericErrorMessage',
      desc: '',
      args: [],
    );
  }

  /// `no entities exists`
  String get noEntitiesExists {
    return Intl.message(
      'no entities exists',
      name: 'noEntitiesExists',
      desc: '',
      args: [],
    );
  }

  /// `No expenses`
  String get noExpenses {
    return Intl.message(
      'No expenses',
      name: 'noExpenses',
      desc: '',
      args: [],
    );
  }

  /// `email is required`
  String get emailIsRequiredMessage {
    return Intl.message(
      'email is required',
      name: 'emailIsRequiredMessage',
      desc: '',
      args: [],
    );
  }

  /// `{total}`
  String totalSpent(double total) {
    final NumberFormat totalNumberFormat = NumberFormat.currency(
        locale: Intl.getCurrentLocale(), symbol: 'kr', decimalDigits: 2);
    final String totalString = totalNumberFormat.format(total);

    return Intl.message(
      '$totalString',
      name: 'totalSpent',
      desc: '',
      args: [totalString],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'sv', countryCode: 'SE'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
