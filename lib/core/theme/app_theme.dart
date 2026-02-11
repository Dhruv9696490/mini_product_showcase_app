import 'package:flutter/material.dart';
import 'app_pallete.dart';

class AppTheme {
  static get darkTheme => ThemeData.dark().copyWith(
    popupMenuTheme: const PopupMenuThemeData(
      color: AppPallete.backgroundColor
    ),
    appBarTheme: AppBarTheme(
      actionsIconTheme: const IconThemeData(color: AppPallete.whiteColor),
      backgroundColor: AppPallete.appBarColor,
      elevation: 0,
      titleTextStyle: const TextStyle(
        fontSize: 30,
        color: Colors.white,
        fontWeight: FontWeight.w600,
      ),
    ),
    tabBarTheme: TabBarThemeData(
      labelStyle: const TextStyle(fontWeight: FontWeight.bold),
      unselectedLabelStyle: const TextStyle(
        fontWeight: FontWeight.bold,
      ),
      indicatorColor: AppPallete.tabColor,
      labelColor: AppPallete.whiteColor,
      unselectedLabelColor: AppPallete.whiteColor,
    ),
    scaffoldBackgroundColor: AppPallete.backgroundColor,
    inputDecorationTheme: const InputDecorationTheme(
      fillColor: AppPallete.backgroundColor,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        foregroundColor: AppPallete.whiteColor,
        elevation: 5,
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      elevation: 0,
      foregroundColor: Colors.white,
      backgroundColor: AppPallete.appBarColor
      
    ),
  );
  static get lightTheme => ThemeData.light().copyWith(
    appBarTheme:AppBarTheme(
      actionsIconTheme: IconThemeData(color: AppPallete.blackColor),
      iconTheme: IconThemeData(color: AppPallete.blackColor),
      backgroundColor: AppPallete.whatsAppColor,
      elevation: 0,
      titleTextStyle: const TextStyle(
        fontSize: 30,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    ),
    tabBarTheme: const TabBarThemeData(
      labelStyle: TextStyle(fontWeight: FontWeight.bold),
      unselectedLabelStyle: TextStyle(
        fontWeight: FontWeight.bold,
      ),
      indicatorColor: AppPallete.whiteColor,
      labelColor: AppPallete.whiteColor,
      unselectedLabelColor: AppPallete.whiteColor,
    ),
    scaffoldBackgroundColor: AppPallete.whiteColor,
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        foregroundColor: Colors.white,
        elevation: 5,
      ),
    ),
    floatingActionButtonTheme:FloatingActionButtonThemeData(
      foregroundColor: Colors.white,
      backgroundColor: AppPallete.tabColor,
    ),
  );
}
