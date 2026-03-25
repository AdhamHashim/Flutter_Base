import 'package:flutter/material.dart';

import '../helpers/cache_service.dart';
import '../../config/res/config_imports.dart';

/// Persists and applies light/dark [ThemeMode] for [MaterialApp].
class AppThemeController {
  AppThemeController._();
  static final AppThemeController instance = AppThemeController._();

  void Function(ThemeMode)? _apply;

  void register(void Function(ThemeMode) apply) {
    _apply = apply;
  }

  void unregister() {
    _apply = null;
  }

  static bool readSavedDarkMode() {
    final v = CacheStorage.read(AppPreferenceKeys.useDarkTheme);
    return v == true;
  }

  Future<void> setDarkMode(bool useDark) async {
    await CacheStorage.write(AppPreferenceKeys.useDarkTheme, useDark);
    _apply?.call(useDark ? ThemeMode.dark : ThemeMode.light);
  }
}
