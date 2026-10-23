import 'dart:math';

import 'package:flutter/material.dart';
import 'package:jatinchaudhary/utils/app_text_styles.dart';
import 'package:jatinchaudhary/utils/constants.dart';
import 'package:jatinchaudhary/utils/links.dart';
import 'package:jatinchaudhary/widgets/common.dart';

class WorkSection extends StatelessWidget {
  const WorkSection({super.key});

  static const _featured = [
    _Project(
      title: "LocusPlay",
      category: "AI Product",
      description:
          "Game-agnostic AI player profiling that powers matchmaking, "
          "adaptive difficulty and wellbeing detection, with zero inference "
          "on the request path.",
      tags: ["LLM", "Vector KNN", "Prompt Caching"],
      tint: Color(0xFF2E56A0),
      metric: "~40×",
      metricLabel: "lower model spend, with 1–7 ms real-time reads",
      url: Links.locusPlay,
    ),
    _Project(
      title: "Junglee Rummy",
      category: "Real-money gaming · Mobile",
      description:
          "Real-money rummy platform where I own the deposit stack end-to-end "
          "and drive the Flutter architecture: modular Clean Architecture, "
          "custom plugins, a 30% smaller app and Shorebird OTA releases.",
      tags: ["Flutter", "UPI Payments", "Shorebird"],
      tint: Color(0xFF77483F),
      image: Constants.jungleeRummy,
      metric: "30%",
      metricLabel:
          "lift in transaction success with custom UPI & CVV-less payments",
    ),
    _Project(
      title: "AstroRegal",
      category: "AI Product",
      description:
          "AI astro-psychology companion with a dual-agent orchestrator "
          "running on a KP/Vedic chart engine built from scratch.",
      tags: ["Multi-agent", "Redis", "Swiss Ephemeris"],
      tint: Color(0xFF623E96),
      metric: "~10×",
      metricLabel:
          "lower projected inference spend via intent-based model routing",
      url: Links.astroRegal,
    ),
    _Project(
      title: "MB Daily",
      category: "Quick-commerce · Tech lead",
      description:
          "Quick-commerce platform where I led a team of four: event-driven "
          "Spring Boot services on Kafka for orders, partial fulfillment and "
          "express delivery, plus the consumer and delivery-agent Flutter apps.",
      tags: ["Spring Boot", "Kafka", "Flutter"],
      tint: Color(0xFFA88345),
      image: Constants.mbDaily,
      metric: "20% → 5%",
      metricLabel:
          "order cancellations, serving 5K+ users and ~1K orders a day",
    ),
    _Project(
      title: "UK Raffle Platform",
      category: "Backend · System design",
      description:
          "Backend for a UK-market raffle platform, including an Instant Win "
          "engine with deterministic windowed draws and atomic prize-pool "
          "allocation: one winner per prize, even under concurrent load.",
      tags: ["Backend", "Concurrency", "System Design"],
      tint: Color(0xFF187868),
      metric: "120K+",
      metricLabel: "active users, shipped in 97 days",
    ),
  ];

  static const _archive = [
    _Project(
      title: "LLM PR Reviewer",
      category: "Dev tooling",
      description:
          "Automated diff review that flags architecture violations, "
          "performance regressions and convention drift. Adopted team-wide "
          "at Junglee Games.",
      tags: ["LLM", "Code Review"],
      tint: Color(0xFF963C3C),
    ),
    _Project(
      title: "GPS Orbit",
      category: "Mobile",
      description:
          "Real-time vehicle tracking app with live location, ignition and "
          "trip telemetry for whole fleets.",
      tags: ["Flutter", "iOS", "Android"],
      tint: Color(0xFF84B4AD),
      image: Constants.gpsOrbit,
    ),
    _Project(
      title: "NorthLadder",
      category: "Mobile",
      description:
          "Marketplace app for buying and selling pre-owned goods in the UAE.",
      tags: ["Flutter", "iOS", "Android"],
      tint: Color(0xFF8779A0),
      image: Constants.northLadder,
    ),
    _Project(
      title: "Feature Tooltip",
      category: "Open source",
      description:
          "A highly configurable Flutter tooltip with custom positioning, "
          "animations and backdrop blur, published on pub.dev.",
      tags: ["Flutter", "Dart", "pub.dev"],
      tint: Color(0xFF0259A1),
      image: Constants.featureToolTip,
      landscape: true,
      url: Links.featureTooltip,
      urlLabel: "View on pub.dev",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final mobile = Breakpoints.isMobile(context);
    return SectionShell(
      number: '04',
      label: 'Work',
      title: 'Selected *work.*',
      intro:
          'AI products, high-scale backends and mobile apps I have designed, '
          'built or led.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (int i = 0; i < _featured.length; i++) ...[
            Reveal(
              child: _FeaturedCard(
                project: _featured[i],
                index: i + 1,
                flip: i.isOdd,
              ),
            ),
            SizedBox(height: mobile ? 20 : 28),
          ],
          SizedBox(height: mobile ? 72 : 104),
          Reveal(
            child: Row(
              children: [
                Text(
                  'MORE PROJECTS',
                  style: AppTextStyles.mono(
                    color: AppColors.textMuted,
                    letterSpacing: 2.4,
                  ),
                ),
                const Spacer(),
                Text(
                  '${_archive.length.toString().padLeft(2, '0')} ENTRIES',
                  style: AppTextStyles.mono(letterSpacing: 2.4),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Container(
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: AppColors.borderStrong)),
            ),
            child: Column(
              children: [
                for (int i = 0; i < _archive.length; i++)
                  Reveal(
                    delay: Duration(milliseconds: 60 * i),
                    child: _ArchiveRow(
                      project: _archive[i],
                      index: _featured.length + i + 1,
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

class _Project {
  final String title;
  final String category;
  final String description;
  final List<String> tags;

  /// Signature colour used for the project's visual.
  final Color tint;

  /// Screenshot asset. Portrait images are shown in a phone frame.
  final String? image;
  final bool landscape;

  final String? metric;
  final String? metricLabel;

  final String? url;
  final String urlLabel;

  const _Project({
    required this.title,
    required this.category,
    required this.description,
    required this.tags,
    required this.tint,
    this.image,
    this.landscape = false,
    this.metric,
    this.metricLabel,
    this.url,
    this.urlLabel = "Visit live site",
  });

  /// What clicking the project does: open its link, else preview its
  /// screenshot, else nothing.
  VoidCallback? action(BuildContext context) {
    if (url != null) return () => Links.open(url!);
    if (image != null) return () => _showPreview(context, this);
    return null;
  }

  String? get actionLabel =>
      url != null ? urlLabel : (image != null ? "View screenshot" : null);

  IconData get actionIcon => url != null ? Icons.north_east : Icons.add;
}

String _pad(int n) => n.toString().padLeft(2, '0');

/// Large case-study card: copy on one side, a visual on the other. Cards with
/// a screenshot show it in a phone; the rest show their headline metric over
/// an orbit motif.
class _FeaturedCard extends StatelessWidget {
  const _FeaturedCard({
    required this.project,
    required this.index,
    required this.flip,
  });

  final _Project project;
  final int index;
  final bool flip;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final wide = constraints.maxWidth >= 860;
        return HoverBuilder(
          onTap: project.action(context),
          builder: (context, hovered) {
            final hasPhone = project.image != null;
            final visual = Padding(
              padding: const EdgeInsets.all(10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child:
                    hasPhone
                        ? _PhoneVisual(project: project, hovered: hovered)
                        : _MetricVisual(project: project, hovered: hovered),
              ),
            );
            final content = _FeaturedContent(
              project: project,
              index: index,
              hovered: hovered,
              showMetric: hasPhone,
              wide: wide,
            );

            final Widget body;
            if (wide) {
              // The visual sits in a Stack of positioned children so it adds
              // nothing to the row's intrinsic height: the copy decides it.
              final visualBox = Expanded(
                flex: 6,
                child: Stack(children: [Positioned.fill(child: visual)]),
              );
              final contentBox = Expanded(flex: 5, child: content);
              body = ConstrainedBox(
                constraints: const BoxConstraints(minHeight: 540),
                child: IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children:
                        flip
                            ? [visualBox, contentBox]
                            : [contentBox, visualBox],
                  ),
                ),
              );
            } else {
              body = Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [SizedBox(height: 380, child: visual), content],
              );
            }

            return AnimatedContainer(
              duration: const Duration(milliseconds: 350),
              curve: Curves.easeOut,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(28),
                border: Border.all(
                  color:
                      hovered
                          ? Color.lerp(
                            project.tint,
                            Colors.white,
                            0.4,
                          )!.withValues(alpha: 0.4)
                          : AppColors.border,
                ),
              ),
              child: body,
            );
          },
        );
      },
    );
  }
}

class _FeaturedContent extends StatelessWidget {
  const _FeaturedContent({
    required this.project,
    required this.index,
    required this.hovered,
    required this.showMetric,
    required this.wide,
  });

  final _Project project;
  final int index;
  final bool hovered;
  final bool showMetric;
  final bool wide;

  @override
  Widget build(BuildContext context) {
    final actionLabel = project.actionLabel;
    return Padding(
      padding: EdgeInsets.all(wide ? 48 : 26),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                _pad(index),
                style: AppTextStyles.mono(color: AppColors.accent),
              ),
              const SizedBox(width: 12),
              Container(width: 24, height: 1, color: AppColors.borderStrong),
              const SizedBox(width: 12),
              Flexible(
                child: Text(
                  project.category.toUpperCase(),
                  style: AppTextStyles.mono(
                    color: AppColors.textMuted,
                    letterSpacing: 1.8,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 28),
          Text(
            project.title,
            style: AppTextStyles.display(size: fluid(context, 40, 56)),
          ),
          const SizedBox(height: 16),
          Text(project.description, style: AppTextStyles.body(size: 16)),
          const SizedBox(height: 32),
          if (wide) const Spacer(),
          if (showMetric && project.metric != null) ...[
            _MetricLine(metric: project.metric!, label: project.metricLabel),
            const SizedBox(height: 28),
          ],
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [for (final tag in project.tags) TagChip(tag)],
          ),
          if (actionLabel != null) ...[
            const SizedBox(height: 28),
            _ArrowLink(
              label: actionLabel,
              icon: project.actionIcon,
              hovered: hovered,
            ),
          ],
        ],
      ),
    );
  }
}

class _MetricLine extends StatelessWidget {
  const _MetricLine({required this.metric, this.label});

  final String metric;
  final String? label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.border)),
      ),
      child: Row(
        children: [
          Text(
            metric,
            style: AppTextStyles.display(size: 48, color: AppColors.accent),
          ),
          if (label != null) ...[
            const SizedBox(width: 20),
            Expanded(
              child: Text(
                label!,
                style: AppTextStyles.body(size: 14, height: 1.5),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _ArrowLink extends StatelessWidget {
  const _ArrowLink({
    required this.label,
    required this.icon,
    required this.hovered,
  });

  final String label;
  final IconData icon;
  final bool hovered;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 250),
          style: AppTextStyles.body(
            size: 14,
            weight: FontWeight.w500,
            height: 1.2,
            color: hovered ? AppColors.accent : AppColors.text,
          ),
          child: Text(label),
        ),
        const SizedBox(width: 8),
        AnimatedSlide(
          duration: const Duration(milliseconds: 250),
          offset: hovered ? const Offset(0.2, -0.2) : Offset.zero,
          child: Icon(
            icon,
            size: 16,
            color: hovered ? AppColors.accent : AppColors.text,
          ),
        ),
      ],
    );
  }
}

/// Tinted panel with the project's screenshot in a phone that rises on hover.
class _PhoneVisual extends StatelessWidget {
  const _PhoneVisual({required this.project, required this.hovered});

  final _Project project;
  final bool hovered;

  @override
  Widget build(BuildContext context) {
    final tint = project.tint;
    return LayoutBuilder(
      builder: (context, constraints) {
        final phoneWidth = (constraints.maxWidth * 0.46).clamp(170.0, 260.0);
        return Stack(
          children: [
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color.alphaBlend(
                        tint.withValues(alpha: 0.55),
                        AppColors.surface,
                      ),
                      Color.alphaBlend(
                        tint.withValues(alpha: 0.12),
                        AppColors.surface,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned.fill(
              child: CustomPaint(
                painter: _OrbitPainter(
                  tint: tint,
                  t: 0,
                  center: const Alignment(0, -0.35),
                ),
              ),
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 600),
              curve: Curves.easeOutCubic,
              top: hovered ? 32 : 56,
              left: (constraints.maxWidth - phoneWidth) / 2,
              width: phoneWidth,
              child: _PhoneFrame(image: project.image!, width: phoneWidth),
            ),
          ],
        );
      },
    );
  }
}

/// Tinted panel with the project's headline metric over a slowly turning
/// orbit motif.
class _MetricVisual extends StatelessWidget {
  const _MetricVisual({required this.project, required this.hovered});

  final _Project project;
  final bool hovered;

  @override
  Widget build(BuildContext context) {
    final tint = project.tint;
    return Stack(
      fit: StackFit.expand,
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Color.alphaBlend(
                  tint.withValues(alpha: 0.5),
                  AppColors.surface,
                ),
                Color.alphaBlend(
                  tint.withValues(alpha: 0.08),
                  AppColors.surface,
                ),
              ],
            ),
          ),
        ),
        TweenAnimationBuilder<double>(
          tween: Tween(end: hovered ? 1.0 : 0.0),
          duration: const Duration(milliseconds: 1400),
          curve: Curves.easeOutCubic,
          builder:
              (context, t, _) => CustomPaint(
                painter: _OrbitPainter(
                  tint: tint,
                  t: t,
                  center: const Alignment(0.55, -0.45),
                ),
              ),
        ),
        Padding(
          padding: const EdgeInsets.all(36),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (project.metric != null)
                Text(
                  project.metric!,
                  style: AppTextStyles.display(size: fluid(context, 80, 128)),
                ),
              if (project.metricLabel != null) ...[
                const SizedBox(height: 10),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 340),
                  child: Text(
                    project.metricLabel!,
                    style: AppTextStyles.body(
                      size: 15,
                      height: 1.5,
                      color: AppColors.text.withValues(alpha: 0.8),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

/// Concentric hairline rings with a satellite dot on each; [t] turns the
/// satellites (each ring at its own speed and direction).
class _OrbitPainter extends CustomPainter {
  _OrbitPainter({required this.tint, required this.t, required this.center});

  final Color tint;
  final double t;
  final Alignment center;

  @override
  void paint(Canvas canvas, Size size) {
    final c = center.alongSize(size);
    final light = Color.lerp(tint, Colors.white, 0.55)!;
    final ring =
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1;
    final dot = Paint();

    for (int i = 0; i < 8; i++) {
      final r = 36.0 + i * 48;
      ring.color = light.withValues(alpha: max(0.04, 0.3 - i * 0.034));
      canvas.drawCircle(c, r, ring);

      final direction = i.isEven ? 1 : -1;
      final angle = i * 1.3 + direction * t * (0.6 + i * 0.1);
      dot.color = light.withValues(alpha: max(0.15, 0.8 - i * 0.08));
      canvas.drawCircle(
        c + Offset(cos(angle), sin(angle)) * r,
        i == 2 ? 4 : 2.5,
        dot,
      );
    }
    dot.color = light.withValues(alpha: 0.9);
    canvas.drawCircle(c, 5, dot);
  }

  @override
  bool shouldRepaint(covariant _OrbitPainter oldDelegate) =>
      oldDelegate.t != t ||
      oldDelegate.tint != tint ||
      oldDelegate.center != center;
}

class _PhoneFrame extends StatelessWidget {
  const _PhoneFrame({required this.image, required this.width});

  final String image;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: EdgeInsets.all(width * 0.03),
      decoration: BoxDecoration(
        color: const Color(0xFF1C1C1F),
        borderRadius: BorderRadius.circular(width * 0.16),
        border: Border.all(color: const Color(0x2EFFFFFF)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x99000000),
            blurRadius: 60,
            offset: Offset(0, 30),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(width * 0.13),
        child: AspectRatio(
          aspectRatio: 9 / 19.5,
          child: Image.asset(
            image,
            fit: BoxFit.cover,
            alignment: Alignment.topCenter,
            cacheWidth: 640,
          ),
        ),
      ),
    );
  }
}

/// Compact editorial row for smaller projects.
class _ArchiveRow extends StatelessWidget {
  const _ArchiveRow({required this.project, required this.index});

  final _Project project;
  final int index;

  @override
  Widget build(BuildContext context) {
    final onTap = project.action(context);
    final mobile = Breakpoints.isMobile(context);

    return HoverBuilder(
      onTap: onTap,
      builder: (context, hovered) {
        final active = hovered && onTap != null;
        final title = AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 250),
          style: AppTextStyles.display(
            size: mobile ? 30 : 34,
            color: active ? AppColors.accent : AppColors.text,
          ),
          child: Text(project.title),
        );
        final description = Text(
          project.description,
          style: AppTextStyles.body(size: 15, height: 1.6),
        );
        final tags = Text(
          project.tags.join('  ·  ').toUpperCase(),
          style: AppTextStyles.mono(size: 11, letterSpacing: 1.2),
        );
        final arrow = SizedBox(
          width: 32,
          child:
              onTap == null
                  ? null
                  : AnimatedSlide(
                    duration: const Duration(milliseconds: 300),
                    offset: active ? const Offset(0.15, -0.15) : Offset.zero,
                    child: Icon(
                      project.url != null ? Icons.north_east : Icons.add,
                      size: 20,
                      color: active ? AppColors.accent : AppColors.textMuted,
                    ),
                  ),
        );

        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
          padding: EdgeInsets.symmetric(
            vertical: mobile ? 28 : 34,
            horizontal: active && !mobile ? 20 : 0,
          ),
          decoration: BoxDecoration(
            color: active ? const Color(0x08FFFFFF) : const Color(0x00FFFFFF),
            border: const Border(bottom: BorderSide(color: AppColors.border)),
          ),
          child:
              mobile
                  ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(_pad(index), style: AppTextStyles.mono()),
                          const SizedBox(width: 16),
                          Expanded(child: title),
                          arrow,
                        ],
                      ),
                      const SizedBox(height: 12),
                      description,
                      const SizedBox(height: 14),
                      tags,
                    ],
                  )
                  : Row(
                    children: [
                      SizedBox(
                        width: 56,
                        child: Text(_pad(index), style: AppTextStyles.mono()),
                      ),
                      Expanded(
                        flex: 4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            title,
                            const SizedBox(height: 4),
                            Text(
                              project.category.toUpperCase(),
                              style: AppTextStyles.mono(
                                size: 11,
                                color: AppColors.textMuted,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 32),
                      Expanded(flex: 6, child: description),
                      const SizedBox(width: 32),
                      Expanded(flex: 3, child: tags),
                      arrow,
                    ],
                  ),
        );
      },
    );
  }
}

void _showPreview(BuildContext context, _Project project) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: 'Close preview',
    barrierColor: const Color(0xD9000000),
    transitionDuration: const Duration(milliseconds: 350),
    pageBuilder: (context, _, _) => _PreviewDialog(project: project),
    transitionBuilder: (context, animation, _, child) {
      final curved = CurvedAnimation(
        parent: animation,
        curve: Curves.easeOutCubic,
      );
      return FadeTransition(
        opacity: curved,
        child: ScaleTransition(
          scale: Tween(begin: 0.96, end: 1.0).animate(curved),
          child: child,
        ),
      );
    },
  );
}

class _PreviewDialog extends StatelessWidget {
  const _PreviewDialog({required this.project});

  final _Project project;

  @override
  Widget build(BuildContext context) {
    final mobile = Breakpoints.isMobile(context);

    final details = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          project.category.toUpperCase(),
          style: AppTextStyles.mono(
            color: AppColors.accent,
            letterSpacing: 1.8,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          project.title,
          style: AppTextStyles.display(size: mobile ? 36 : 48),
        ),
        const SizedBox(height: 14),
        Text(project.description, style: AppTextStyles.body(size: 16)),
        const SizedBox(height: 24),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [for (final tag in project.tags) TagChip(tag)],
        ),
        const SizedBox(height: 32),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            if (project.url != null)
              PillButton(
                label: project.urlLabel,
                filled: true,
                trailing: Icons.north_east,
                onTap: () => Links.open(project.url!),
              ),
            PillButton(
              label: 'Close',
              onTap: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ],
    );

    final Widget layout;
    if (project.landscape) {
      layout = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Image.asset(project.image!, cacheWidth: 1600),
          ),
          const SizedBox(height: 32),
          details,
        ],
      );
    } else if (mobile) {
      layout = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(child: _PhoneFrame(image: project.image!, width: 200)),
          const SizedBox(height: 32),
          details,
        ],
      );
    } else {
      layout = Row(
        children: [
          _PhoneFrame(image: project.image!, width: 260),
          const SizedBox(width: 48),
          Expanded(child: details),
        ],
      );
    }

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: project.landscape ? 960 : 820),
          child: Material(
            type: MaterialType.transparency,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: AppColors.borderStrong),
              ),
              child: SingleChildScrollView(
                padding: EdgeInsets.all(mobile ? 22 : 40),
                child: layout,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
