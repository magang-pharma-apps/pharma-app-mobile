import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:medpia_mobile/app/commons/ui/theme.dart';
import 'package:medpia_mobile/app/core_view.dart';
import 'package:medpia_mobile/app/modules/auth/views/auth_view.dart';
import 'package:medpia_mobile/app/modules/category/views/category_view.dart';

class MainApp extends StatelessWidget {
  MainApp({super.key});
  final storage = GetStorage();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: storage.read('isLogin') ? CoreView() : AuthView(),
      theme: ThemeData(
        visualDensity: VisualDensity.compact,
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
            backgroundColor: Colors.white,
            elevation: 10,
            selectedIconTheme: IconThemeData(color: Colors.teal),
            unselectedIconTheme: IconThemeData(color: Colors.grey.shade500),
            selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
            showUnselectedLabels: true,
            showSelectedLabels: true,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.teal),
        iconTheme: IconThemeData(
          color: Colors.grey,
          size: 24,
        ),
        iconButtonTheme: IconButtonThemeData(
          style: IconButton.styleFrom(
            foregroundColor: ThemeManager.primaryColor,
            backgroundColor: Colors.transparent,
            visualDensity: VisualDensity.compact,
            padding: const EdgeInsets.all(0),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
                backgroundColor:
                    WidgetStateProperty.all(ThemeManager.primaryColor),
                foregroundColor: WidgetStatePropertyAll(Colors.white))),
        textButtonTheme: TextButtonThemeData(
            style: ButtonStyle(
                foregroundColor:
                    WidgetStateProperty.all(ThemeManager.primaryColor))),
        checkboxTheme:
            CheckboxThemeData(side: BorderSide(color: Colors.grey, width: 1.5)),
        inputDecorationTheme: InputDecorationTheme(
            labelStyle: TextStyle(fontSize: 14),
            hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
            prefixIconColor: ThemeManager.primaryColor,
            suffixIconColor: Colors.grey,
            filled: true,
            fillColor: Colors.white,
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide:
                    BorderSide(color: Colors.grey.shade200, width: 1.0))),
        textTheme: TextTheme(
            displayLarge: TextStyle(
                fontSize: 24, color: Colors.black, fontWeight: FontWeight.bold),
            displayMedium: TextStyle(
                fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
            displaySmall: TextStyle(
                fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
            titleLarge: TextStyle(
                fontSize: 20, color: Colors.teal, fontWeight: FontWeight.bold),
            titleMedium: TextStyle(
                fontSize: 16, color: Colors.teal, fontWeight: FontWeight.bold),
            titleSmall: TextStyle(
                fontSize: 14, color: Colors.teal, fontWeight: FontWeight.bold),
            bodyLarge: TextStyle(fontSize: 14, color: Colors.black),
            bodyMedium: TextStyle(fontSize: 12, color: Colors.black),
            bodySmall: TextStyle(fontSize: 10, color: Colors.black),
            labelLarge: TextStyle(
                fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
            labelMedium: TextStyle(
                fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold),
            labelSmall: TextStyle(
                fontSize: 12,
                color: Colors.black,
                fontWeight: FontWeight.bold)),
      ),
    );
  }
}
