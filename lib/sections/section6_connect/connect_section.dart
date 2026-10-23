import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jatinchaudhary/sections/section.dart';
import 'package:jatinchaudhary/utils/app_text_styles.dart';
import 'package:jatinchaudhary/utils/constants.dart';
import 'package:jatinchaudhary/utils/links.dart';
import 'package:jatinchaudhary/widgets/common.dart';

class ConnectSection extends StatelessWidget {
  const ConnectSection({super.key});

  @override
  Widget build(BuildContext context) {
    final mobile = Breakpoints.isMobile(context);

    Widget svgIcon(String asset) => SvgPicture.asset(
      asset,
      width: 15,
      height: 15,
      colorFilter: const ColorFilter.mode(AppColors.text, BlendMode.srcIn),
    );

    return Stack(
      children: [
        Positioned.fill(
          child: AmbientBackground(
            glows: [
              (
                const Alignment(-0.4, 0.2),
                AppColors.glowBlue.withValues(alpha: 0.3),
                1.0,
              ),
              (
                const Alignment(0.5, -0.2),
                AppColors.glowTeal.withValues(alpha: 0.4),
                0.8,
              ),
              (
                const Alignment(0.0, 1.0),
                AppColors.glowPurple.withValues(alpha: 0.35),
                0.7,
              ),
            ],
          ),
        ),
        // Fade the grid in from the section above.
        const Positioned(
          left: 0,
          right: 0,
          top: 0,
          height: 200,
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [AppColors.bg, Color(0x00000000)],
              ),
            ),
          ),
        ),
        ContentWidth(
          child: Padding(
            padding: EdgeInsets.only(top: mobile ? 72 : 96, bottom: 36),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Reveal(
                  child: SectionLabel(number: '05', label: 'Contact'),
                ),
                const SizedBox(height: 28),
                Reveal(
                  delay: const Duration(milliseconds: 80),
                  child: EmphasisText(
                    "Let's build something\n*worth shipping.*",
                    style: AppTextStyles.display(size: fluid(context, 48, 104)),
                  ),
                ),
                const SizedBox(height: 28),
                Reveal(
                  delay: const Duration(milliseconds: 160),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 520),
                    child: Text(
                      "Whether it's a role, a product idea or a hard systems "
                      "problem, my inbox is open. I'll get back to you soon.",
                      style: AppTextStyles.body(size: 17),
                    ),
                  ),
                ),
                const SizedBox(height: 48),
                const Reveal(
                  delay: Duration(milliseconds: 240),
                  child: _EmailLine(),
                ),
                const SizedBox(height: 36),
                Reveal(
                  delay: const Duration(milliseconds: 320),
                  child: Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      PillButton(
                        label: 'Email me',
                        filled: true,
                        trailing: Icons.arrow_forward,
                        onTap: Links.mail,
                      ),
                      PillButton(
                        label: 'LinkedIn',
                        leading: svgIcon(Constants.linkedinIcon),
                        trailing: Icons.north_east,
                        onTap: () => Links.open(Links.linkedin),
                      ),
                      PillButton(
                        label: 'GitHub',
                        leading: svgIcon(Constants.githubIcon),
                        trailing: Icons.north_east,
                        onTap: () => Links.open(Links.github),
                      ),
                      PillButton(
                        label: 'Resume',
                        leading: svgIcon(Constants.downloadIcon),
                        trailing: Icons.north_east,
                        onTap: () => Links.open(Links.resume),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: mobile ? 104 : 160),
                const _Footer(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

/// The email address set large, with an underline that warms on hover and a
/// copy button that confirms inline.
class _EmailLine extends StatefulWidget {
  const _EmailLine();

  @override
  State<_EmailLine> createState() => _EmailLineState();
}

class _EmailLineState extends State<_EmailLine> {
  bool _copied = false;

  Future<void> _copy() async {
    await Clipboard.setData(const ClipboardData(text: Links.email));
    if (!mounted) return;
    setState(() => _copied = true);
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) setState(() => _copied = false);
  }

  @override
  Widget build(BuildContext context) {
    final size = fluid(context, 24, 44);
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 20,
      runSpacing: 16,
      children: [
        HoverBuilder(
          onTap: Links.mail,
          builder:
              (context, hovered) => IntrinsicWidth(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    AnimatedDefaultTextStyle(
                      duration: const Duration(milliseconds: 250),
                      style: AppTextStyles.display(
                        size: size,
                        color: hovered ? AppColors.accent : AppColors.text,
                      ),
                      child: const Text(Links.email),
                    ),
                    const SizedBox(height: 6),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      height: 1,
                      color:
                          hovered ? AppColors.accent : AppColors.borderStrong,
                    ),
                  ],
                ),
              ),
        ),
        HoverBuilder(
          onTap: _copy,
          builder:
              (context, hovered) => AnimatedContainer(
                duration: const Duration(milliseconds: 220),
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 9,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(
                    color:
                        _copied
                            ? AppColors.live.withValues(alpha: 0.5)
                            : (hovered
                                ? const Color(0x4DFFFFFF)
                                : AppColors.borderStrong),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      _copied ? Icons.check : Icons.copy_rounded,
                      size: 14,
                      color: _copied ? AppColors.live : AppColors.textMuted,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      _copied ? 'Copied' : 'Copy',
                      style: AppTextStyles.mono(
                        size: 11,
                        color: _copied ? AppColors.live : AppColors.textMuted,
                        letterSpacing: 1,
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

class _Footer extends StatelessWidget {
  const _Footer();

  @override
  Widget build(BuildContext context) {
    final scroller = SectionScroller.of(context);
    final style = AppTextStyles.body(size: 13, color: AppColors.textFaint);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 28),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.border)),
      ),
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 24,
        runSpacing: 12,
        children: [
          Text('© ${DateTime.now().year} Jatin Chaudhary', style: style),
          Text('Designed & built from scratch in Flutter', style: style),
          HoverBuilder(
            onTap: () => scroller.goTo(null),
            builder:
                (context, hovered) => Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Back to top',
                      style: style.copyWith(
                        color: hovered ? AppColors.text : AppColors.textFaint,
                      ),
                    ),
                    const SizedBox(width: 6),
                    AnimatedSlide(
                      duration: const Duration(milliseconds: 220),
                      offset: hovered ? const Offset(0, -0.2) : Offset.zero,
                      child: Icon(
                        Icons.north,
                        size: 13,
                        color: hovered ? AppColors.accent : AppColors.textFaint,
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
