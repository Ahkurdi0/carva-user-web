import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kcars/core/utils/extensions.dart';

appTheme(BuildContext context) {
  final locale = context.locale.languageCode.toString();
  return ThemeData(
    appBarTheme: AppBarTheme(
      titleTextStyle: context.title2Bold.copyWith(
        fontFamily: locale == "en" ? "plus-jakarta" : "urw",
      ),
      centerTitle: false,
      backgroundColor: Colors.white,
      elevation: 0,
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        overlayColor: WidgetStateProperty.resolveWith<Color?>((
          Set<WidgetState> states,
        ) {
          if (states.contains(WidgetState.pressed)) {
            return Color(0xFFEDEDED);
          }
          return null;
        }),

        foregroundColor: WidgetStateProperty.resolveWith<Color>((
          Set<WidgetState> states,
        ) {
          return Color(0xFF23262e);
        }),
      ),
    ),
    fontFamily: locale == "en" ? "plus-jakarta" : "urw",
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xFF3957d7),
      primaryContainer: Color(0xFFf1f4fd),
      onPrimary: Colors.white,
      secondary: Color(0xFF23262e),
      secondaryContainer: Color(0xFFFBFBFB),
      onSecondary: Colors.white,
      error: Colors.red,
      onError: Colors.white,
      surface: Colors.white,
      onSurface: Color(0xFF23262e),
      outline: Color(0xFF9E9E9E),
      surfaceContainerLowest: Color(0xFFF7F7F7),
      surfaceContainerLow: Color(0xFFEDEDED),
      surfaceContainer: Color(0xFF9E9E9E),
      surfaceTint: Color(0xff25D366),
      onSurfaceVariant: Color(0xff103928),
    ),
  );
}
