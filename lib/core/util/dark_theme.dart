import 'package:flutter/material.dart';

ThemeData darkTheme() {
  return ThemeData(
    cardColor: Color(0xff2e3035),
    textTheme: Typography.whiteCupertino.copyWith(
      body1: Typography.whiteCupertino.body1.copyWith(
        fontFamily: 'SFProText',
        color: Color(0xffffffff),
        fontSize: 16,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
        letterSpacing: 0.2049999982118607,
        
      ),
      subtitle: Typography.whiteCupertino.body1.copyWith(
        fontFamily: 'SFProText',
        color: Color(0xfffcfcfc),
        fontSize: 17,
        fontWeight: FontWeight.w600,
        fontStyle: FontStyle.normal,
        letterSpacing: -0.1484128333333334,
      ),
      caption: Typography.whiteCupertino.body1.copyWith(
        fontFamily: 'SFProText',
        color: Color(0xffcdcdcd),
        fontSize: 13,
        fontWeight: FontWeight.w600,
        fontStyle: FontStyle.normal,
        letterSpacing: -0.1134921666666666,
      ),
      overline: Typography.whiteCupertino.body1.copyWith(
        fontFamily: 'SFProText',
        color: Color(0xffcdcdcd),
        fontSize: 13,
        fontWeight: FontWeight.w600,
        fontStyle: FontStyle.normal,
        letterSpacing: -0.1134921666666666,
      ),
      body2: Typography.whiteCupertino.body1.copyWith(
        fontFamily: 'SFProText',
        color: Color(0xff939393),
        fontSize: 14,
        fontWeight: FontWeight.w700,
        fontStyle: FontStyle.normal,
        letterSpacing: -0.104762,
      ),
    ),
    buttonTheme: ButtonThemeData(
      textTheme: ButtonTextTheme.primary,
      buttonColor: Color(0xff2e3035),
    ),
    primaryColor: Color(0xffce7224),
    backgroundColor: Color(0xff2e3035),
    brightness: Brightness.dark,
    fontFamily: 'SFProText',
    scaffoldBackgroundColor: Color(0xff202225),
    inputDecorationTheme: InputDecorationTheme(
      focusedBorder: new OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: const BorderRadius.all(
          const Radius.circular(4),
        ),
      ),
      enabledBorder: new OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: const BorderRadius.all(
          const Radius.circular(4),
        ),
      ),
      errorBorder: new OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: const BorderRadius.all(
          const Radius.circular(4),
        ),
      ),
      disabledBorder: new OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: const BorderRadius.all(
          const Radius.circular(4),
        ),
      ),
      border: new OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: const BorderRadius.all(
          const Radius.circular(4),
        ),
      ),
      filled: true,
      fillColor: Color(0xff2e3035),
      labelStyle: TextStyle(
        color: Color(0xffcbcbcb),
        fontSize: 16,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
    ),
    
  );
}
