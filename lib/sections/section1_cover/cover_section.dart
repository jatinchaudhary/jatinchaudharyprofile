import 'dart:math';

import 'package:flutter/material.dart';
import 'package:jatinchaudhary/sections/section.dart';
import 'package:jatinchaudhary/utils/app_text_styles.dart';
import 'package:jatinchaudhary/utils/constants.dart';
import 'package:jatinchaudhary/widgets/common.dart';

class CoverSection extends StatelessWidget {
  const CoverSection({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final mobile = size.width < Breakpoints.mobile;
    final scroller = SectionScroller.of(context);

    return Stack(
      children: [
        Positioned.fill(
          child: AmbientBackground(
            glows: [
              (
                const Alignment(-1.1, 0.0),
                AppColors.glowBlue.withValues(alpha: 0.35),
                0.9,
              ),
              (
                const Alignment(0.5, -0.2),
                AppColors.glowTeal.withValues(alpha: 0.45),
                0.9,
              ),
              (
                const Alignment(0.0, 0.8),
                AppColors.glowPurple.withValues(alpha: 0.35),
                0.7,
              ),
            ],
          ),
        ),
        // Fade the grid into the page below.
        const Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          height: 160,
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0x00000000), AppColors.bg],
              ),
            ),
          ),
        ),
        ContentWidth(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: max(size.height, 680)),
            child: Padding(
              padding: EdgeInsets.only(top: mobile ? 112 : 136, bottom: 36),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Reveal(child: _Intro()),
                      SizedBox(height: mobile ? 32 : 40),
                      Reveal(
                        delay: const Duration(milliseconds: 120),
                        child: _Headline(size: fluid(context, 44, 100)),
                      ),
                      const SizedBox(height: 28),
                      Reveal(
                        delay: const Duration(milliseconds: 240),
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 560),
                          child: Text(
                            "Software engineer with 5+ years building "
                            "production systems across real-money gaming, "
                            "quick-commerce and consumer AI, from event-driven "
                            "backends to the Flutter apps on top of them.",
                            style: AppTextStyles.body(size: mobile ? 16 : 18),
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                      Reveal(
                        delay: const Duration(milliseconds: 360),
                        child: Wrap(
                          spacing: 12,
                          runSpacing: 12,
                          children: [
                            PillButton(
                              label: 'View selected work',
                              filled: true,
                              trailing: Icons.arrow_forward,
                              onTap: () => scroller.goTo(SectionId.work),
                            ),
                            PillButton(
                              label: 'Get in touch',
                              onTap: () => scroller.goTo(SectionId.contact),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 48),
                  const Reveal(
                    delay: Duration(milliseconds: 480),
                    child: _MetaRow(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _Intro extends StatelessWidget {
  const _Intro();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.borderStrong),
          ),
          child: ClipOval(
            child: SizedBox(
              width: 48,
              height: 48,
              child: Transform.scale(
                alignment: const Alignment(0, -0.2),
                scale: 1.8,
                child: Image.asset(
                  Constants.profileIcon,
                  fit: BoxFit.cover,
                  cacheWidth: 240,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Hello, I'm Jatin.",
              style: AppTextStyles.body(
                size: 15,
                color: AppColors.text,
                weight: FontWeight.w500,
                height: 1.3,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const _PulseDot(),
                const SizedBox(width: 8),
                Text(
                  'SDE-II at Junglee Games',
                  style: AppTextStyles.body(size: 13, height: 1.3),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class _Headline extends StatelessWidget {
  const _Headline({required this.size});

  final double size;

  @override
  Widget build(BuildContext context) {
    final base = AppTextStyles.display(size: size).copyWith(height: 1.0);
    return Text.rich(
      TextSpan(
        style: base,
        children: [
          const TextSpan(text: 'I design & develop\n'),
          const TextSpan(
            text: 'scalable systems',
            style: TextStyle(
              fontStyle: FontStyle.italic,
              color: AppColors.accent,
            ),
          ),
          const TextSpan(text: '\nand the apps built on them'),
          WidgetSpan(
            alignment: PlaceholderAlignment.baseline,
            baseline: TextBaseline.alphabetic,
            child: _Caret(height: size * 0.72),
          ),
        ],
      ),
    );
  }
}

/// Thin blinking text cursor at the end of the headline.
class _Caret extends StatefulWidget {
  const _Caret({required this.height});

  final double height;

  @override
  State<_Caret> createState() => _CaretState();
}

class _CaretState extends State<_Caret> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1100),
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: widget.height * 0.12),
      child: AnimatedBuilder(
        animation: _controller,
        builder:
            (context, child) => Opacity(
              opacity: _controller.value < 0.55 ? 1 : 0,
              child: child,
            ),
        child: Container(
          width: max(2, widget.height * 0.05),
          height: widget.height,
          color: AppColors.accent,
        ),
      ),
    );
  }
}

/// Small "online" dot with a soft expanding halo.
class _PulseDot extends StatefulWidget {
  const _PulseDot();

  @override
  State<_PulseDot> createState() => _PulseDotState();
}

class _PulseDotState extends State<_PulseDot>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1800),
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 14,
      height: 14,
      child: AnimatedBuilder(
        animation: _controller,
        builder:
            (context, _) => Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 6 + 8 * _controller.value,
                  height: 6 + 8 * _controller.value,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.live.withValues(
                      alpha: 0.35 * (1 - _controller.value),
                    ),
                  ),
                ),
                Container(
                  width: 6,
                  height: 6,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.live,
                  ),
                ),
              ],
            ),
      ),
    );
  }
}

class _MetaRow extends StatelessWidget {
  const _MetaRow();

  static const _items = [
    ('Based in', 'Gurgaon, India'),
    ('Focus', 'Backend · Mobile · AI'),
    ('Experience', '5+ years'),
  ];

  @override
  Widget build(BuildContext context) {
    final mobile = Breakpoints.isMobile(context);
    final items = [
      for (final (label, value) in _items)
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(label.toUpperCase(), style: AppTextStyles.mono(size: 11)),
            const SizedBox(height: 8),
            Text(
              value,
              style: AppTextStyles.body(
                size: 14,
                color: AppColors.text,
                height: 1.3,
              ),
            ),
          ],
        ),
    ];

    return Container(
      padding: const EdgeInsets.only(top: 24),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.border)),
      ),
      child:
          mobile
              ? Wrap(spacing: 40, runSpacing: 20, children: items)
              : Row(
                children: [
                  for (final item in items) ...[
                    item,
                    const SizedBox(width: 72),
                  ],
                  const Spacer(),
                  const _ScrollHint(),
                ],
              ),
    );
  }
}

class _ScrollHint extends StatefulWidget {
  const _ScrollHint();

  @override
  State<_ScrollHint> createState() => _ScrollHintState();
}

class _ScrollHintState extends State<_ScrollHint>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1600),
  )..repeat(reverse: true);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scroller = SectionScroller.of(context);
    return HoverBuilder(
      onTap: () => scroller.goTo(SectionId.about),
      builder:
          (context, hovered) => Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'SCROLL',
                style: AppTextStyles.mono(
                  size: 11,
                  color: hovered ? AppColors.text : AppColors.textFaint,
                  letterSpacing: 2.4,
                ),
              ),
              const SizedBox(width: 12),
              AnimatedBuilder(
                animation: _controller,
                builder:
                    (context, child) => Transform.translate(
                      offset: Offset(
                        0,
                        4 * Curves.easeInOut.transform(_controller.value),
                      ),
                      child: child,
                    ),
                child: Icon(
                  Icons.south,
                  size: 14,
                  color: hovered ? AppColors.accent : AppColors.textFaint,
                ),
              ),
            ],
          ),
    );
  }
}
