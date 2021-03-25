import 'package:covid19_progression_modeler/config/config.dart';
import 'package:covid19_progression_modeler/models/models.dart';
import 'package:flutter/material.dart';
import 'package:touchable/touchable.dart';

import '../Popup.dart';

class MapPainter extends CustomPainter {
  final bool havePopup;
  final BuildContext context;
  final Map<String, Path> paths;
  final Path curPath;
  final List<Locality> localities;
  final Function(Path curPath) onPressed;
  MapPainter({
    this.context,
    this.paths,
    this.localities,
    this.curPath,
    this.havePopup,
    this.onPressed,
  });

  @override
  void paint(Canvas canvas, Size size) {
    double scale =
        (havePopup) ? SizeHelper.width() / 850 * SizeHelper.height() / 950 : 1;

    // scale each path to match canvas size
    final Matrix4 matrix4 = Matrix4.identity();
    matrix4.scale(scale, scale);

    final TouchyCanvas touchCanvas = TouchyCanvas(context, canvas);

    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..color = Palette.lightSecondColor
      ..strokeWidth = 1.5;

    paths.forEach((title, path) {
      paint.style = path == curPath ? PaintingStyle.fill : PaintingStyle.stroke;
      touchCanvas.drawPath(
        path.transform(matrix4.storage),
        paint,
        onTapDown: (details) {
          String city = title;
          onPressed(path);
          if (havePopup) {
            List<Departement> deps = (localities as List<Region>)
                .firstWhere((r) => r.name == city)
                .departements;
            return showDialog(
              context: context,
              builder: (ctx) => Popup(city: city, context: ctx, deps: deps),
            );
          }
        },
      );
    });
  }

  @override
  bool shouldRepaint(MapPainter oldDelegate) => true;
}