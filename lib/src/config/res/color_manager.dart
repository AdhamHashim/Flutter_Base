part of 'config_imports.dart';

/// Design tokens from `assets/design_tokens/mode_1_theme_tokens.json` (Figma Mode 1).
class AppColors {
  /// "Font" — headings / strong body
  static const Color main = Color(0xFF1C1C1C);

  /// "Shade 2" — body text
  static const Color primary = Color(0xFF474747);

  /// "Shade 1"
  static const Color secondary = Color(0xFF292929);
  static const Color third = Color(0xFF1F2A37);

  /// "Primary" — brand orange (CTA, links, accents)
  static const Color forth = Color(0xFFFF741F);

  /// "Shade 3"
  static const Color hintText = Color(0xFF666666);

  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF);
  static const Color buttonColor = Color(0xFFFF741F);

  /// "Shade 7" — text on primary / chips
  static const Color buttonText = Color(0xFFF7F7F8);

  /// "BG"
  static const Color scaffoldBackground = Color(0xFFFBFBFB);

  /// "Border"
  static const Color border = Color(0xFFEBEBEB);
  static const Color activeBorder = Color(0xFFFF741F);

  /// "Danger"
  static const Color error = Color(0xFFEC2D30);

  /// "Shade 6"
  static const Color grey1 = Color(0xFFEEEEEE);

  /// "Shade 5"
  static const Color grey2 = Color(0xFFCCCCCC);

  /// Same as Figma "Primary" (#FF741F)
  static const Color brandPrimary = Color(0xFFFF741F);

  /// Light peach for info/notice boxes
  static const Color infoBoxLight = Color(0xFFFFF7ED);

  /// "Success"
  static const Color success = Color(0xFF0C9D61);

  /// "Warning"
  static const Color warning = Color(0xFFFE9B0E);

  /// "Info"
  static const Color info = Color(0xFF3A70E2);

  /// "unactive nav"
  static const Color navInactive = Color(0xFFB4AFDF);

  /// "Dashboard BG"
  static const Color dashboardBackground = Color(0xFFF7F8FA);

  /// "card fill"
  static const Color cardFill = Color(0xFFFFFFFF);

  /// "selected btn"
  static const Color selectedButton = Color(0xFFF7F7F8);

  static const LinearGradient gradient = LinearGradient(
    colors: [Color(0xFFFF741F), Color(0xFFFF9B0E)],
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
  );
  static const LinearGradient disableGradient = LinearGradient(
    colors: [grey1, grey2],
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
  );

  static BoxShadow containerShadow = BoxShadow(
    color: const Color(0xFFF0F0F0).withValues(alpha: 1.0),
    offset: const Offset(0, 0),
    blurRadius: 4.0,
    spreadRadius: 0.0,
  );
}

extension ColorExtension on Color {
  bool get isDark => computeLuminance() < 0.5;
}

class AppColorsWithDarkMode {
  static const Color main = Color(0xFF1C1C1C);
  static const Color primary = Color(0xFF474747);
  static const Color secondary = Color(0xFF292929);
  static const Color third = Color(0xFF1F2A37);
  static const Color forth = Color(0xFFFF741F);
  static const Color hintText = Color(0xFF666666);

  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF);
  static const Color buttonColor = Color(0xFFFF741F);
  static const Color buttonText = Color(0xFFF7F7F8);

  static const Color scaffoldBackground = Color(0xFFFBFBFB);
  static const Color border = Color(0xFFEBEBEB);
  static const Color activeBorder = Color(0xFFFF741F);
  static const Color error = Color(0xFFEC2D30);

  static const Color grey1 = Color(0xFFEEEEEE);
  static const Color grey2 = Color(0xFFCCCCCC);

  static const LinearGradient gradient = LinearGradient(
    colors: [Color(0xFFFF741F), Color(0xFFFF9B0E)],
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
  );
  static const LinearGradient disableGradient = LinearGradient(
    colors: [grey1, grey2],
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
  );

  static BoxShadow containerShadow = BoxShadow(
    color: const Color(0xFFF0F0F0).withValues(alpha: 1.0),
    offset: const Offset(0, 0),
    blurRadius: 4.0,
    spreadRadius: 0.0,
  );
}
