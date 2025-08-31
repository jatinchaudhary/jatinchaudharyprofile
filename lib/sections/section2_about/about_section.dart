import 'package:flutter/material.dart';
import 'package:jatinchaudhary/utils/app_text_styles.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      height: 600,

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("About Me",style: AppTextStyles.sectionHeadingStyle,),
          SizedBox(height: 20),
          ConstrainedBox(
            constraints: BoxConstraints(
               maxWidth: 800, // 👈 max width
             ),
            child: Text("I am a Flutter engineer with 4 years of hands-on experience in building high-performance,scalable, and user-friendly applications for mobile, web, and desktop. Skilled in Dart, Flutter, Firebase, REST APIs, state management (Provider, Riverpod, BLoC), and modern app architecture, I enjoy turning complex ideas into smooth digital experiences. I’ve worked across the full app lifecycle—from ideation and UI/UX design to deployment and post-release optimization—delivering apps that are reliable, efficient, and visually engaging.",
             style: AppTextStyles.sectionContentStyle.copyWith(height: 2),),
          ),

          SizedBox(height: 20),

          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: 500, // 👈 max width
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
              footer("4.5+", "Years of Experience"),
              footer("15+", "Applications"),
              footer("7+", "Happy Clients"),
            ],),
          )




        ],
      ),


    );
  }



  Widget footer (String count, String label) {
    return Column(
      children: [
          Text(count,style: AppTextStyles.sectionHeadingStyle.copyWith(fontSize: 30,),),
          SizedBox(height: 5),
          Text(label,style: AppTextStyles.sectionContentStyle,),],
    );
  }
}