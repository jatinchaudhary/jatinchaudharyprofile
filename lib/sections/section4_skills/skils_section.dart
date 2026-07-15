import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jatinchaudhary/utils/app_text_styles.dart';
import 'package:jatinchaudhary/utils/constants.dart';

/// Skills bento grid.
///
/// The grid is laid out on a logical unit grid: every tile is placed at an
/// integer (x, y) coordinate and spans (w, h) cells. The size of a single
/// cell (`unit`) is derived from the available width, so the whole grid scales
/// fluidly and never overflows. On narrow screens the tiles reflow into a
/// 4-column arrangement instead of the 8-column desktop one.
class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  // Breakpoint below which we switch to the compact (4-column) arrangement.
  static const double _wideBreakpoint = 720;
  static const double _gap = 10;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Skills", style: AppTextStyles.sectionHeadingStyle),
          const SizedBox(height: 70),
          LayoutBuilder(
            builder: (context, constraints) {
              final bool isWide = constraints.maxWidth >= _wideBreakpoint;

              final placements = isWide ? _wideLayout : _narrowLayout;
              final int cols = isWide ? 8 : 4;
              final double maxGridWidth = isWide ? 800 : 520;

              final double gridWidth =
                  constraints.maxWidth.clamp(0.0, maxGridWidth);
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
          ),
        ],
      ),
    );
  }
}

/// Wide (>= 720px) 8-column arrangement.
const List<_Placement> _wideLayout = [
  // Band 1
  _Placement('flutter', 0, 0, 3, 3),
  _Placement('ios', 3, 0, 2, 2),
  _Placement('react', 3, 2, 2, 1),
  _Placement('android', 5, 0, 3, 1),
  _Placement('cicd', 5, 1, 1, 2),
  _Placement('aws', 6, 1, 2, 2),
  // Band 2
  _Placement('firebase', 0, 3, 2, 1),
  _Placement('dart', 2, 3, 1, 1),
  _Placement('cpp', 0, 4, 1, 1),
  _Placement('graphql', 1, 4, 2, 1),
  _Placement('node', 3, 3, 3, 2),
  _Placement('pubdev', 6, 3, 2, 1),
  _Placement('rest', 6, 4, 1, 1),
  _Placement('llm', 7, 4, 1, 1),
];

/// Compact (< 720px) 4-column arrangement.
const List<_Placement> _narrowLayout = [
  _Placement('flutter', 0, 0, 4, 2),
  _Placement('ios', 0, 2, 2, 2),
  _Placement('aws', 2, 2, 2, 2),
  _Placement('android', 0, 4, 4, 1),
  _Placement('node', 0, 5, 3, 2),
  _Placement('dart', 3, 5, 1, 1),
  _Placement('cpp', 3, 6, 1, 1),
  _Placement('firebase', 0, 7, 2, 1),
  _Placement('graphql', 2, 7, 2, 1),
  _Placement('react', 0, 8, 2, 1),
  _Placement('pubdev', 2, 8, 2, 1),
  _Placement('cicd', 0, 9, 2, 1),
  _Placement('llm', 2, 9, 1, 1),
  _Placement('rest', 3, 9, 1, 1),
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
  final List<Color> colors;
  final Widget child;
  final Alignment begin;
  final Alignment end;

  /// Inset around the icon as a fraction of the tile's shorter side.
  final double padFrac;

  /// Extra zoom for icons that carry a lot of internal whitespace.
  final double scale;

  const _SkillStyle({
    required this.colors,
    required this.child,
    this.begin = Alignment.topLeft,
    this.end = Alignment.bottomRight,
    this.padFrac = 0.16,
    this.scale = 1.0,
  });
}

final Map<String, _SkillStyle> _skills = {
  'flutter': const _SkillStyle(
    colors: [Color.fromARGB(32, 9, 53, 174), Color.fromARGB(26, 9, 53, 174)],
    padFrac: 0.12,
    child: Image(image: AssetImage(Constants.flutterIcon), fit: BoxFit.contain),
  ),
  'ios': const _SkillStyle(
    colors: [
      Color.fromARGB(17, 255, 255, 255),
      Color.fromARGB(4, 255, 255, 255),
    ],
    child: Image(image: AssetImage(Constants.iosIcon), fit: BoxFit.contain),
  ),
  'react': const _SkillStyle(
    colors: [Color.fromARGB(27, 13, 149, 170), Color.fromARGB(17, 13, 149, 170)],
    padFrac: 0.2,
    child: Image(image: AssetImage(Constants.reactIcon), fit: BoxFit.contain),
  ),
  'android': _SkillStyle(
    colors: const [
      Color.fromARGB(20, 78, 186, 92),
      Color.fromARGB(13, 78, 186, 92),
    ],
    begin: Alignment.bottomRight,
    end: Alignment.topLeft,
    padFrac: 0.18,
    child: SvgPicture.asset(Constants.androidIcon, fit: BoxFit.contain),
  ),
  'cicd': const _SkillStyle(
    colors: [Color.fromARGB(29, 5, 64, 94), Color.fromARGB(15, 5, 64, 94)],
    child: Image(image: AssetImage(Constants.cicdIcon), fit: BoxFit.contain),
  ),
  'aws': const _SkillStyle(
    colors: [Color.fromARGB(25, 236, 110, 26), Color.fromARGB(14, 236, 110, 26)],
    padFrac: 0.2,
    child: Image(image: AssetImage(Constants.awsIcon), fit: BoxFit.contain),
  ),
  'firebase': const _SkillStyle(
    colors: [Color.fromARGB(23, 219, 162, 49), Color.fromARGB(11, 219, 162, 49)],
    padFrac: 0.12,
    child: Image(image: AssetImage(Constants.firebaseIcon), fit: BoxFit.contain),
  ),
  'dart': _SkillStyle(
    colors: const [
      Color.fromARGB(25, 30, 88, 233),
      Color.fromARGB(13, 30, 88, 233),
    ],
    padFrac: 0.18,
    child: SvgPicture.asset(Constants.dartIcon, fit: BoxFit.contain),
  ),
  'cpp': _SkillStyle(
    colors: const [
      Color.fromARGB(21, 30, 40, 233),
      Color.fromARGB(11, 30, 40, 233),
    ],
    padFrac: 0.18,
    child: SvgPicture.asset(Constants.cppIcon, fit: BoxFit.contain),
  ),
  'graphql': _SkillStyle(
    colors: const [
      Color.fromARGB(23, 180, 9, 66),
      Color.fromARGB(10, 180, 9, 66),
    ],
    padFrac: 0.18,
    child: SvgPicture.asset(Constants.graphqlIcon, fit: BoxFit.contain),
  ),
  'node': _SkillStyle(
    colors: const [
      Color.fromARGB(22, 74, 230, 46),
      Color.fromARGB(10, 74, 230, 46),
    ],
    padFrac: 0.22,
    child: SvgPicture.asset(Constants.nodeIcon, fit: BoxFit.contain),
  ),
  'pubdev': const _SkillStyle(
    colors: [Color.fromARGB(33, 16, 110, 136), Color.fromARGB(16, 16, 110, 136)],
    padFrac: 0.1,
    scale: 1.4,
    child: Image(image: AssetImage(Constants.pubdevIcon), fit: BoxFit.contain),
  ),
  'rest': const _SkillStyle(
    colors: [Color.fromARGB(26, 21, 21, 71), Color.fromARGB(14, 21, 21, 71)],
    padFrac: 0.18,
    child: Image(image: AssetImage(Constants.restIcon), fit: BoxFit.contain),
  ),
  'llm': const _SkillStyle(
    colors: [Color.fromARGB(27, 191, 7, 7), Color.fromARGB(15, 191, 7, 7)],
    padFrac: 0.08,
    scale: 2.0,
    child: Image(image: AssetImage(Constants.llmIcon), fit: BoxFit.contain),
  ),
};

/// A single skill tile. Stateless and animation-free: it's a plain gradient
/// box, so rendering a whole grid of them is cheap.
class _SkillBox extends StatelessWidget {
  final _SkillStyle style;
  final double width;
  final double height;

  const _SkillBox({
    required this.style,
    required this.width,
    required this.height,
  });

  static const Color _borderColor = Color.fromARGB(47, 106, 105, 105);

  @override
  Widget build(BuildContext context) {
    final double pad = (width < height ? width : height) * style.padFrac;

    Widget icon = style.child;
    if (style.scale != 1.0) {
      icon = Transform.scale(scale: style.scale, child: icon);
    }

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: LinearGradient(
          begin: style.begin,
          end: style.end,
          colors: style.colors,
        ),
        border: Border.all(color: _borderColor, width: 1),
      ),
      child: Padding(
        padding: EdgeInsets.all(pad),
        child: Center(child: icon),
      ),
    );
  }
}
