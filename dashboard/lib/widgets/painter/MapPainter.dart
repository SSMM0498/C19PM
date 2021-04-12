import 'package:flutter/material.dart';
import 'package:touchable/touchable.dart';

import 'package:covid19_progression_modeler/config/config.dart';
import 'package:covid19_progression_modeler/models/models.dart';

import '../popup/Popup.dart';

class MapPainter extends CustomPainter {
  final bool havePopup;
  final bool withArrow;
  final BuildContext context;
  List<LocalityMapInfos> listMapInfos;
  final Path curPath;
  final List<Locality> localities;
  final Function(Path curPath) onPressed;
  MapPainter({
    this.havePopup,
    this.withArrow,
    this.context,
    this.listMapInfos,
    this.curPath,
    this.localities,
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

    listMapInfos.forEach((i) {
      paint.style =
          i.path == curPath ? PaintingStyle.fill : PaintingStyle.stroke;
      touchCanvas.drawPath(
        i.path.transform(matrix4.storage),
        paint,
        onTapDown: (details) {
          String city = i.name;
          onPressed(i.path);
          if (havePopup && !withArrow) {
            print("clicked on $city");
            List<Departement> deps = (localities as List<Region>)
                .firstWhere((r) => r.localityName == city)
                .departements;
            return showDialog(
              context: context,
              builder: (ctx) => Popup(
                city: city,
                context: ctx,
                deps: deps,
              ),
            );
          }
        },
      );
    });
  }

  @override
  bool shouldRepaint(MapPainter oldDelegate) => true;
}
