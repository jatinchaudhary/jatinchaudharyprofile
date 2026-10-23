import 'package:flutter/material.dart';
import 'package:jatinchaudhary/utils/app_text_styles.dart';

/// Centres content in the page column with responsive side gutters.
class ContentWidth extends StatelessWidget {
  const ContentWidth({super.key, required this.child});

  static const double maxWidth = 1120;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final double gutter = Breakpoints.isMobile(context) ? 20 : 40;
    return Align(
      alignment: Alignment.topCenter,
      heightFactor: 1,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth + gutter * 2),
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: gutter),
            child: child,
          ),
        ),
      ),
    );
  }
}

/// Rebuilds with the current hover state and, when [onTap] is set, acts as a
/// clickable target.
class HoverBuilder extends StatefulWidget {
  const HoverBuilder({super.key, required this.builder, this.onTap});

  final Widget Function(BuildContext context, bool hovered) builder;
  final VoidCallback? onTap;

  @override
  State<HoverBuilder> createState() => _HoverBuilderState();
}

class _HoverBuilderState extends State<HoverBuilder> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor:
          widget.onTap != null ? SystemMouseCursors.click : MouseCursor.defer,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: widget.onTap,
        child: widget.builder(context, _hovered),
      ),
    );
  }
}

/// Fades and lifts its child in the first time it scrolls into view.
class Reveal extends StatefulWidget {
  const Reveal({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.offset = 28,
  });

  final Widget child;
  final Duration delay;
  final double offset;

  @override
  State<Reveal> createState() => _RevealState();
}

class _RevealState extends State<Reveal> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 900),
  );
  late final Animation<double> _curve = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeOutCubic,
  );

  ScrollPosition? _position;
  bool _triggered = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (MediaQuery.disableAnimationsOf(context)) {
      _controller.value = 1;
      _triggered = true;
    }
    final position = Scrollable.maybeOf(context)?.position;
    if (position != _position) {
      _position?.removeListener(_check);
      _position = position;
      if (!_triggered) _position?.addListener(_check);
    }
    WidgetsBinding.instance.addPostFrameCallback((_) => _check());
  }

  void _check() {
    if (_triggered || !mounted) return;
    final box = context.findRenderObject() as RenderBox?;
    if (box == null || !box.attached || !box.hasSize) return;
    final top = box.localToGlobal(Offset.zero).dy;
    if (top < MediaQuery.sizeOf(context).height * 0.92) {
      _triggered = true;
      _position?.removeListener(_check);
      Future.delayed(widget.delay, () {
        if (mounted) _controller.forward();
      });
    }
  }

  @override
  void dispose() {
    _position?.removeListener(_check);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _curve,
      child: widget.child,
      builder:
          (context, child) => Opacity(
            opacity: _curve.value,
            child: Transform.translate(
              offset: Offset(0, widget.offset * (1 - _curve.value)),
              child: child,
            ),
          ),
    );
  }
}

/// "01 —— ABOUT" style eyebrow shown above every section title.
class SectionLabel extends StatelessWidget {
  const SectionLabel({super.key, required this.number, required this.label});

  final String number;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(number, style: AppTextStyles.mono(color: AppColors.accent)),
        const SizedBox(width: 14),
        Container(width: 36, height: 1, color: AppColors.borderStrong),
        const SizedBox(width: 14),
        Text(
          label.toUpperCase(),
          style: AppTextStyles.mono(
            color: AppColors.textMuted,
            letterSpacing: 2.4,
          ),
        ),
      ],
    );
  }
}

/// Renders text where `*wrapped*` segments are set in italic accent.
class EmphasisText extends StatelessWidget {
  const EmphasisText(this.text, {super.key, required this.style});

  final String text;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    final parts = text.split('*');
    return Text.rich(
      TextSpan(
        style: style,
        children: [
          for (int i = 0; i < parts.length; i++)
            TextSpan(
              text: parts[i],
              style:
                  i.isOdd
                      ? const TextStyle(
                        fontStyle: FontStyle.italic,
                        color: AppColors.accent,
                      )
                      : null,
            ),
        ],
      ),
    );
  }
}

/// Shared scaffold for a page section: eyebrow, serif title, optional intro
/// and then the section body.
class SectionShell extends StatelessWidget {
  const SectionShell({
    super.key,
    required this.number,
    required this.label,
    required this.title,
    required this.child,
    this.intro,
  });

  final String number;
  final String label;
  final String title;
  final String? intro;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final mobile = Breakpoints.isMobile(context);
    return ContentWidth(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: mobile ? 88 : 116),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Reveal(child: SectionLabel(number: number, label: label)),
            const SizedBox(height: 28),
            Reveal(
              delay: const Duration(milliseconds: 80),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 860),
                child: EmphasisText(
                  title,
                  style: AppTextStyles.display(size: fluid(context, 40, 68)),
                ),
              ),
            ),
            if (intro != null) ...[
              const SizedBox(height: 24),
              Reveal(
                delay: const Duration(milliseconds: 160),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 580),
                  child: Text(intro!, style: AppTextStyles.body(size: 17)),
                ),
              ),
            ],
            SizedBox(height: mobile ? 56 : 80),
            child,
          ],
        ),
      ),
    );
  }
}

/// Rounded call-to-action. [filled] is solid white; otherwise a hairline
/// outline that brightens on hover.
class PillButton extends StatelessWidget {
  const PillButton({
    super.key,
    required this.label,
    required this.onTap,
    this.filled = false,
    this.leading,
    this.trailing,
    this.compact = false,
  });

  final String label;
  final VoidCallback onTap;
  final bool filled;
  final Widget? leading;
  final IconData? trailing;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final fg = filled ? AppColors.bg : AppColors.text;
    return HoverBuilder(
      onTap: onTap,
      builder:
          (context, hovered) => AnimatedContainer(
            duration: const Duration(milliseconds: 220),
            padding: EdgeInsets.symmetric(
              horizontal: compact ? 16 : 22,
              vertical: compact ? 9 : 14,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(999),
              color:
                  filled
                      ? (hovered ? Colors.white : AppColors.text)
                      : (hovered
                          ? const Color(0x12FFFFFF)
                          : const Color(0x05FFFFFF)),
              border: Border.all(
                color:
                    filled
                        ? Colors.transparent
                        : (hovered
                            ? const Color(0x4DFFFFFF)
                            : AppColors.borderStrong),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (leading != null) ...[leading!, const SizedBox(width: 10)],
                Text(
                  label,
                  style: AppTextStyles.body(
                    size: compact ? 13 : 14,
                    color: fg,
                    weight: FontWeight.w500,
                    height: 1.2,
                  ),
                ),
                if (trailing != null) ...[
                  const SizedBox(width: 8),
                  AnimatedSlide(
                    duration: const Duration(milliseconds: 220),
                    offset: hovered ? const Offset(0.15, -0.0) : Offset.zero,
                    child: Icon(trailing, size: compact ? 14 : 16, color: fg),
                  ),
                ],
              ],
            ),
          ),
    );
  }
}

/// Small outlined tag used for tech stacks.
class TagChip extends StatelessWidget {
  const TagChip(this.label, {super.key});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: AppColors.border),
        color: const Color(0x08FFFFFF),
      ),
      child: Text(
        label,
        style: AppTextStyles.mono(
          size: 11,
          color: AppColors.textMuted,
          letterSpacing: 0.4,
        ),
      ),
    );
  }
}

/// Faint grid with soft colour glows, used behind the hero and contact
/// sections. Painted once; never repaints.
class AmbientBackground extends StatelessWidget {
  const AmbientBackground({super.key, required this.glows});

  /// Each glow is a centre (in [Alignment] space), a colour and a radius
  /// relative to the shorter side.
  final List<(Alignment, Color, double)> glows;

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Stack(
        fit: StackFit.expand,
        children: [
          for (final (center, color, radius) in glows)
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: center,
                  radius: radius,
                  colors: [color, color.withValues(alpha: 0)],
                ),
              ),
            ),
          ShaderMask(
            blendMode: BlendMode.dstIn,
            shaderCallback:
                (bounds) => const RadialGradient(
                  center: Alignment(0, -0.2),
                  radius: 0.85,
                  colors: [Colors.white, Colors.transparent],
                ).createShader(bounds),
            child: CustomPaint(painter: _GridPainter()),
          ),
        ],
      ),
    );
  }
}

class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const cell = 88.0;
    final paint =
        Paint()
          ..color = const Color(0x0DFFFFFF)
          ..strokeWidth = 1;
    final dx = (size.width % cell) / 2;
    for (double x = dx; x <= size.width; x += cell) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    // Start one cell down so no line sits on the section's top edge.
    for (double y = cell; y <= size.height; y += cell) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
