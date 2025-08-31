import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  static TextStyle headline1 = GoogleFonts.roboto(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  static TextStyle headline2 = GoogleFonts.roboto(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: Colors.black87,
  );

  static TextStyle bodyText = GoogleFonts.roadRage(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: Colors.black54,
  );

  static TextStyle nameStyle = GoogleFonts.montserrat(
    fontSize: 24,
    fontWeight: FontWeight.w500,
    color: Colors.white,
    letterSpacing: 2
  );

    static TextStyle heading2Style = GoogleFonts.montserrat(
    fontSize: 60,
    fontWeight: FontWeight.w500,
    color: Colors.white,
    height: 1.1
  );



static TextStyle narrowHeading2Style = GoogleFonts.montserrat(
    fontSize: 50,
    fontWeight: FontWeight.w400,
    color: Colors.white,
    height: 1.1
  );


  static TextStyle sectionHeadingStyle = GoogleFonts.montserrat(
    fontSize: 30,
    fontWeight: FontWeight.w500,
    color: const Color.fromARGB(255, 245, 245, 245),
    height: 1.1,
    letterSpacing: 1.2
  );


  static TextStyle sectionContentStyle = GoogleFonts.montserrat(
    fontSize: 14,
    fontWeight: FontWeight.w200,
    color: const Color.fromARGB(255, 225, 225, 225),
    height: 1.1,
  );



  static TextStyle workTitleStyle = GoogleFonts.montserrat(
    fontSize: 20,
    fontWeight: FontWeight.w500,
    color: const Color.fromARGB(242, 225, 225, 225),
    height: 1.1,
  );



    static TextStyle emailContentStyle = GoogleFonts.montserrat(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: const Color.fromARGB(255, 225, 225, 225),
    height: 1.1,
    textStyle: TextStyle(
      fontStyle: FontStyle.italic,
    ),
  );





  static TextStyle contactTextStyle = GoogleFonts.montserrat(
    fontSize: 14,
    fontWeight: FontWeight.w300,
    color: const Color.fromARGB(210, 225, 225, 225),
    height: 1.1,
  );



 static TextStyle downloadResumeStyle = GoogleFonts.montserrat(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: const Color.fromARGB(255, 225, 225, 225),
    height: 1.1,
  );



   static TextStyle logoStyle = GoogleFonts.dancingScript(
    fontSize: 24,
    fontWeight: FontWeight.w400,
    color: const Color.fromARGB(210, 255, 255, 255),
    height: 1.1,
  );

}
