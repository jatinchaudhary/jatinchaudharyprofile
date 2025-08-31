import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jatinchaudhary/utils/app_text_styles.dart';
import 'package:jatinchaudhary/utils/constants.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {

    bool isMobile = MediaQuery.of(context).size.width < 600;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      height: isMobile ? 1000 : 700,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 800, // 👈 max width
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Skills", style: AppTextStyles.sectionHeadingStyle),
            SizedBox(height: 70),

            Row(
              children: [
                flutter(isMobile: isMobile),

                SizedBox(width: 10),

                Column(
                  children: [
                    iOS(isMobile: isMobile),
                    SizedBox(height: 10),
                    react(isMobile: isMobile),
                  ],
                ),


                isMobile ? Container() : SizedBox(width: 10),

                isMobile ? Container() : Column(
                  children: [
                    android(isMobile: isMobile),

                    SizedBox(height: 10),

                    Row(children: [cicd(), SizedBox(width: 10), aws(isMobile: isMobile)]),
                  ],
                ),
              ],
            ),

            SizedBox(height: 10),

            Row(
              children: [
                Column(
                  children: [
                    Row(children: [firebase(isMobile: isMobile), SizedBox(width: 10), dart()]),

                    SizedBox(height: 10),

                    Row(children: [cpp(), SizedBox(width: 10), graphql(isMobile: isMobile)]),
                  ],
                ),

                SizedBox(width: 10),

                isMobile ? aws(isMobile : true) : node(isMobile: isMobile),

                isMobile ? Container() : SizedBox(width: 10),

                isMobile ? Container() : Column(
                  children: [
                    pubdev(isMobile: isMobile),

                    SizedBox(height: 10),

                    Row(children: [rest(isMobile: isMobile), SizedBox(width: 10), llm(isMobile: isMobile)]),
                  ],
                ),
              ],
            ),


            isMobile ? SizedBox(height: 10,) : Container(),


            isMobile? Row(
              children: [
                node(isMobile : true),
                SizedBox(width: 10),

               Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                      // cicd(),
                      //  SizedBox(width: 10),
                       
                          Column(
                     children: [
                    pubdev(isMobile: true),

                    SizedBox(height: 10),

                    Row(children: [rest(), SizedBox(width: 10), llm()]),
                  ],
                )


                       ]),

              ],
            ) : SizedBox.shrink(),


            isMobile ? SizedBox(height: 10,) : Container(),



            isMobile ? Row(
              mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    
                    android(isMobile: true),
            

            
                  ],
                ) : SizedBox.shrink()





          
          ],
        ),
      ),
    );
  }

  Widget flutter({bool isMobile = false}) {
    return SkillBox(
      height: 280,
      width: isMobile ? 270 : 280,
      colors: [
        const Color.fromARGB(32, 9, 53, 174),
        const Color.fromARGB(26, 9, 53, 174),
      ],
      child: Image.asset(Constants.flutterIcon),
    );
  }

  Widget iOS({bool isMobile = false}) {
    return SkillBox(
      height: 190,
      width: isMobile ? 180 : 190,
      horizontalPadding: 30,
      colors: [
        const Color.fromARGB(17, 255, 255, 255),
        const Color.fromARGB(4, 255, 255, 255),
      ],
      child: Image.asset(Constants.iosIcon),
    );
  }

  Widget react({bool isMobile = false}) {
    return SkillBox(
      height: 80,
      width: isMobile ? 180 : 190,
      horizontalPadding: 50,
      verticalPadding: 0,
      colors: [
        const Color.fromARGB(27, 13, 149, 170),
        Color.fromARGB(17, 13, 149, 170),
      ],
      child: Image.asset(Constants.reactIcon),
    );
  }

  Widget android({bool isMobile = false}) {
    return SkillBox(
      height: 90,
      width: isMobile ? 460 : 280,
      start: Alignment.bottomRight,
      end: Alignment.topLeft,
      horizontalPadding: isMobile ? 150 : 40,
      colors: [
        const Color.fromARGB(20, 78, 186, 92),
        Color.fromARGB(13, 78, 186, 92),
      ],
      child: SvgPicture.asset(Constants.androidIcon),
    );
  }

  Widget cicd() {
    return SkillBox(
      height: 180,
      width: 90,
      horizontalPadding: 20,
      colors: [
        const Color.fromARGB(29, 5, 64, 94),
        Color.fromARGB(15, 5, 64, 94),
      ],
      child: Image.asset(Constants.cicdIcon),
    );
  }

  Widget aws({bool isMobile = false}) {
    return SkillBox(
      height: isMobile? 190 : 180,
      width: isMobile ? 180 : 180,
      horizontalPadding: 40,
      colors: [
        const Color.fromARGB(25, 236, 110, 26),
        Color.fromARGB(14, 236, 110, 26),
      ],
      child: Image.asset(Constants.awsIcon),
    );
  }

  Widget firebase({bool isMobile = false}) {
    return SkillBox(
      height: 90,
      width: isMobile ? 170 : 180,
      colors: [
        const Color.fromARGB(23, 219, 162, 49),
        Color.fromARGB(11, 219, 162, 49),
      ],
      child: Image.asset(Constants.firebaseIcon),
    );
  }

  Widget dart() {
    return SkillBox(
      height: 90,
      width: 90,
      horizontalPadding: 20,
      colors: [
        const Color.fromARGB(25, 30, 88, 233),
        Color.fromARGB(13, 30, 88, 233),
      ],
      child: SvgPicture.asset(Constants.dartIcon),
    );
  }

  Widget cpp() {
    return SkillBox(
      height: 90,
      width: 90,
      horizontalPadding: 20,
      colors: [
        const Color.fromARGB(21, 30, 40, 233),
        Color.fromARGB(11, 30, 40, 233),
      ],
      child: SvgPicture.asset(Constants.cppIcon),
    );
  }

  Widget graphql({bool isMobile = false}) {
    return SkillBox(
      height: 90,
      width: isMobile ? 170 : 180,
      horizontalPadding: 25,
      colors: [
        const Color.fromARGB(23, 180, 9, 66),
        Color.fromARGB(10, 180, 9, 66),
      ],
      child: SvgPicture.asset(Constants.graphqlIcon),
    );
  }

  Widget node({bool isMobile = false}) {
    return SkillBox(
      height:  190,
      width: isMobile ? 270 : 290,
      horizontalPadding: 50,
      colors: [
        const Color.fromARGB(22, 74, 230, 46),
        Color.fromARGB(10, 74, 230, 46),
      ],
      child: SvgPicture.asset(Constants.nodeIcon),
    );
  }

  Widget pubdev({bool isMobile = false}) {
    return SkillBox(
      height: 90,
      width: isMobile ? 180 : 180,
      colors: [
        const Color.fromARGB(33, 16, 110, 136),
        Color.fromARGB(16, 16, 110, 136),
      ],
      child: Transform.scale(
        scale: 1.5,
        child: Image.asset(Constants.pubdevIcon),
      ),
    );
  }

  Widget rest({bool isMobile = false}) {
    return SkillBox(
      height: 90,
      width: 85,
      horizontalPadding: 20,
      colors: [
        const Color.fromARGB(26, 21, 21, 71),
        Color.fromARGB(14, 21, 21, 71),
      ],
      child: Image.asset(Constants.restIcon),
    );
  }

  Widget llm({bool isMobile = false}) {
    return SkillBox(
      height: 90,
      width: 85,
      colors: [
        const Color.fromARGB(27, 191, 7, 7),
        Color.fromARGB(15, 191, 7, 7),
      ],
      child: Transform.scale(
        scale: 2.5, // 👈 zoom the image by 20%
        child: Image.asset(Constants.llmIcon),
      ),
    );
  }
}

class SkillBox extends StatefulWidget {
  final double height;
  final double width;
  final List<Color> colors;
  final Widget child;
  final Color borderColor;
  final Alignment start;
  final Alignment end;
  final double horizontalPadding;
  final double verticalPadding;

  const SkillBox({
    super.key,
    required this.height,
    required this.width,
    required this.colors,
    required this.child,
    this.borderColor = const Color.fromARGB(47, 106, 105, 105),
    this.start = Alignment.topLeft,
    this.end = Alignment.bottomRight,
    this.horizontalPadding = 0.0,
    this.verticalPadding = 0.0,
  });

  @override
  State<SkillBox> createState() => _SkillBoxState();
}

class _SkillBoxState extends State<SkillBox> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        enableFeedback: false,
        focusColor: Colors.transparent,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: (){
        },
        child: AnimatedContainer(
          duration: Duration(milliseconds: 1000),
          height: widget.height,
          width: widget.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(begin: widget.start, end: widget.end, colors: widget.colors),
            border: Border.all(color: widget.borderColor, width: 1),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: widget.horizontalPadding,
              vertical: widget.verticalPadding,
            ),
            child: widget.child,
          ),
        ),
      ),
    );
  }
}
