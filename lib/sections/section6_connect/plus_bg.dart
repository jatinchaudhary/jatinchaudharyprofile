import 'package:flutter/material.dart';


class PlusBg extends StatelessWidget {
  const PlusBg({super.key});

  @override
  Widget build(BuildContext context) {
     bool isNarrow = MediaQuery.of(context).size.width < 600;
    return Positioned.fill(
            child: CustomPaint(
              painter: _BlurredCirclesPainter(isNarrow),
            ),
          );
  }
}



class _BlurredCirclesPainter extends CustomPainter {
  final bool isNarrow;

  _BlurredCirclesPainter(this.isNarrow);

  @override
  void paint(Canvas canvas, Size size) {
    // Draw blurred circles
    final circles = [
      _Circle(Offset(isNarrow ? 10 : 400 , size.height * 0.5), 320, const Color.fromARGB(11, 12, 84, 117).withOpacity(isNarrow ? 0.15 : 0.2)),
      _Circle(Offset(isNarrow ? size.width * 0.1 : size.width * 0.7, isNarrow ? size.height*0.6 : size.height * 0.4), 200, const Color.fromARGB(255, 6, 57, 49).withOpacity(0.2)),
      _Circle(Offset(size.width * 0.5, size.height * 0.8), 120, const Color.fromARGB(255, 53, 32, 89).withOpacity(0.2)),
    ];
    for (final circle in circles) {
      final paint = Paint()
        ..color = circle.color
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 80);
      canvas.drawCircle(circle.offset, circle.radius, paint);
    }

    // Draw plus (+) pattern at box corners
    final plusPaint = Paint()
      ..color = const Color.fromARGB(11, 39, 39, 39).withOpacity(0.2)
      ..strokeWidth = 1.2
      ..strokeCap = StrokeCap.round;
    const plusSize = 6.0;
    const boxSize = 80.0;
    for (double x = 0; x < size.width; x += boxSize) {
      for (double y = 0; y < size.height; y += boxSize) {
      final points = [
        Offset(x, y),
        if (x + boxSize < size.width) Offset(x + boxSize, y),
        if (y + boxSize < size.height) Offset(x, y + boxSize),
        if (x + boxSize < size.width && y + boxSize < size.height) Offset(x + boxSize, y + boxSize),
      ];
      for (final center in points) {
        // Draw vertical line
        canvas.drawLine(
        Offset(center.dx, center.dy - plusSize / 2),
        Offset(center.dx, center.dy + plusSize / 2),
        plusPaint,
        );
        // Draw horizontal line
        canvas.drawLine(
        Offset(center.dx - plusSize / 2, center.dy),
        Offset(center.dx + plusSize / 2, center.dy),
        plusPaint,
        );
      }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _Circle {
  final Offset offset;
  final double radius;
  final Color color;
  _Circle(this.offset, this.radius, this.color);
  }
