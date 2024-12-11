// lib/core/theme/theme_provider.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  
  ThemeMode get themeMode => _themeMode;

  // Load theme from local storage
  ThemeProvider() {
    _loadThemeFromPrefs();
  }

  // Toggle between light and dark themes
  void toggleTheme() {
    _themeMode = _themeMode == ThemeMode.light 
        ? ThemeMode.dark 
        : ThemeMode.light;
    
    _saveThemeToPrefs();
    notifyListeners();
  }

  // Save theme preference to local storage
  Future<void> _saveThemeToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('theme', _themeMode.toString());
  }

  // Load theme preference from local storage
  Future<void> _loadThemeFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final themeName = prefs.getString('theme');
    
    if (themeName != null) {
      _themeMode = ThemeMode.values.firstWhere(
        (mode) => mode.toString() == themeName, 
        orElse: () => ThemeMode.system
      );
      notifyListeners();
    }
  }
}