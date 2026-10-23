import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:jatinchaudhary/sections/section1_cover/cover_section.dart';
import 'package:jatinchaudhary/sections/section2_about/about_section.dart';
import 'package:jatinchaudhary/sections/section3_experience/experience_section.dart';
import 'package:jatinchaudhary/sections/section4_skills/skils_section.dart';
import 'package:jatinchaudhary/sections/section5_work/work_section.dart';
import 'package:jatinchaudhary/sections/section6_connect/connect_section.dart';
import 'package:jatinchaudhary/utils/app_text_styles.dart';
import 'package:jatinchaudhary/utils/links.dart';
import 'package:jatinchaudhary/widgets/common.dart';
import 'package:web_smooth_scroll/web_smooth_scroll.dart';

enum SectionId {
  about('About'),
  experience('Experience'),
  skills('Skills'),
  work('Work'),
  contact('Contact');

  const SectionId(this.label);
  final String label;
}

/// Lets any widget on the page scroll to a section (or to the top with null).
class SectionScroller extends InheritedWidget {
  const SectionScroller({super.key, required this.goTo, required super.child});

  final void Function(SectionId? id) goTo;

  static SectionScroller of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<SectionScroller>()!;

  @override
  bool updateShouldNotify(SectionScroller oldWidget) => goTo != oldWidget.goTo;
}

class Sections extends StatefulWidget {
  const Sections({super.key});

  @override
  State<Sections> createState() => _SectionsState();
}

class _SectionsState extends State<Sections> {
  final ScrollController _scrollController = ScrollController();
  final Map<SectionId, GlobalKey> _keys = {
    for (final id in SectionId.values) id: GlobalKey(),
  };

  static const _scrollDuration = Duration(milliseconds: 1100);

  void _goTo(SectionId? id) {
    if (id == null) {
      _scrollController.animateTo(
        0,
        duration: _scrollDuration,
        curve: Curves.easeInOutCubic,
      );
      return;
    }
    final target = _keys[id]!.currentContext;
    if (target == null) return;
    Scrollable.ensureVisible(
      target,
      duration: _scrollDuration,
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SectionScroller(
        goTo: _goTo,
        // Smooth scrolling wraps the nav too, so the wheel still scrolls the
        // page while the pointer is over the bar.
        child: WebSmoothScroll(
          scrollSpeed: 1,
          controller: _scrollController,
          child: Stack(
            children: [
              SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const CoverSection(),
                    AboutSection(key: _keys[SectionId.about]),
                    ExperienceSection(key: _keys[SectionId.experience]),
                    SkillsSection(key: _keys[SectionId.skills]),
                    WorkSection(key: _keys[SectionId.work]),
                    ConnectSection(key: _keys[SectionId.contact]),
                  ],
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: _NavBar(controller: _scrollController, keys: _keys),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavBar extends StatefulWidget {
  const _NavBar({required this.controller, required this.keys});

  final ScrollController controller;
  final Map<SectionId, GlobalKey> keys;

  @override
  State<_NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<_NavBar> {
  bool _scrolled = false;
  SectionId? _active;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onScroll);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onScroll);
    super.dispose();
  }

  void _onScroll() {
    final scrolled = widget.controller.offset > 24;

    // The active section is the last one whose top has passed a line a third
    // of the way down the viewport.
    final line = MediaQuery.sizeOf(context).height / 3;
    SectionId? active;
    for (final id in SectionId.values) {
      final box =
          widget.keys[id]!.currentContext?.findRenderObject() as RenderBox?;
      if (box == null || !box.attached) continue;
      if (box.localToGlobal(Offset.zero).dy <= line) active = id;
    }

    if (scrolled != _scrolled || active != _active) {
      setState(() {
        _scrolled = scrolled;
        _active = active;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final mobile = Breakpoints.isMobile(context);
    final scroller = SectionScroller.of(context);

    final bar = AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: mobile ? 64 : 76,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: _scrolled ? const Color(0xB8000000) : const Color(0x00000000),
        border: Border(
          bottom: BorderSide(
            color: _scrolled ? AppColors.border : Colors.transparent,
          ),
        ),
      ),
      child: ContentWidth(
        child: Row(
          children: [
            HoverBuilder(
              onTap: () => scroller.goTo(null),
              builder:
                  (context, hovered) => Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Jatin Chaudhary',
                          style: AppTextStyles.display(
                            size: 24,
                            color: hovered ? AppColors.accent : AppColors.text,
                          ),
                        ),
                        TextSpan(
                          text: '.',
                          style: AppTextStyles.display(
                            size: 24,
                            color: AppColors.accent,
                          ),
                        ),
                      ],
                    ),
                  ),
            ),
            const Spacer(),
            if (!mobile) ...[
              for (final id in SectionId.values)
                _NavLink(
                  label: id.label,
                  active: id == _active,
                  onTap: () => scroller.goTo(id),
                ),
              const SizedBox(width: 20),
            ],
            PillButton(
              label: 'Resume',
              trailing: Icons.north_east,
              compact: true,
              onTap: () => Links.open(Links.resume),
            ),
          ],
        ),
      ),
    );

    if (!_scrolled) return bar;
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: bar,
      ),
    );
  }
}

class _NavLink extends StatelessWidget {
  const _NavLink({
    required this.label,
    required this.active,
    required this.onTap,
  });

  final String label;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return HoverBuilder(
      onTap: onTap,
      builder: (context, hovered) {
        final highlighted = active || hovered;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 200),
                style: AppTextStyles.body(
                  size: 13.5,
                  height: 1.2,
                  color: highlighted ? AppColors.text : AppColors.textMuted,
                ),
                child: Text(label),
              ),
              const SizedBox(height: 6),
              AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                width: active ? 4 : 0,
                height: 4,
                decoration: const BoxDecoration(
                  color: AppColors.accent,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
