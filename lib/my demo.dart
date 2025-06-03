import 'package:flutter/material.dart';

class TraceGameDemo extends StatefulWidget {
  final String selectedWord;
  final String script;

  const TraceGameDemo({
    super.key,
    required this.selectedWord,
    required this.script,
  });

  @override
  State<TraceGameDemo> createState() => _TraceGameDemoState();
}

class _TraceGameDemoState extends State<TraceGameDemo> {
  List<Offset?> points = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ... your AppBar and other widgets ...
      body: Column(
        children: [
          // ... other UI elements ...
          Expanded(
            child: Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Faded selected word
                  Opacity(
                    opacity: 0.15,
                    child: Text(
                      widget.selectedWord,
                      style: TextStyle(fontSize: 220, color: Colors.black),
                    ),
                  ),
                  // Drawing layer
                  GestureDetector(
                    onPanUpdate: (details) {
                      RenderBox? box = context.findRenderObject() as RenderBox?;
                      if (box != null) {
                        Offset localPosition = box.globalToLocal(details.globalPosition);
                        setState(() {
                          points = List.from(points)..add(localPosition);
                        });
                      }
                    },
                    onPanEnd: (details) {
                      setState(() {
                        points.add(null);
                      });
                    },
                    child: CustomPaint(
                      size: Size(220, 220),
                      painter: TracePainter(points: points),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // ... answer choices and Check button ...
        ],
      ),
    );
  }
}

class TracePainter extends CustomPainter {
  final List<Offset?> points;
  TracePainter({required this.points});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.deepPurple
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 8.0;
    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i]!, points[i + 1]!, paint);
      }
    }
  }

  @override
  bool shouldRepaint(TracePainter oldDelegate) => oldDelegate.points != points;
}

