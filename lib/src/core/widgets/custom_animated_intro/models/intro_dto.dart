part of '../imports/intro_imports.dart';

/// Phone-screen bitmap composited on the hand mockup (Figma export), insets as fractions of layout.
class IntroPhoneOverlay {
  const IntroPhoneOverlay({
    required this.imagePath,
    required this.insetTop,
    required this.insetEnd,
    required this.insetBottom,
    required this.insetStart,
    this.designFrameWidth = 430,
    this.borderRadiusDesignPx = 29,
  });

  final String imagePath;
  /// Fraction of layout height.
  final double insetTop;
  /// Fraction of layout width (physical end / “right” in Figma frame).
  final double insetEnd;
  /// Fraction of layout height.
  final double insetBottom;
  /// Fraction of layout width (physical start / “left” in Figma frame).
  final double insetStart;
  final double designFrameWidth;
  final double borderRadiusDesignPx;
}

class IntroDto {
  final String title;
  final String subtitle;

  final String backGroundImagePath;
  final String? pointerImagePath;
  final IntroPhoneOverlay? phoneOverlay;

  const IntroDto({
    required this.title,
    required this.subtitle,
    required this.backGroundImagePath,
    required this.pointerImagePath,
    this.phoneOverlay,
  });
}
