import 'package:flutter/material.dart';
import 'package:explore/utils/theme/widget_themes/appbar_theme.dart';
import 'package:explore/utils/theme/widget_themes/bottom_sheet_theme.dart';
import 'package:explore/utils/theme/widget_themes/checkbox_theme.dart';
import 'package:explore/utils/theme/widget_themes/elevated_button_theme.dart';
import 'package:explore/utils/theme/widget_themes/outlined_button_theme.dart';
import 'package:explore/utils/theme/widget_themes/text_field_theme.dart';
import 'package:explore/utils/theme/widget_themes/text_theme.dart';

import '../constants/colors.dart';

class EAppTheme {
  EAppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Axiforma',
    disabledColor: EColors.grey,
    brightness: Brightness.light,
    primaryColor: EColors.dark,
    textTheme: ETextTheme.lightTextTheme,
    scaffoldBackgroundColor: EColors.white,
    appBarTheme: EAppBarTheme.lightAppBarTheme,
    checkboxTheme: ECheckboxTheme.lightCheckboxTheme,
    bottomSheetTheme: EBottomSheetTheme.lightBottomSheetTheme,
    elevatedButtonTheme: EElevatedButtonTheme.lightElevatedButtonTheme,
    outlinedButtonTheme: EOutlinedButtonTheme.lightOutlinedButtonTheme,
    inputDecorationTheme: ETextFormFieldTheme.lightInputDecorationTheme,
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Axiforma',
    disabledColor: EColors.grey,
    brightness: Brightness.dark,
    primaryColor: EColors.dark,
    textTheme: ETextTheme.darkTextTheme,
    scaffoldBackgroundColor: EColors.dark,
    appBarTheme: EAppBarTheme.darkAppBarTheme,
    checkboxTheme: ECheckboxTheme.darkCheckboxTheme,
    bottomSheetTheme: EBottomSheetTheme.darkBottomSheetTheme,
    elevatedButtonTheme: EElevatedButtonTheme.darkElevatedButtonTheme,
    outlinedButtonTheme: EOutlinedButtonTheme.darkOutlinedButtonTheme,
    inputDecorationTheme: ETextFormFieldTheme.darkInputDecorationTheme,
  );
}
