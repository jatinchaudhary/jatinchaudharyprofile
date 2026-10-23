import 'package:flutter/material.dart';
import 'package:jatinchaudhary/utils/app_text_styles.dart';
import 'package:jatinchaudhary/widgets/common.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  static const _paragraphs = [
    "I'm a software engineer with 5+ years of experience building production "
        "systems in real-money gaming, quick-commerce and consumer AI. "
        "Currently SDE-II at Junglee Games, I architected the backend for a UK "
        "raffle platform that reached 120K+ users within 97 days, and I own "
        "the deposit stack on Junglee Rummy, where custom UPI and CVV-less "
        "payments lifted transaction success by 30%.",
    "Previously, as tech lead at Hexon Global, I led four engineers building "
        "event-driven Spring Boot and Kafka services for a quick-commerce "
        "platform. I have also built two AI products end-to-end, covering "
        "multi-agent LLM orchestration and real-time player profiling.",
  ];

  static const _stats = [
    ('5+', 'Years shipping production systems'),
    ('120K+', 'Users on a platform built in 97 days'),
    ('30%', 'Lift in payment success rate'),
    ('4', 'Engineers led as tech lead'),
  ];

  @override
  Widget build(BuildContext context) {
    return SectionShell(
      number: '01',
      label: 'About',
      title:
          'I build backend systems and mobile products that hold up '
          '*under real-world load.*',
      child: LayoutBuilder(
        builder: (context, constraints) {
          final wide = constraints.maxWidth >= 860;
          final paragraphs = [
            for (int i = 0; i < _paragraphs.length; i++)
              Reveal(
                delay: Duration(milliseconds: 100 * i),
                child: Text(
                  _paragraphs[i],
                  style: AppTextStyles.body(size: 16.5, height: 1.8),
                ),
              ),
          ];

          final statWidth =
              wide
                  ? (constraints.maxWidth - 3 * 32) / 4
                  : (constraints.maxWidth - 24) / 2;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              wide
                  ? Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: paragraphs[0]),
                      const SizedBox(width: 56),
                      Expanded(child: paragraphs[1]),
                    ],
                  )
                  : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      paragraphs[0],
                      const SizedBox(height: 24),
                      paragraphs[1],
                    ],
                  ),
              SizedBox(height: wide ? 96 : 64),
              Wrap(
                spacing: wide ? 32 : 24,
                runSpacing: 40,
                children: [
                  for (int i = 0; i < _stats.length; i++)
                    SizedBox(
                      width: statWidth,
                      child: Reveal(
                        delay: Duration(milliseconds: 90 * i),
                        child: _Stat(value: _stats[i].$1, label: _stats[i].$2),
                      ),
                    ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat({required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 24),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.borderStrong)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: AppTextStyles.display(size: fluid(context, 48, 72)),
          ),
          const SizedBox(height: 12),
          Text(label, style: AppTextStyles.body(size: 14, height: 1.5)),
        ],
      ),
    );
  }
}
