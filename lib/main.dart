import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jatinchaudhary/sections/section.dart';
import 'utils/app_text_styles.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GoogleFonts.getFont('Roboto'); 
  runApp(const PortfolioWebApp());
}

class PortfolioWebApp extends StatelessWidget {
  const PortfolioWebApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jatin Chaudhary Portfolio',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
        textTheme: TextTheme(
          headlineLarge: AppTextStyles.headline1.copyWith(color: Colors.white),
          headlineMedium: AppTextStyles.headline2.copyWith(color: Colors.white70),
          bodyMedium: AppTextStyles.heading2Style.copyWith(color: Colors.white60),
        ),
        useMaterial3: true,
      ),
      home: const Sections(),
      debugShowCheckedModeBanner: false,
    );
  }
}




