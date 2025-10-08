import 'dart:developer';

import 'package:gaimon/gaimon.dart';

/// A utility class to manage haptic feedback using the Gaimon package.
class HapticFeedbackManager {
  /// Checks if haptic feedback is supported on the current device.
  /// Returns `true` if supported, `false` otherwise.
  static Future<bool> canSupportHaptic() async {
    try {
      return await Gaimon.canSupportsHaptic;
    } catch (e) {
      log('Error checking haptic support: $e');
      return false;
    }
  }

  /// Triggers a selection haptic feedback (used for tap events).
  static void selection() {
    try {
      Gaimon.selection();
    } catch (e) {
      log('Error triggering selection haptic: $e');
    }
  }

  /// Triggers a success haptic feedback (used for successful events).
  static void success() {
    try {
      Gaimon.success();
    } catch (e) {
      log('Error triggering success haptic: $e');
    }
  }

  /// Triggers an error haptic feedback (used for error events).
  static void error() {
    try {
      Gaimon.error();
    } catch (e) {
      log('Error triggering error haptic: $e');
    }
  }

  /// Triggers a warning haptic feedback (used for warning events).
  static void warning() {
    try {
      Gaimon.warning();
    } catch (e) {
      log('Error triggering warning haptic: $e');
    }
  }

  /// Triggers a heavy haptic feedback.
  static void heavy() {
    try {
      Gaimon.heavy();
    } catch (e) {
      log('Error triggering heavy haptic: $e');
    }
  }

  /// Triggers a medium haptic feedback.
  static void medium() {
    try {
      Gaimon.medium();
    } catch (e) {
      log('Error triggering medium haptic: $e');
    }
  }

  /// Triggers a light haptic feedback.
  static void light() {
    try {
      Gaimon.light();
    } catch (e) {
      log('Error triggering light haptic: $e');
    }
  }

  /// Triggers a rigid haptic feedback (huge but fast).
  static void rigid() {
    try {
      Gaimon.rigid();
    } catch (e) {
      log('Error triggering rigid haptic: $e');
    }
  }

  /// Triggers a soft haptic feedback (medium but fast).
  static void soft() {
    try {
      Gaimon.soft();
    } catch (e) {
      log('Error triggering soft haptic: $e');
    }
  }

  /// Triggers a custom haptic pattern from an AHAP file.
  /// [data] is the path to the .ahap file or its JSON content.
  /// Note: Custom patterns are only supported on iPhone 8 and newer.
  // static Future<void> customPattern(String data) async {
  //   try {
  //     await Gaimon.patternFromWaveForm(data);
  //   } on PlatformException catch (e) {
  //     log('Error triggering custom haptic pattern: ${e.message}');
  //   } catch (e) {
  //     log('Unexpected error triggering custom haptic pattern: $e');
  //   }
  // }
}
