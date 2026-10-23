import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jatinchaudhary/sections/section6_connect/plus_bg.dart';
import 'package:jatinchaudhary/utils/app_text_styles.dart';
import 'package:jatinchaudhary/utils/constants.dart';
import 'package:jatinchaudhary/utils/links.dart';

class ConnectSection extends StatelessWidget {
  const ConnectSection({super.key});

  @override
  Widget build(BuildContext context) {

    bool isMobile = MediaQuery.of(context).size.width < 600;

    return Stack(
      children: [
        PlusBg(),
        Container(width: double.infinity,),
        Align(
          alignment: Alignment.center,

          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            height: 600,
          
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: 800,
              ),
          
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   Text("Contact Me", style: AppTextStyles.sectionHeadingStyle),
                  SizedBox(height: 40,),
                   Text("Let's get in touch", style: AppTextStyles.contactTextStyle),
                   SizedBox(height: 8,),
                  Text("Feel free to contact me. I try to reach back to you soon.", style: AppTextStyles.contactTextStyle),
                  SizedBox(height: 10,),
          
          
                  Row(
                    children: [
          
                      Text(Links.email, style: AppTextStyles.emailContentStyle),
          
                      SizedBox(width: 10,),
          
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: () {
                            Clipboard.setData(ClipboardData(text: Links.email));
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Email copied to clipboard')),
                            );
                          },
                          child: Icon(Icons.copy, size: 16,),
                        ),
                      ),
          
                    ],
                  ),
          
          
                  SizedBox(height: 50,),


                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox( 
                        width: 210,
                        child: ContactBox(title: 'Download Resume', imagePath: Constants.downloadIcon, onTap: () => Links.open(Links.resume),)),
                        isMobile ? SizedBox(width: 10,) : Container(),
                        isMobile ? ContactBox(title: 'My GitHub', imagePath: Constants.githubIcon, onTap: () => Links.open(Links.github),) : SizedBox(width: 0,),
                    ],
                  ),

                  SizedBox(height: 10,),
          
          
                  Row(
                    children: [
          
                      ContactBox(title: 'Email Me', imagePath: Constants.emailIcon, onTap: Links.mail,),
                      isMobile ? Container() : SizedBox(width: 10,),
                      isMobile ? Container() :ContactBox(title: 'My GitHub', imagePath: Constants.githubIcon, onTap: () => Links.open(Links.github),),
                      SizedBox(width: 10,),
                      ContactBox(title: 'My Linkedin', imagePath: Constants.linkedinIcon, onTap: () => Links.open(Links.linkedin),)
          
                    ],
                  ),



                  SizedBox(height: 90,),


                  Container(
                    width: double.infinity,
                    height: 1,
                    color: Colors.white.withOpacity(0.1),
                  ),

                  SizedBox(height: 30,),

                  Text('Designed and Developed with love, ofcourse by myself.', style: AppTextStyles.sectionContentStyle,),
                  SizedBox(height: 5,),
                  Text('Purely build in Flutter!', style: AppTextStyles.sectionContentStyle,)


          
          
                  
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}


class ContactBox extends StatelessWidget {
  final String title;
  final String imagePath;
  final VoidCallback onTap;

  const ContactBox({super.key, required this.title, required this.imagePath, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: _buildBox(),
      ),
    );
  }

  Widget _buildBox() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromARGB(17, 255, 255, 255), width: 1),
        borderRadius: BorderRadius.all(Radius.circular(10)),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color.fromARGB(11, 255, 255, 255),
            const Color.fromARGB(25, 255, 255, 255)]
        )
      ),
      child: Row(
        children: [
          SvgPicture.asset(imagePath, height: 20, width: 20,),
          SizedBox(width: 8,),
          Text(title, style: AppTextStyles.contactTextStyle.copyWith(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}