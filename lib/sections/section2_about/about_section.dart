import 'package:flutter/material.dart';
import 'package:jatinchaudhary/utils/app_text_styles.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      constraints: BoxConstraints(minHeight: 600),

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
            child: Text("I am a software engineer with 5+ years of experience building production systems in real-money gaming, quick-commerce, and consumer AI. Currently SDE-II at Junglee Games, I architected the backend for a UK raffle platform that reached 120K+ users within 97 days, and I own the deposit stack on Junglee Rummy, where custom UPI and CVV-less payments lifted transaction success by 30%. Previously, as tech lead at Hexon Global, I led four engineers building event-driven Spring Boot and Kafka services for a quick-commerce platform. I have also built two AI products end-to-end, covering multi-agent LLM orchestration and real-time player profiling.",
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
              footer("5+", "Years of Experience"),
              footer("120K+", "Users Scaled"),
              footer("30%", "Payment Lift"),
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