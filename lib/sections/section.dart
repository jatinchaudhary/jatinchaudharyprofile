import 'package:flutter/material.dart';
import 'package:jatinchaudhary/sections/section1_cover/cover_section.dart';
import 'package:jatinchaudhary/sections/section2_about/about_section.dart';
import 'package:jatinchaudhary/sections/section3_experience/experience_section.dart';
import 'package:jatinchaudhary/sections/section4_skills/skils_section.dart';
import 'package:jatinchaudhary/sections/section5_work/work_section.dart';
import 'package:jatinchaudhary/sections/section6_connect/connect_section.dart';
import 'package:web_smooth_scroll/web_smooth_scroll.dart';

class Sections extends StatefulWidget {
  const Sections({super.key});

  @override
  State<Sections> createState() => _SectionsState();
}

class _SectionsState extends State<Sections> {


  // Controllers
  late ScrollController _scrollController;

  @override
  void initState() {
    // initialize scroll controllers
    _scrollController = ScrollController();

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebSmoothScroll(
        scrollSpeed: 1,
        controller: _scrollController,
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _scrollController,
          child: Column(
            children: [
              
              
              CoverSection(),
             
              AboutSection(),

              ExperienceSection(),

              SkillsSection(),

              WorkSection(),

              ConnectSection()

            ],
          ),
        ),
      ),
    );
  }
}