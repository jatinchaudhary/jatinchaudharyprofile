import 'dart:math';
import 'package:flutter/material.dart';

class DashedBorderBox extends StatefulWidget {
  const DashedBorderBox({super.key, required this.child});

  final Widget child;

  @override
  State<DashedBorderBox> createState() => _DashedBorderBoxState();
}

class _DashedBorderBoxState extends State<DashedBorderBox> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: _DashedBorderPainter(phase: _controller.value),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 1, vertical: 1),
            child: widget.child,
          ),
        );
      },
    );
  }
}

class _DashedBorderPainter extends CustomPainter {
  final double dashWidth;
  final double dashSpace;
  final double strokeWidth;
  final Color borderColor;
  final double phase;

  _DashedBorderPainter({
    required this.phase,
  })  : dashWidth = 10,
        dashSpace = 5,
        strokeWidth = 2,
        borderColor = const Color.fromARGB(255, 50, 110, 164);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    // Create gradient that fades left → right
    final shader = LinearGradient(
      begin: Alignment.centerRight,
      end: Alignment.centerLeft,
      colors: [borderColor, borderColor.withOpacity(0)],
    ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    paint.shader = shader;

    // Top border (dashed with fade)
    _drawDashedLine(
      canvas,
      Offset(0, 0),
      Offset(size.width, 0),
      paint,
      phase,
    );

    // Bottom border (dashed with fade)
    _drawDashedLine(
      canvas,
      Offset(0, size.height),
      Offset(size.width, size.height),
      paint,
      phase,
    );

    // Right border (solid dashed, no fade)
    _drawDashedLine(
      canvas,
      Offset(size.width, 0),
      Offset(size.width, size.height),
      paint..shader = null..color = borderColor,
      phase,
    );

    // Left border (solid dashed, no fade)
    // _drawDashedLine(
    //   canvas,
    //   Offset(0, 0),
    //   Offset(0, size.height),
    //   paint..shader = null..color = borderColor,
    //   phase,
    // );
  }

  void _drawDashedLine(Canvas canvas, Offset start, Offset end, Paint paint, double phase) {
    double dx = end.dx - start.dx;
    double dy = end.dy - start.dy;
    double distance = sqrt(dx * dx + dy * dy);
    int dashCount = distance ~/ (dashWidth + dashSpace);

    double xStep = dx / distance * (dashWidth + dashSpace);
    double yStep = dy / distance * (dashWidth + dashSpace);

    // Animate dashes by shifting start position
    double offset = phase * (dashWidth + dashSpace);

    for (int i = 0; i < dashCount; i++) {
      final x1 = start.dx + i * xStep + dx / distance * offset;
      final y1 = start.dy + i * yStep + dy / distance * offset;

      final x2 = x1 + dx / distance * dashWidth;
      final y2 = y1 + dy / distance * dashWidth;

      // Only draw dashes within the line
      if ((dx == 0 && (y1 <= end.dy && y2 <= end.dy)) || (dy == 0 && (x1 <= end.dx && x2 <= end.dx)) || (dx != 0 && dy != 0)) {
        canvas.drawLine(Offset(x1, y1), Offset(x2, y2), paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _DashedBorderPainter oldDelegate) => oldDelegate.phase != phase;
}
