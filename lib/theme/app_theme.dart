import 'package:flutter/material.dart';

class AppTheme {
  // กำหนดสีหลักของแอป
  static const Color primaryColor = Color(0xFF003d2e);

  // ถ้าต้องการกำหนดสีรอง หรือสีอื่น ๆ ไว้ใช้งาน
  static const Color secondaryColor = Color(0xFF004F3C);

  // กำหนด ThemeData หลักของแอป
  static ThemeData get lightTheme {
    return ThemeData(
      // สีหลัก
      primaryColor: primaryColor,

      // ถ้าใช้ Material 3 (Flutter 3.0+) สามารถใช้ ColorScheme.fromSeed ได้
      colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),

      // สีพื้นหลังของ Scaffold
      scaffoldBackgroundColor: Colors.white,

      // AppBar Theme
      appBarTheme: const AppBarTheme(
        backgroundColor: primaryColor,
        iconTheme: IconThemeData(color: Colors.white, size: 30),
        titleTextStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),

      tabBarTheme: const TabBarTheme(
        labelColor: Colors.white,
        unselectedLabelColor: Colors.white,
        labelStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        unselectedLabelStyle: TextStyle(fontSize: 16),
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(width: 5, color: Colors.white),
        ),
      ),

      // BottomNavigationBar Theme
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: primaryColor,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        showSelectedLabels: true,
        showUnselectedLabels: false,
      ),

      // TextTheme
      textTheme: const TextTheme(
        // ตัวอย่างกำหนด style ให้บางส่วน
        titleLarge: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        bodyMedium: TextStyle(color: Colors.black),
      ),

      // สามารถกำหนด Theme อื่น ๆ เพิ่มเติมได้ เช่น ElevatedButtonTheme, IconTheme ฯลฯ
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: secondaryColor, // ใช้สีรอง
          foregroundColor: Colors.white,
        ),
      ),
    );
  }

  // ถ้าต้องการทำธีม Dark Theme ก็สามารถสร้างอีกตัวได้
  static ThemeData get darkTheme {
    return ThemeData.dark().copyWith(
      // กำหนดค่าที่ต้องการปรับเพิ่ม/ลด
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        brightness: Brightness.dark,
      ),
      // ปรับค่าอื่น ๆ สำหรับ dark theme ตามต้องการ
    );
  }
}
