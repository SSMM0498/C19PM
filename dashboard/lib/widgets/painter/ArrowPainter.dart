import 'package:arrow_path/arrow_path.dart';
import 'package:covid19_progression_modeler/models/models.dart';
import 'package:covid19_progression_modeler/utils/sizeHelper.dart';
import 'package:flutter/material.dart';

class ArrowPainter extends CustomPainter {
  final ArrowParam arrowParam;
  final scaleFactor = SizeHelper.width() / 850 * SizeHelper.height() / 950;

  ArrowPainter({this.arrowParam});

  @override
  void paint(Canvas canvas, Size size) {
    TextSpan textSpan;
    TextPainter textPainter;
    Path path;

    // The arrows usually looks better with rounded caps.
    Paint paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..strokeWidth = 3.0;

    /// Draw a single arrow.
    path = Path();
    path.moveTo(
      this.arrowParam.start.x * scaleFactor,
      this.arrowParam.start.y * scaleFactor,
    );
    path.lineTo(
      this.arrowParam.end.x * scaleFactor,
      this.arrowParam.end.y * scaleFactor,
    );
    path = ArrowPath.make(path: path);
    canvas.drawPath(path, paint..color = Colors.blue);

    textSpan = TextSpan(
      text: this.arrowParam.date,
      style: TextStyle(
        fontSize: 15,
        color: Colors.black,
      ),
    );
    textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(minWidth: size.width);
    double textX = (this.arrowParam.start.x * scaleFactor +
            this.arrowParam.end.x * scaleFactor -
            140) /
        2;
    double textY = (this.arrowParam.start.y * scaleFactor +
            this.arrowParam.end.y * scaleFactor -
            10) /
        2;
    textPainter.paint(canvas, Offset(textX, textY));
  }

  @override
  bool shouldRepaint(ArrowPainter oldDelegate) => true;
}
