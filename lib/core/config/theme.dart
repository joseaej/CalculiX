import 'package:flutter/material.dart';

import 'app_colors.dart';

// Clase que exporta el objeto ThemeData completo
class CalculixTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      // 1. Configuración de Color Scheme (Esquema de Colores)
      colorScheme: const ColorScheme.light(
        primary: AppColors.primaryBlue,
        secondary:
            AppColors.accentCyan, // Usado por Floating Action Buttons, etc.
        surface: Colors.white,
        error: Colors.redAccent,
        onPrimary: AppColors.textLight,
        onSurface: AppColors.textDark,
      ),

      // 2. Configuración de Tipografía
      fontFamily: 'Inter', // Se asume que has incluido una fuente como Inter
      textTheme: const TextTheme(
        // Estilo para el título principal
        headlineLarge: TextStyle(
          color: AppColors.primaryBlue,
          fontWeight: FontWeight.bold,
        ),
        // Estilo general para el cuerpo del texto
        bodyMedium: TextStyle(color: AppColors.textDark, fontSize: 16.0),
      ),

      // 3. Tema para la AppBar
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: AppColors.textLight, // Color de iconos y texto
        elevation: 0, // AppBar sin sombra
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: AppColors.textLight,
        ),
      ),

      // 4. Tema para Botones Elevados (Botones de acción principal)
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.accentCyan,
          foregroundColor: AppColors.textLight,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0), // Esquinas redondeadas
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          elevation: 3, // Sombra sutil para un efecto 3D
        ),
      ),

      // 5. Tema para Campos de Entrada (donde el usuario ingresará respuestas)
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: const TextStyle(color: AppColors.primaryBlue),
        hintStyle: const TextStyle(color: Colors.grey),
        // Bordes redondeados y enfocados en azul
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: Colors.grey, width: 1.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: AppColors.lightBlue, width: 2.5),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        filled: true,
        fillColor: Colors.white,
      ),

      // 6. Tema para Cards (para mostrar retos y estadísticas)
      cardTheme: CardThemeData(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 0),
      ),
    );
  }
  
  // ===========================================================================
  // TEMA OSCURO (DARK THEME)
  // ===========================================================================
  static ThemeData get darkTheme {
    // Colores base para un tema oscuro:
    const Color darkBackground = Color(0xFF121212); // Fondo muy oscuro
    const Color darkSurface = Color(0xFF1E1E1E); // Superficie para Cards/AppBar
    
    return ThemeData(
      brightness: Brightness.dark,
      
      // 1. Configuración de Color Scheme (Esquema de Colores)
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primaryBlue, // Azul claro para el modo oscuro
        secondary: AppColors.lightBlue, 
        surface: darkSurface,
        error: Color(0xFFCF6679), // Rojo estándar para oscuro
        onPrimary: AppColors.textDark, // Texto oscuro sobre azul claro
        onSurface: AppColors.textLight, // Texto claro sobre fondo oscuro
      ),
      
      // 2. Configuración de Tipografía
      fontFamily: 'Inter',
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          color: AppColors.textLight, // Azul claro para títulos
          fontWeight: FontWeight.bold,
        ),
        bodyMedium: TextStyle(
          color: AppColors.textLight, // Texto blanco general
          fontSize: 16.0,
        ),
      ),

      // 3. Tema para la AppBar (Usando el color de superficie oscuro)
      appBarTheme: const AppBarTheme(
        backgroundColor: darkSurface, 
        foregroundColor: AppColors.textLight,
        elevation: 1, 
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: AppColors.textLight,
        ),
      ),

      // 4. Tema para Botones Elevados (Botones de acción principal)
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.accentCyan, // Accent permanece
          foregroundColor: darkBackground, // Texto muy oscuro sobre accent cian
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          textStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          elevation: 3,
        ),
      ),

      // 5. Tema para Campos de Entrada
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: const TextStyle(color: AppColors.lightBlue),
        hintStyle: const TextStyle(color: Colors.grey),
        // Bordes adaptados al fondo oscuro
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: Colors.grey, width: 1.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: AppColors.primaryBlue, width: 2.5),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        filled: true,
        fillColor: darkSurface, // Fondo del campo ligeramente más claro que el fondo general
      ),
      
      // 6. Tema para Cards
      cardTheme: CardThemeData(
        color: darkSurface, // Superficie más clara que el fondo
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 0),
      ),
    );
  }
}
