import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class CustomTheme {
  static ThemeData lightTheme(BuildContext context) {
    final theme = Theme.of(context);
    return ThemeData.light().copyWith(
      scaffoldBackgroundColor: Colors.white,
      textTheme: GoogleFonts.quicksandTextTheme(
        theme.textTheme
            .copyWith(
              headline1: theme.textTheme.headline1?.copyWith(
                fontSize: 34,
              ),
              headline2: theme.textTheme.headline2?.copyWith(
                fontSize: 24,
              ),
              headline3: theme.textTheme.headline3?.copyWith(
                fontSize: 20,
              ),
              headline4: theme.textTheme.headline4?.copyWith(
                fontSize: 16,
              ),
              bodyText1: theme.textTheme.bodyText1?.copyWith(
                fontSize: 16,
              ),
              bodyText2: theme.textTheme.bodyText2?.copyWith(
                fontSize: 14,
              ),
              caption: theme.textTheme.caption?.copyWith(
                fontSize: 12,
              ),
            )
            .apply(
              displayColor: Colors.black,
              bodyColor: Colors.black,
            ),
      ),
    );
  }
}
