import 'package:flutter/material.dart';

ThemeData darkTheme() {
  return ThemeData(
    cardColor: const Color(0xff2e3035),
    textTheme: Typography.whiteCupertino.copyWith(
      bodyText1: Typography.whiteCupertino.bodyText1.copyWith(
        fontFamily: 'SFProText',
        color: const Color(0xffffffff),
        fontSize: 16,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
        letterSpacing: 0.2049999982118607,
      ),
      subtitle2: Typography.whiteCupertino.bodyText1.copyWith(
        fontFamily: 'SFProText',
        color: const Color(0xfffcfcfc),
        fontSize: 17,
        fontWeight: FontWeight.w600,
        fontStyle: FontStyle.normal,
        letterSpacing: -0.1484128333333334,
      ),
      caption: Typography.whiteCupertino.bodyText1.copyWith(
        fontFamily: 'SFProText',
        color: const Color(0xffcdcdcd),
        fontSize: 13,
        fontWeight: FontWeight.w600,
        fontStyle: FontStyle.normal,
        letterSpacing: -0.1134921666666666,
      ),
      overline: Typography.whiteCupertino.bodyText1.copyWith(
        fontFamily: 'SFProText',
        color: const Color(0xffcdcdcd),
        fontSize: 13,
        fontWeight: FontWeight.w600,
        fontStyle: FontStyle.normal,
        letterSpacing: -0.1134921666666666,
      ),
      bodyText2: Typography.whiteCupertino.bodyText2.copyWith(
        fontFamily: 'SFProText',
        color: const Color(0xff939393),
        fontSize: 14,
        fontWeight: FontWeight.w700,
        fontStyle: FontStyle.normal,
        letterSpacing: -0.104762,
      ),
    ),
    buttonTheme: const ButtonThemeData(
      textTheme: ButtonTextTheme.primary,
      buttonColor: Color(0xff2e3035),
    ),
    primaryColor: const Color(0xffce7224),
    backgroundColor: const Color(0xff2e3035),
    brightness: Brightness.dark,
    fontFamily: 'SFProText',
    scaffoldBackgroundColor: const Color(0xff202225),
    inputDecorationTheme: InputDecorationTheme(
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.all(
          Radius.circular(4),
        ),
      ),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.all(
          Radius.circular(4),
        ),
      ),
      errorBorder: const OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.all(
          Radius.circular(4),
        ),
      ),
      disabledBorder: const OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.all(
          Radius.circular(4),
        ),
      ),
      border: const OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.all(
          Radius.circular(4),
        ),
      ),
      filled: true,
      fillColor: const Color(0xff2e3035),
      labelStyle: TextStyle(
        color: const Color(0xffcbcbcb),
        fontSize: 16,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
    ),
  );
}
