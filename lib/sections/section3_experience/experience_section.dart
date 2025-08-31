import 'package:flutter/material.dart';
import 'package:jatinchaudhary/utils/app_text_styles.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      height: 600,

      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 800, // 👈 max width
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Experiences", style: AppTextStyles.sectionHeadingStyle),
            SizedBox(height: 70),

            // Add your experience content here
            Expanded(
              child: ListView(
                physics: NeverScrollableScrollPhysics(),
                children: [
                  _ExperienceTimelineItem(
                    year: "2024 - present",
                    title: "SDE 2",
                    company: "Junglee Games",
                    description: "Full Time",
                  ),
                  _ExperienceTimelineItem(
                    year: "2022 - 2024",
                    title: "Full Stack Mobile Developer",
                    company: "Hexon Global",
                    description:
                        "Full Time",
                  ),
                  _ExperienceTimelineItem(
                    year: "2021 - 2022",
                    title: "Flutter Developer",
                    company: "Unthinkable Solutions LLP",
                    description:
                        "Full Time",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Timeline item widget
class _ExperienceTimelineItem extends StatelessWidget {
  final String year;
  final String title;
  final String company;
  final String description;

  const _ExperienceTimelineItem({
    required this.year,
    required this.title,
    required this.company,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Timeline indicator
          Column(
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 121, 121, 122),
                  borderRadius: BorderRadius.circular(3),
                ),
                child: SizedBox.shrink(),
              ),
              Flexible(
                child: GradientDashedLineVertical(
                  colors: [
                    Color.fromARGB(138, 121, 121, 122),
                    Color.fromARGB(109, 121, 121, 122),
                    Color.fromARGB(69, 121, 121, 122),
                  ],
                  dashHeight: 6,
                  dashSpace: 4,
                  strokeWidth: 1,
                ),
              ),
            ],
          ),
          SizedBox(width: 16),
          // Experience details
          Padding(
            padding: const EdgeInsets.only(left: 16.0, bottom: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  company,
                  style: AppTextStyles.sectionContentStyle.copyWith(
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 18),
                Text(
                  "$title || $year",
                  style: AppTextStyles.sectionContentStyle.copyWith(
                    fontWeight: FontWeight.w300,
                    fontSize: 12,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  description,
                  style: AppTextStyles.sectionContentStyle.copyWith(
                    fontWeight: FontWeight.w200,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class GradientDashedLineVertical extends StatelessWidget {
  final List<Color> colors;
  final double dashHeight;
  final double dashSpace;
  final double strokeWidth;

  const GradientDashedLineVertical({
    Key? key,
    required this.colors,
    this.dashHeight = 6,
    this.dashSpace = 4,
    this.strokeWidth = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(strokeWidth, double.infinity),
      painter: _GradientDashedLinePainter(
        colors: colors,
        dashHeight: dashHeight,
        dashSpace: dashSpace,
        strokeWidth: strokeWidth,
      ),
    );
  }
}

class _GradientDashedLinePainter extends CustomPainter {
  final List<Color> colors;
  final double dashHeight;
  final double dashSpace;
  final double strokeWidth;

  _GradientDashedLinePainter({
    required this.colors,
    required this.dashHeight,
    required this.dashSpace,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, strokeWidth, size.height);

    final paint =
        Paint()
          ..strokeWidth = strokeWidth
          ..shader = LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: colors,
          ).createShader(rect);

    double startY = 0;
    while (startY < size.height) {
      final endY = (startY + dashHeight).clamp(0, size.height);
      canvas.drawLine(
        Offset(size.width / 2, startY),
        Offset(size.width / 2, endY.toDouble()),
        paint,
      );
      startY += dashHeight + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
