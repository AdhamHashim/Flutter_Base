import 'package:flutter/foundation.dart';

import '../../../../../core/theme/app_theme_controller.dart';

class SettingsScreenViewController {
  SettingsScreenViewController() {
    _darkBackground.value = AppThemeController.readSavedDarkMode();
  }

  final ValueNotifier<bool> _darkBackground = ValueNotifier<bool>(false);

  ValueNotifier<bool> get darkBackground => _darkBackground;

  Future<void> onBackgroundToggle(bool enabled) async {
    _darkBackground.value = enabled;
    await AppThemeController.instance.setDarkMode(enabled);
  }

  void dispose() {
    _darkBackground.dispose();
  }
}
