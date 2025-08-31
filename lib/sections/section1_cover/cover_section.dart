import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jatinchaudhary/sections/section1_cover/widgets/first_page_bg.dart';
import 'package:jatinchaudhary/utils/app_text_styles.dart';
import 'package:jatinchaudhary/sections/section1_cover/widgets/dashed_border_box.dart';
import 'package:jatinchaudhary/utils/constants.dart';

class CoverSection extends StatelessWidget {
  const CoverSection({super.key});

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 600;
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          // Blurred circles background
          const FirstSectionBg(),

          // Name and design and develop heading
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment:
                  isMobile
                      ? CrossAxisAlignment.start
                      : CrossAxisAlignment.center,
              children: [
                AnimatedProfile(),

                SizedBox(height: isMobile ? 70 : 130),

                BuildHeading(),
              ],
            ),
          ),

          Visibility(
            visible: !isMobile,
            child: Positioned(
              top: 55,
              right: 70,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color.fromARGB(17, 255, 255, 255),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      const Color.fromARGB(11, 255, 255, 255),
                      const Color.fromARGB(25, 255, 255, 255),
                    ],
                  ),
                ),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      Constants.downloadIcon,
                      height: 13,
                      width: 13,
                      color: const Color.fromARGB(98, 255, 255, 255),
                    ),
                    SizedBox(width: 8),
                    Text(
                      "Download Resume",
                      style: AppTextStyles.downloadResumeStyle.copyWith(
                        color: Color.fromARGB(97, 255, 255, 255),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          Positioned(
            top: isMobile ? 30 : 50,
            left: isMobile ? (MediaQuery.of(context).size.width / 2 - 70) : 70,
            child: Text(
              'JatinChaudhary.com',
              style: AppTextStyles.logoStyle.copyWith(fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}

class BuildHeading extends StatelessWidget {
  const BuildHeading({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isNarrow = screenWidth < 600;

    return Column(
      crossAxisAlignment:
          isNarrow ? CrossAxisAlignment.start : CrossAxisAlignment.center,
      children: [
        isNarrow
            ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                iDesignSection(true),
                andSection(true),
                Row(children: [developSection(true), Esection()]),
              ],
            )
            : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                iDesignSection(false),
                andSection(false),
                developSection(false),
                Esection(),
              ],
            ),
        mobileAppSection(
          isNarrow ? "mobile apps." : "mobile applications.",
          isNarrow,
        ),
      ],
    );
  }

  Widget iDesignSection(bool isNarrow) {
    return DashedBorderBox(
      child: Container(
        padding: EdgeInsets.only(
          top: 0,
          bottom: 10,
          left: isNarrow ? 0 : 20,
          right: 10,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.transparent,
              Color.fromARGB(248, 12, 40, 69).withAlpha(150),
              Color.fromARGB(248, 12, 40, 69).withAlpha(150),
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: Text(
          "I design",
          style:
              isNarrow
                  ? AppTextStyles.narrowHeading2Style
                  : AppTextStyles.heading2Style,
        ),
      ),
    );
  }

  Widget andSection(bool isNarrow) {
    return Text(
      isNarrow ? 'and' : ' and',
      style:
          isNarrow
              ? AppTextStyles.narrowHeading2Style
              : AppTextStyles.heading2Style,
    );
  }

  Widget developSection(bool isNarrow) {
    return Container(
      padding: EdgeInsets.only(top: 6, bottom: 10, left: 0, right: 5),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.transparent,
            Color.fromARGB(255, 6, 57, 49).withAlpha(60),
            Color.fromARGB(255, 6, 57, 49).withAlpha(60),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Text(
        isNarrow ? "develop" : " develop",
        style:
            isNarrow
                ? AppTextStyles.narrowHeading2Style
                : AppTextStyles.heading2Style,
      ),
    );
  }

  Widget mobileAppSection(String text, bool isNarrow) {
    return Container(
      padding: EdgeInsets.only(top: isNarrow ? 10 : 20, bottom: 0),
      child: Stack(
        children: [
          // Stroke text
          Text(
            text,
            style:
                isNarrow
                    ? AppTextStyles.narrowHeading2Style.copyWith(
                      foreground:
                          Paint()
                            ..style = PaintingStyle.stroke
                            ..strokeWidth = 2.5
                            ..color = const Color.fromARGB(255, 164, 162, 162),
                    )
                    : AppTextStyles.heading2Style.copyWith(
                      foreground:
                          Paint()
                            ..style = PaintingStyle.stroke
                            ..strokeWidth = 2.5
                            ..color = const Color.fromARGB(255, 164, 162, 162),
                    ),
          ),
          // Gradient fill text
          ShaderMask(
            shaderCallback: (Rect bounds) {
              return LinearGradient(
                colors: [
                  Colors.black,
                  const Color.fromARGB(255, 223, 221, 221),
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ).createShader(bounds);
            },
            blendMode: BlendMode.srcIn,
            child: Text(
              text,
              style:
                  isNarrow
                      ? AppTextStyles.narrowHeading2Style
                      : AppTextStyles.heading2Style,
            ),
          ),
        ],
      ),
    );
  }
}

class Esection extends StatefulWidget {
  const Esection({super.key});

  @override
  State<Esection> createState() => _EsectionState();
}

class _EsectionState extends State<Esection> {
  bool _blink = true;

  @override
  void initState() {
    super.initState();
    _startBlinking();
  }

  void _startBlinking() {
    Future.doWhile(() async {
      await Future.delayed(const Duration(milliseconds: 700));
      if (!mounted) return false;
      setState(() {
        _blink = !_blink;
      });
      return true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.only(top: 6, bottom: 0),
      decoration: BoxDecoration(
        color:
            _blink
                ? Color.fromARGB(255, 6, 57, 49).withAlpha(200)
                : Color.fromARGB(255, 6, 57, 49).withAlpha(60),
        border: Border(
          bottom: BorderSide(
            color: _blink ? Colors.grey : Colors.transparent,
            width: 10,
          ),
        ),
      ),
      child: Text(
        'e',
        style: AppTextStyles.heading2Style.copyWith(height: 1.1),
      ),
    );
  }
}

class AnimatedProfile extends StatefulWidget {
  const AnimatedProfile({super.key});

  @override
  State<AnimatedProfile> createState() => _AnimatedProfileState();
}

class _AnimatedProfileState extends State<AnimatedProfile> {
  int height = 60;
  int width = 60;

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 600;
    return isMobile
        ? Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipOval(
              child: Container(
                height: height.toDouble(),
                width: width.toDouble(),
                child: Transform.scale(
                  alignment: Alignment(0, -0.2),
                  scale: 2, // Increase for more zoom
                  child: Image.asset(
                    Constants.profileIcon,
                    height: 60,
                    width: 60,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Hello. I'm Jatin.",
              style: AppTextStyles.nameStyle,
              textAlign: TextAlign.center,
            ),
          ],
        )
        : Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipOval(
              child: Container(
                height: height.toDouble(),
                width: width.toDouble(),
                child: Transform.scale(
                  alignment: Alignment(0, -0.2),
                  scale: 2, // Increase for more zoom
                  child: Image.asset(
                    Constants.profileIcon,
                    height: 40,
                    width: 40,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(width: 20),
            Text(
              "Hello. I'm Jatin.",
              style: AppTextStyles.nameStyle,
              textAlign: TextAlign.center,
            ),
          ],
        );
  }
}
