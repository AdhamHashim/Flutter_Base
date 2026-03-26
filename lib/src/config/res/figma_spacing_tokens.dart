part of 'config_imports.dart';

/// Figma spacing primitives (`mode_1_spacing_tokens.json` — 8px grid).
/// Use for new UI; existing code may still use [AppPadding] / [AppSize].
abstract final class FigmaSpacing {
  static double get space0 => 0.0.h;
  static double get space0_5 => 2.0.h;
  static double get space1 => 4.0.h;
  static double get space1_5 => 6.0.h;
  static double get space2 => 8.0.h;
  static double get space3 => 12.0.h;
  static double get space4 => 16.0.h;
  static double get space5 => 20.0.h;
  static double get space6 => 24.0.h;
  static double get space12 => 48.0.h;
  static double get space16 => 64.0.h;
}
