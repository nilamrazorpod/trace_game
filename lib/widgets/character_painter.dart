// import 'dart:math';
// import 'package:flutter/material.dart';
// import '../utils/enums.dart';
//
// class CharacterPainter extends CustomPainter {
//   final Path charPath;
//   final Rect strokeGuide;
//   final List<Offset?> tracePoints;
//   final String mainChar;
//   final Script script;
//   final bool fillChar;
//
//   CharacterPainter(
//       this.charPath,
//       this.strokeGuide,
//       this.tracePoints,
//       this.mainChar,
//       this.script,
//       this.fillChar,
//       );
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     final textPainter = TextPainter(
//       text: TextSpan(
//         text: mainChar,
//         style: TextStyle(
//           fontSize: size.height * 1.1,
//           color: Colors.grey.withOpacity(0.3),
//           fontWeight: FontWeight.w900,
//           height: 1,
//         ),
//       ),
//       textAlign: TextAlign.center,
//       textDirection: TextDirection.ltr,
//     )..layout();
//
//     textPainter.paint(
//       canvas,
//       Offset((size.width - textPainter.width) / 2, (size.height - textPainter.height) / 2),
//     );
//
//     Paint pathPaint = Paint()
//       ..color = Colors.grey.withOpacity(0.3)
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = size.height * 0.09
//       ..strokeCap = StrokeCap.round;
//
//     canvas.drawPath(charPath, pathPaint);
//
//     if (tracePoints.isNotEmpty) {
//       Paint tracePaint = Paint()
//         ..color = Colors.green
//         ..strokeWidth = size.height * 0.09
//         ..strokeCap = StrokeCap.round;
//
//       for (int i = 0; i < tracePoints.length - 1; i++) {
//         if (tracePoints[i] != null && tracePoints[i + 1] != null) {
//           canvas.drawLine(tracePoints[i]!, tracePoints[i + 1]!, tracePaint);
//         }
//       }
//
//       final last = tracePoints.lastWhere((e) => e != null, orElse: () => null);
//       if (last != null) {
//         canvas.drawCircle(last, size.height * 0.045, Paint()..color = Colors.black.withOpacity(0.3));
//         canvas.drawCircle(last, size.height * 0.028, Paint()..color = Colors.white);
//         canvas.drawCircle(last, size.height * 0.017, Paint()..color = Colors.black87);
//       }
//     }
//   }
//
//   @override
//   bool shouldRepaint(covariant CharacterPainter oldDelegate) =>
//       oldDelegate.tracePoints != tracePoints ||
//           oldDelegate.mainChar != mainChar ||
//           oldDelegate.script != script ||
//           oldDelegate.fillChar != fillChar;
// }
//
// class DashedArrowPainter extends CustomPainter {
//   final Offset start;
//   final Offset end;
//
//   DashedArrowPainter({required this.start, required this.end});
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     const dashWidth = 6.0;
//     const dashSpace = 5.0;
//     final paint = Paint()
//       ..color = Colors.black54
//       ..strokeWidth = 2
//       ..style = PaintingStyle.stroke;
//
//     final dx = end.dx - start.dx;
//     final dy = end.dy - start.dy;
//     final distance = sqrt(dx * dx + dy * dy);
//     final steps = (distance / (dashWidth + dashSpace)).floor();
//
//     for (int i = 0; i < steps; i++) {
//       final x1 = start.dx + (dx * i / steps);
//       final y1 = start.dy + (dy * i / steps);
//       final x2 = start.dx + (dx * (i + 0.5) / steps);
//       final y2 = start.dy + (dy * (i + 0.5) / steps);
//       canvas.drawLine(Offset(x1, y1), Offset(x2, y2), paint);
//     }
//
//     const arrowSize = 10.0;
//     final angle = atan2(dy, dx);
//     final arrowP1 = Offset(
//       end.dx - arrowSize * cos(angle - 0.4),
//       end.dy - arrowSize * sin(angle - 0.4),
//     );
//     final arrowP2 = Offset(
//       end.dx - arrowSize * cos(angle + 0.4),
//       end.dy - arrowSize * sin(angle + 0.4),
//     );
//     canvas.drawLine(end, arrowP1, paint);
//     canvas.drawLine(end, arrowP2, paint);
//   }
//
//   @override
//   bool shouldRepaint(covariant DashedArrowPainter oldDelegate) => false;
// }
