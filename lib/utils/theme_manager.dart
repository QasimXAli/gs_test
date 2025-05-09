import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeManager {
  static const Color scaffoldColor = Color(0xffDFE1ED);
  static const Color whiteColor = Color(0xffFFFFFF);
  static const Color blackColor = Color(0xff000000);
  static const Color transparent = Colors.transparent;
  static const Color elevatedButtonBGColor = Color(0xffCFD3E3);

  static final TextTheme textTheme = TextTheme(
    titleLarge: GoogleFonts.poppins(
      textStyle: TextStyle(
        fontSize: 22,
        color: blackColor,
      ),
    ),
    titleMedium: GoogleFonts.poppins(
        textStyle: TextStyle(
      fontSize: 16,
      color: blackColor,
    )),
    titleSmall: GoogleFonts.poppins(
      textStyle: TextStyle(
        fontSize: 14,
        color: blackColor,
      ),
    ),
  );

  static final ThemeData themeData = ThemeData(
    scaffoldBackgroundColor: scaffoldColor,
    textTheme: textTheme,
    appBarTheme: const AppBarTheme(
      backgroundColor: whiteColor,
      elevation: 0,
    ),
    brightness: Brightness.light,
    useMaterial3: false,
  );
}
