import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';

class TraceScreen extends StatefulWidget {
  const TraceScreen({super.key});
  @override
  State<TraceScreen> createState() => _TraceScreenState();
}

class _TraceScreenState extends State<TraceScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _progress;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: false);
    _progress = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final size = Size(constraints.maxWidth * 0.7, constraints.maxWidth * 0.7);
            return Stack(
              children: [
                // Character and stroke painter
                CustomPaint(
                  size: size,
                  painter: CharacterTracePainter(_progress),
                ),
                // Animated pen indicator
                AnimatedBuilder(
                  animation: _progress,
                  builder: (context, child) {
                    final penOffset = _penPositionOnPath(size, _progress.value);
                    return Positioned(
                      left: penOffset.dx - 16,
                      top: penOffset.dy - 16,
                      child: _PenWidget(),
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  // Returns the Offset of the pen along the tracing path
  Offset _penPositionOnPath(Size size, double t) {
    // Path for "あ" (simplified for demonstration)
    final center = Offset(size.width * 0.5, size.height * 0.6);
    final radius = size.width * 0.28;
    // We'll move the pen along an arc (the lower loop of "あ")
    final angle = lerpDouble(-pi / 2, 3 * pi / 2, t)!;
    final dx = center.dx + radius * cos(angle);
    final dy = center.dy + radius * sin(angle);
    return Offset(dx, dy);
  }
}

class _PenWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Dashed arrow (optional)
        CustomPaint(
          size: const Size(40, 40),
          painter: DashedArrowPainter(),
        ),
        // Pen (gray circle)
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: Colors.grey[800],
            shape: BoxShape.circle,
            border: Border.all(color: Colors.grey[400]!, width: 3),
          ),
        ),
      ],
    );
  }
}


class CharacterTracePainter extends CustomPainter {
  final Animation<double> progress;
  CharacterTracePainter(this.progress) : super(repaint: progress);

  @override
  void paint(Canvas canvas, Size size) {
    // Draw light gray background character
    final textPainter = TextPainter(
      text: const TextSpan(
        text: 'あ',
        style: TextStyle(
          fontSize: 220,
          color: Color(0xFFB0B0B0),
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    )..layout(maxWidth: size.width);
    textPainter.paint(
      canvas,
      Offset((size.width - textPainter.width) / 2, (size.height - textPainter.height) / 2),
    );

    // Draw green stroke (vertical and horizontal lines for "あ")
    final paint = Paint()
      ..color = Colors.green
      ..strokeWidth = 24
      ..strokeCap = StrokeCap.square;

    // Horizontal bar
    canvas.drawLine(
      Offset(size.width * 0.18, size.height * 0.25),
      Offset(size.width * 0.82, size.height * 0.25),
      paint,
    );
    // Vertical bar
    canvas.drawLine(
      Offset(size.width * 0.5, size.height * 0.25),
      Offset(size.width * 0.5, size.height * 0.75),
      paint,
    );

    // Draw gray arc (lower loop)
    final arcPaint = Paint()
      ..color = Colors.grey.withOpacity(0.4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 20;
    final center = Offset(size.width * 0.5, size.height * 0.6);
    final radius = size.width * 0.28;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      2 * pi,
      false,
      arcPaint,
    );

    // Draw green arc for animated progress
    final greenArcPaint = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.stroke
      ..strokeWidth = 20;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      2 * pi * progress.value,
      false,
      greenArcPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CharacterTracePainter oldDelegate) => true;
}


class DashedArrowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey[600]!
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    final path = Path();
    path.moveTo(20, 0);
    path.lineTo(20, 32);

    // Draw dashed line
    double dashWidth = 4, dashSpace = 4, startY = 0;
    while (startY < 32) {
      canvas.drawLine(
        Offset(20, startY),
        Offset(20, startY + dashWidth),
        paint,
      );
      startY += dashWidth + dashSpace;
    }

    // Draw arrow head
    final arrowPath = Path();
    arrowPath.moveTo(16, 28);
    arrowPath.lineTo(20, 36);
    arrowPath.lineTo(24, 28);
    canvas.drawPath(arrowPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
