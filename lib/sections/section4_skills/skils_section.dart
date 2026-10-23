import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jatinchaudhary/utils/app_text_styles.dart';
import 'package:jatinchaudhary/utils/constants.dart';
import 'package:jatinchaudhary/widgets/common.dart';

/// Skills: a logo bento grid beside the capability groups that don't map to
/// a logo.
class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  static const double _gridMaxWidth = 620;

  @override
  Widget build(BuildContext context) {
    return SectionShell(
      number: '03',
      label: 'Skills',
      title: 'A toolkit shaped by *production.*',
      child: LayoutBuilder(
        builder: (context, constraints) {
          final wide = constraints.maxWidth >= 1000;
          if (wide) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  width: _gridMaxWidth,
                  child: Reveal(child: _SkillGrid()),
                ),
                const SizedBox(width: 64),
                Expanded(child: _SkillGroups()),
              ],
            );
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Reveal(child: _SkillGrid()),
              const SizedBox(height: 64),
              _SkillGroups(),
            ],
          );
        },
      ),
    );
  }
}

class _SkillGroups extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (int i = 0; i < _skillGroups.length; i++)
          Reveal(
            delay: Duration(milliseconds: 80 * i),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 24),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: i == 0 ? AppColors.borderStrong : AppColors.border,
                  ),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 40,
                    child: Text(
                      '0${i + 1}',
                      style: AppTextStyles.mono(color: AppColors.accent),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _skillGroups[i].$1,
                          style: AppTextStyles.body(
                            size: 16,
                            color: AppColors.text,
                            weight: FontWeight.w500,
                            height: 1.3,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          _skillGroups[i].$2,
                          style: AppTextStyles.body(size: 14.5),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}

/// The grid is laid out on a logical unit grid: every tile is placed at an
/// integer (x, y) coordinate and spans (w, h) cells. The size of a single
/// cell (`unit`) is derived from the available width, so the whole grid scales
/// fluidly and never overflows. On narrow screens the tiles reflow into a
/// 4-column arrangement instead of the 8-column desktop one.
class _SkillGrid extends StatelessWidget {
  const _SkillGrid();

  // Breakpoint below which we switch to the compact (4-column) arrangement.
  static const double _wideBreakpoint = 560;
  static const double _gap = 8;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isWide = constraints.maxWidth >= _wideBreakpoint;

        final placements = isWide ? _wideLayout : _narrowLayout;
        final int cols = isWide ? 8 : 4;
        final double maxGridWidth = isWide ? 800 : 520;

        final double gridWidth = constraints.maxWidth.clamp(0.0, maxGridWidth);
        final double unit = (gridWidth - (cols - 1) * _gap) / cols;

        int rows = 0;
        for (final p in placements) {
          if (p.y + p.h > rows) rows = p.y + p.h;
        }
        final double gridHeight = rows * unit + (rows - 1) * _gap;

        double span(int cells) => cells * unit + (cells - 1) * _gap;

        return SizedBox(
          width: gridWidth,
          height: gridHeight,
          child: RepaintBoundary(
            child: Stack(
              children: [
                for (final p in placements)
                  Positioned(
                    left: p.x * (unit + _gap),
                    top: p.y * (unit + _gap),
                    width: span(p.w),
                    height: span(p.h),
                    child: _SkillBox(
                      style: _skills[p.key]!,
                      width: span(p.w),
                      height: span(p.h),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}

/// Skills that don't map to a logo, listed beside the grid.
const List<(String, String)> _skillGroups = [
  (
    "Architecture & System Design",
    "Distributed systems, high-traffic & large-scale systems, event-driven "
        "architectures, microservices, caching & data modeling, concurrency, "
        "fault tolerance and observability.",
  ),
  (
    "AI Engineering",
    "Agent orchestration, multi-agent systems, prompt caching, intent-based "
        "model routing, vector similarity (KNN).",
  ),
  (
    "Mobile & Tooling",
    "Flutter, custom platform plugins, Shorebird OTA, Play Store releases, "
        "GitHub Actions, Bitbucket Pipelines, Fastlane, New Relic.",
  ),
  (
    "Leadership",
    "Technical leadership, cross-functional coordination, product thinking.",
  ),
];

/// Wide 8-column arrangement.
const List<_Placement> _wideLayout = [
  // Band 1
  _Placement('spring', 0, 0, 3, 3),
  _Placement('kafka', 3, 0, 2, 2),
  _Placement('python', 3, 2, 2, 1),
  _Placement('flutter', 5, 0, 3, 1),
  _Placement('docker', 5, 1, 1, 2),
  _Placement('aws', 6, 1, 2, 2),
  // Band 2
  _Placement('java', 0, 3, 2, 2),
  _Placement('redis', 2, 3, 2, 1),
  _Placement('dart', 2, 4, 1, 1),
  _Placement('cpp', 3, 4, 1, 1),
  _Placement('postgres', 4, 3, 2, 2),
  _Placement('firebase', 6, 3, 2, 1),
  _Placement('llm', 6, 4, 1, 1),
  _Placement('rest', 7, 4, 1, 1),
  // Band 3
  _Placement('android', 0, 5, 3, 1),
  _Placement('typescript', 3, 5, 1, 1),
  _Placement('cicd', 4, 5, 2, 1),
  _Placement('elasticsearch', 6, 5, 2, 1),
];

/// Compact 4-column arrangement.
const List<_Placement> _narrowLayout = [
  _Placement('spring', 0, 0, 4, 2),
  _Placement('java', 0, 2, 2, 2),
  _Placement('kafka', 2, 2, 2, 2),
  _Placement('aws', 0, 4, 2, 2),
  _Placement('redis', 2, 4, 2, 1),
  _Placement('postgres', 2, 5, 2, 1),
  _Placement('flutter', 0, 6, 4, 1),
  _Placement('docker', 0, 7, 1, 2),
  _Placement('python', 1, 7, 2, 1),
  _Placement('dart', 3, 7, 1, 1),
  _Placement('typescript', 1, 8, 1, 1),
  _Placement('cpp', 2, 8, 1, 1),
  _Placement('llm', 3, 8, 1, 1),
  _Placement('firebase', 0, 9, 2, 1),
  _Placement('elasticsearch', 2, 9, 2, 1),
  _Placement('android', 0, 10, 2, 1),
  _Placement('cicd', 2, 10, 1, 1),
  _Placement('rest', 3, 10, 1, 1),
];

class _Placement {
  final String key;
  final int x;
  final int y;
  final int w;
  final int h;
  const _Placement(this.key, this.x, this.y, this.w, this.h);
}

/// Visual definition of a single skill tile. Kept separate from layout so the
/// same tile can be placed differently per breakpoint.
class _SkillStyle {
  final String name;

  /// Brand colour used for the tile's glow.
  final Color brand;
  final Widget child;

  /// Inset around the icon as a fraction of the tile's shorter side.
  final double padFrac;

  /// Extra zoom for icons that carry a lot of internal whitespace.
  final double scale;

  const _SkillStyle({
    required this.name,
    required this.brand,
    required this.child,
    this.padFrac = 0.16,
    this.scale = 1.0,
  });
}

final Map<String, _SkillStyle> _skills = {
  'spring': _SkillStyle(
    name: 'Spring Boot',
    brand: const Color(0xFF6DB33F),
    padFrac: 0.24,
    child: SvgPicture.asset(
      Constants.springIcon,
      fit: BoxFit.contain,
      colorFilter: const ColorFilter.mode(Color(0xFF6DB33F), BlendMode.srcIn),
    ),
  ),
  'java': _SkillStyle(
    name: 'Java',
    brand: const Color(0xFFEA2D2E),
    padFrac: 0.22,
    child: SvgPicture.asset(Constants.javaIcon, fit: BoxFit.contain),
  ),
  'kafka': _SkillStyle(
    name: 'Apache Kafka',
    brand: const Color(0xFFFFFFFF),
    padFrac: 0.26,
    child: SvgPicture.asset(
      Constants.kafkaIcon,
      fit: BoxFit.contain,
      colorFilter: const ColorFilter.mode(
        Color.fromARGB(230, 255, 255, 255),
        BlendMode.srcIn,
      ),
    ),
  ),
  'redis': _SkillStyle(
    name: 'Redis',
    brand: const Color(0xFFD82C20),
    padFrac: 0.2,
    child: SvgPicture.asset(Constants.redisIcon, fit: BoxFit.contain),
  ),
  'postgres': _SkillStyle(
    name: 'PostgreSQL',
    brand: const Color(0xFF4A86C5),
    padFrac: 0.24,
    child: SvgPicture.asset(Constants.postgresIcon, fit: BoxFit.contain),
  ),
  'docker': _SkillStyle(
    name: 'Docker',
    brand: const Color(0xFF019DE4),
    padFrac: 0.18,
    child: SvgPicture.asset(Constants.dockerIcon, fit: BoxFit.contain),
  ),
  'python': _SkillStyle(
    name: 'Python',
    brand: const Color(0xFF3776AB),
    padFrac: 0.2,
    child: SvgPicture.asset(Constants.pythonIcon, fit: BoxFit.contain),
  ),
  'typescript': _SkillStyle(
    name: 'TypeScript',
    brand: const Color(0xFF007ACC),
    padFrac: 0.24,
    child: SvgPicture.asset(Constants.typescriptIcon, fit: BoxFit.contain),
  ),
  'elasticsearch': _SkillStyle(
    name: 'Elasticsearch',
    brand: const Color(0xFF00BFB3),
    padFrac: 0.22,
    child: SvgPicture.asset(Constants.elasticsearchIcon, fit: BoxFit.contain),
  ),
  'flutter': const _SkillStyle(
    name: 'Flutter',
    brand: Color(0xFF4A90E2),
    padFrac: 0.14,
    child: Image(image: AssetImage(Constants.flutterIcon), fit: BoxFit.contain),
  ),
  'android': _SkillStyle(
    name: 'Android',
    brand: const Color(0xFF3DDC84),
    padFrac: 0.2,
    child: SvgPicture.asset(Constants.androidIcon, fit: BoxFit.contain),
  ),
  'cicd': const _SkillStyle(
    name: 'CI/CD',
    brand: Color(0xFF2B8CC4),
    padFrac: 0.18,
    child: Image(image: AssetImage(Constants.cicdIcon), fit: BoxFit.contain),
  ),
  'aws': const _SkillStyle(
    name: 'AWS',
    brand: Color(0xFFEC6E1A),
    padFrac: 0.24,
    child: Image(image: AssetImage(Constants.awsIcon), fit: BoxFit.contain),
  ),
  'firebase': const _SkillStyle(
    name: 'Firebase',
    brand: Color(0xFFDBA231),
    padFrac: 0.14,
    child: Image(
      image: AssetImage(Constants.firebaseIcon),
      fit: BoxFit.contain,
    ),
  ),
  'dart': _SkillStyle(
    name: 'Dart',
    brand: const Color(0xFF1E88E5),
    padFrac: 0.22,
    child: SvgPicture.asset(Constants.dartIcon, fit: BoxFit.contain),
  ),
  'cpp': _SkillStyle(
    name: 'C++',
    brand: const Color(0xFF3F6FE0),
    padFrac: 0.22,
    child: SvgPicture.asset(Constants.cppIcon, fit: BoxFit.contain),
  ),
  'rest': const _SkillStyle(
    name: 'REST APIs',
    brand: Color(0xFF7B7BE8),
    padFrac: 0.22,
    child: Image(image: AssetImage(Constants.restIcon), fit: BoxFit.contain),
  ),
  'llm': const _SkillStyle(
    name: 'LLMs',
    brand: Color(0xFFD94848),
    padFrac: 0.1,
    scale: 2.0,
    child: Image(image: AssetImage(Constants.llmIcon), fit: BoxFit.contain),
  ),
};

/// A single skill tile: a dark surface with a faint brand-coloured glow that
/// brightens on hover, plus a tooltip naming the skill.
class _SkillBox extends StatelessWidget {
  final _SkillStyle style;
  final double width;
  final double height;

  const _SkillBox({
    required this.style,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    final double pad = (width < height ? width : height) * style.padFrac;

    Widget icon = style.child;
    if (style.scale != 1.0) {
      icon = Transform.scale(scale: style.scale, child: icon);
    }

    return Tooltip(
      message: style.name,
      waitDuration: const Duration(milliseconds: 150),
      verticalOffset: height / 2 + 6,
      textStyle: AppTextStyles.mono(size: 11, color: AppColors.text),
      decoration: BoxDecoration(
        color: AppColors.surfaceRaised,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.borderStrong),
      ),
      child: HoverBuilder(
        builder:
            (context, hovered) => AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                // A gradient's shader replaces `color`, so the surface is
                // blended into the stops instead.
                gradient: RadialGradient(
                  center: Alignment.topLeft,
                  radius: 1.5,
                  colors: [
                    Color.alphaBlend(
                      style.brand.withValues(alpha: hovered ? 0.22 : 0.07),
                      AppColors.surface,
                    ),
                    AppColors.surface,
                  ],
                ),
                border: Border.all(
                  color:
                      hovered
                          ? style.brand.withValues(alpha: 0.45)
                          : AppColors.border,
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(pad),
                child: AnimatedScale(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOut,
                  scale: hovered ? 1.08 : 1.0,
                  child: Center(child: icon),
                ),
              ),
            ),
      ),
    );
  }
}
