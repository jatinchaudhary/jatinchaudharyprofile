import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Colour tokens: the original black theme with white/grey text. The accent
/// is the site's original blue (0xFF326EA4), lifted slightly so it stays
/// legible as text on black.
class AppColors {
  static const Color bg = Color(0xFF000000);
  static const Color surface = Color(0xFF0C0C0D);
  static const Color surfaceRaised = Color(0xFF161618);

  static const Color border = Color(0x14FFFFFF);
  static const Color borderStrong = Color(0x26FFFFFF);

  static const Color text = Color(0xFFF5F5F5);
  static const Color textMuted = Color(0xFFA8A8A8);
  static const Color textFaint = Color(0xFF6B6B6B);

  static const Color accent = Color(0xFF5B8BB6);
  static const Color live = Color(0xFF6FCF97);

  // Glow colours from the original hero and contact backgrounds.
  static const Color glowBlue = Color(0xFF0C5475);
  static const Color glowTeal = Color(0xFF063931);
  static const Color glowPurple = Color(0xFF352059);
}

/// Layout breakpoints, in logical pixels.
class Breakpoints {
  static const double mobile = 700;
  static const double desktop = 1024;

  static bool isMobile(BuildContext context) =>
      MediaQuery.sizeOf(context).width < mobile;
}

/// Interpolates between [min] and [max] as the viewport grows from a phone
/// to a laptop, so display type scales smoothly instead of jumping.
double fluid(BuildContext context, double min, double max) {
  final width = MediaQuery.sizeOf(context).width;
  final t = ((width - 380) / (1440 - 380)).clamp(0.0, 1.0);
  return min + (max - min) * t;
}

/// Type scale: a serif for display, a neutral sans for reading and a mono for
/// small labels.
class AppTextStyles {
  static TextStyle display({double size = 64, Color color = AppColors.text}) =>
      GoogleFonts.instrumentSerif(
        fontSize: size,
        height: 1.05,
        letterSpacing: -0.01 * size,
        color: color,
      );

  static TextStyle body({
    double size = 16,
    Color color = AppColors.textMuted,
    FontWeight weight = FontWeight.w400,
    double height = 1.7,
  }) => GoogleFonts.inter(
    fontSize: size,
    fontWeight: weight,
    height: height,
    color: color,
  );

  static TextStyle mono({
    double size = 12,
    Color color = AppColors.textFaint,
    double letterSpacing = 1.4,
  }) => GoogleFonts.jetBrainsMono(
    fontSize: size,
    letterSpacing: letterSpacing,
    height: 1.4,
    color: color,
  );
}
