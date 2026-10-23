import 'package:flutter/material.dart';
import 'package:jatinchaudhary/utils/app_text_styles.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 60),

      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 800, // 👈 max width
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Experiences", style: AppTextStyles.sectionHeadingStyle),
            SizedBox(height: 70),

            _ExperienceTimelineItem(
              year: "Oct 2024 - Present",
              title: "SDE-II",
              company: "Junglee Games",
              location: "Gurgaon, Haryana",
              highlights: [
                "Architected and shipped the backend for a UK-market raffle platform in 97 days, scaling to 120K+ active users post-launch.",
                "Built the Instant Win engine: deterministic windowed draws and atomic prize-pool allocation, guaranteeing a single winner per prize under concurrent load.",
                "Owned the deposit flow end-to-end, shipping custom UPI and CVV-less payments that lifted transaction success by 30%.",
                "Drove Flutter architecture on Junglee Rummy with modular Clean Architecture, custom plugins, a 30% smaller app, and Shorebird OTA releases on Bitbucket + Fastlane CI/CD.",
                "Built an LLM-based PR review system that flags architecture violations, performance regressions, and convention drift, adopted team-wide.",
              ],
            ),
            _ExperienceTimelineItem(
              year: "Jul 2022 - Oct 2024",
              title: "Senior Software Engineer",
              company: "Hexon Global",
              location: "Morgan Hill, California",
              highlights: [
                "Tech lead for MB Daily, a quick-commerce platform: owned architecture and led 4 engineers, scaling from ~100 to 5K+ users and ~1K orders/day.",
                "Built order management, partial fulfillment, and express delivery as event-driven Spring Boot services on Kafka, cutting order cancellations from 20% to 5%.",
                "Built the inventory service with per-store stock, TTL-backed cart reservations, and atomic decrements that prevent oversell under concurrent checkout.",
                "Shipped the consumer and delivery-agent Flutter apps with live order tracking, background location streaming, and offline-tolerant updates.",
              ],
            ),
            _ExperienceTimelineItem(
              year: "Jan 2021 - Jul 2022",
              title: "Associate IT - Developer",
              company: "Unthinkable Solutions",
              location: "Gurgaon, Haryana",
              highlights: [
                "Developed and deployed 3+ production apps to the App Store and Play Store, owning features from design through release.",
                "Built the voice recognition layer mapping natural speech to app intents, with cross-module deep links.",
                "Developed reusable Flutter plugins and shared components to standardize native integrations across apps.",
              ],
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
  final String location;
  final List<String> highlights;

  const _ExperienceTimelineItem({
    required this.year,
    required this.title,
    required this.company,
    required this.location,
    required this.highlights,
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
          Expanded(
            child: Padding(
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
                    location,
                    style: AppTextStyles.sectionContentStyle.copyWith(
                      fontWeight: FontWeight.w200,
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(height: 16),
                  for (final highlight in highlights)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Text(
                        "•  $highlight",
                        style: AppTextStyles.sectionContentStyle.copyWith(
                          fontWeight: FontWeight.w300,
                          fontSize: 13,
                          height: 1.6,
                        ),
                      ),
                    ),
                ],
              ),
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
