import 'package:flutter/material.dart';




class FirstSectionBg extends StatelessWidget {
  const FirstSectionBg({super.key});

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
      _Circle(Offset(-50, size.height * 0.5), 220, const Color.fromARGB(255, 12, 84, 117).withOpacity(isNarrow ? 0 : 0.2)),
      _Circle(Offset(isNarrow ? size.width * 0.1 : size.width * 0.7, isNarrow ? size.height*0.6 : size.height * 0.4), 200, const Color.fromARGB(255, 6, 57, 49).withOpacity(0.2)),
      _Circle(Offset(size.width * 0.5, size.height * 0.8), 120, const Color.fromARGB(255, 53, 32, 89).withOpacity(0.2)),
    ];
    for (final circle in circles) {
      final paint = Paint()
        ..color = circle.color
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 40);
      canvas.drawCircle(circle.offset, circle.radius, paint);
    }

    // Draw dot pattern at box corners
    final dotPaint = Paint()..color = const Color.fromRGBO(78, 76, 76, 1).withOpacity(0.2);
    const dotRadius = 1.5;
    const boxSize = 80.0;
    for (double x = 0; x < size.width; x += boxSize) {
      for (double y = 0; y < size.height; y += boxSize) {
        // Four corners of each box
        canvas.drawCircle(Offset(x, y), dotRadius, dotPaint);
        if (x + boxSize < size.width)
          canvas.drawCircle(Offset(x + boxSize, y), dotRadius, dotPaint);
        if (y + boxSize < size.height)
          canvas.drawCircle(Offset(x, y + boxSize), dotRadius, dotPaint);
        if (x + boxSize < size.width && y + boxSize < size.height)
          canvas.drawCircle(Offset(x + boxSize, y + boxSize), dotRadius, dotPaint);
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
