import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jatinchaudhary/sections/section.dart';
import 'utils/app_text_styles.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Warm the core faces so the first frame doesn't flash fallback fonts.
  // Never block startup on it: offline, the fallbacks are fine.
  try {
    await GoogleFonts.pendingFonts([
      AppTextStyles.display(),
      AppTextStyles.display().copyWith(fontStyle: FontStyle.italic),
      AppTextStyles.body(),
      AppTextStyles.body(weight: FontWeight.w500),
      AppTextStyles.mono(),
    ]).timeout(const Duration(seconds: 3));
  } catch (_) {}
  runApp(const PortfolioWebApp());
}

class PortfolioWebApp extends StatelessWidget {
  const PortfolioWebApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jatin Chaudhary',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColors.bg,
        colorScheme: const ColorScheme.dark(
          primary: AppColors.accent,
          surface: AppColors.surface,
        ),
        textSelectionTheme: TextSelectionThemeData(
          selectionColor: AppColors.accent.withValues(alpha: 0.3),
        ),
        useMaterial3: true,
      ),
      home: const Sections(),
      debugShowCheckedModeBanner: false,
    );
  }
}
