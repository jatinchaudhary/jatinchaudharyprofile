import 'package:flutter/material.dart';
import 'package:jatinchaudhary/utils/app_text_styles.dart';
import 'package:jatinchaudhary/widgets/common.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  static const _roles = [
    _Role(
      period: "Oct 2024 — Present",
      title: "SDE-II",
      company: "Junglee Games",
      location: "Gurgaon, Haryana",
      current: true,
      highlights: [
        "Architected and shipped the backend for a UK-market raffle platform in 97 days, scaling to 120K+ active users post-launch.",
        "Built the Instant Win engine: deterministic windowed draws and atomic prize-pool allocation, guaranteeing a single winner per prize under concurrent load.",
        "Owned the deposit flow end-to-end, shipping custom UPI and CVV-less payments that lifted transaction success by 30%.",
        "Drove Flutter architecture on Junglee Rummy with modular Clean Architecture, custom plugins, a 30% smaller app, and Shorebird OTA releases on Bitbucket + Fastlane CI/CD.",
        "Built an LLM-based PR review system that flags architecture violations, performance regressions, and convention drift, adopted team-wide.",
      ],
    ),
    _Role(
      period: "Jul 2022 — Oct 2024",
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
    _Role(
      period: "Jan 2021 — Jul 2022",
      title: "Associate IT - Developer",
      company: "Unthinkable Solutions",
      location: "Gurgaon, Haryana",
      highlights: [
        "Developed and deployed 3+ production apps to the App Store and Play Store, owning features from design through release.",
        "Built the voice recognition layer mapping natural speech to app intents, with cross-module deep links.",
        "Developed reusable Flutter plugins and shared components to standardize native integrations across apps.",
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SectionShell(
      number: '02',
      label: 'Experience',
      title: 'Where I have been *building.*',
      child: Container(
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: AppColors.border)),
        ),
        child: Column(
          children: [
            for (final role in _roles) Reveal(child: _RoleItem(role: role)),
          ],
        ),
      ),
    );
  }
}

class _Role {
  final String period;
  final String title;
  final String company;
  final String location;
  final List<String> highlights;
  final bool current;

  const _Role({
    required this.period,
    required this.title,
    required this.company,
    required this.location,
    required this.highlights,
    this.current = false,
  });
}

class _RoleItem extends StatelessWidget {
  const _RoleItem({required this.role});

  final _Role role;

  @override
  Widget build(BuildContext context) {
    return HoverBuilder(
      builder: (context, hovered) {
        final mobile = Breakpoints.isMobile(context);

        final meta = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              role.period.toUpperCase(),
              style: AppTextStyles.mono(color: AppColors.textMuted),
            ),
            const SizedBox(height: 8),
            Text(role.location, style: AppTextStyles.body(size: 14)),
            if (role.current) ...[
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(
                    color: AppColors.accent.withValues(alpha: 0.35),
                  ),
                  color: AppColors.accent.withValues(alpha: 0.06),
                ),
                child: Text(
                  'CURRENT',
                  style: AppTextStyles.mono(
                    size: 10,
                    color: AppColors.accent,
                    letterSpacing: 1.8,
                  ),
                ),
              ),
            ],
          ],
        );

        final details = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 250),
              style: AppTextStyles.display(
                size: fluid(context, 32, 42),
                color: hovered ? AppColors.accent : AppColors.text,
              ),
              child: Text(role.company),
            ),
            const SizedBox(height: 6),
            Text(
              role.title,
              style: AppTextStyles.body(
                size: 15,
                color: AppColors.text,
                weight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 24),
            for (final highlight in role.highlights)
              Padding(
                padding: const EdgeInsets.only(bottom: 14),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 13),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        width: hovered ? 18 : 12,
                        height: 1,
                        color: AppColors.accent.withValues(alpha: 0.7),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        highlight,
                        style: AppTextStyles.body(size: 15.5, height: 1.75),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        );

        return Container(
          padding: EdgeInsets.symmetric(vertical: mobile ? 36 : 48),
          decoration: const BoxDecoration(
            border: Border(top: BorderSide(color: AppColors.border)),
          ),
          child:
              mobile
                  ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [meta, const SizedBox(height: 24), details],
                  )
                  : Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(width: 280, child: meta),
                      Expanded(child: details),
                    ],
                  ),
        );
      },
    );
  }
}
