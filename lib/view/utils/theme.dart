import 'package:flutter/material.dart';
import 'package:poketest/view/utils/colors.dart';

class CustomTheme {

  static const double cornerRadius = 12.0;
  static const double defaultInset = 16.0;
  static const double defaultPadding = 16.0;
  static const double smallPadding = 8.0;
  static const double buttonFontSize = 16.0;
  static const double headerFontSize = 24.0;
  static const double subtitleFontSize = 16.0;
  static const double circleSpinnerStroke = 3.0;


  static ThemeData get defaultTheme {
    return ThemeData(
        appBarTheme: const AppBarTheme(
            color: Colors.white,
            foregroundColor: CustomColors.deepPurple,
            shadowColor: Colors.white,
            iconTheme: IconThemeData(
                color: CustomColors.deepPurple
            )
        ),

        primaryColor: CustomColors.textTitle,
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Roboto',
        textTheme: CustomTheme.defaultTextTheme,
        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          fillColor: CustomColors.grey,
          errorStyle: TextStyle(
              color: CustomColors.errorRed,
              fontFamily: "Roboto",
              fontSize: CustomTheme.subtitleFontSize,
              fontWeight: FontWeight.w400,
              fontStyle: FontStyle.normal
          ),
        )
    );
  }


  static TextTheme get defaultTextTheme {
    return ThemeData.light().textTheme.copyWith(
      headline1: const TextStyle(
          color: CustomColors.deepPurple,
          fontFamily: "Roboto",
          fontSize: CustomTheme.headerFontSize,
          fontWeight: FontWeight.w600,
          fontStyle: FontStyle.normal
      ),
      headline2: const TextStyle(
          color: CustomColors.textBlack,
          fontFamily: "Roboto",
          fontSize: CustomTheme.subtitleFontSize,
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal
      ),
      headline3: const TextStyle(
          color: CustomColors.textBlack,
          fontFamily: "Roboto",
          fontSize: CustomTheme.subtitleFontSize + 2,
          fontWeight: FontWeight.w600,
          fontStyle: FontStyle.normal
      ),
    );
  }

}