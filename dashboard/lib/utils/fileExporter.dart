import 'dart:io';
import 'dart:typed_data';
import 'package:covid19_progression_modeler/utils/pathResolver.dart' as pr;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui' as ui;

void capture(String filename, GlobalKey key) async {
  if (key == null) return null;

  RenderRepaintBoundary boundary = key.currentContext.findRenderObject();
  final image = await boundary.toImage(pixelRatio: 3);
  final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
  final pngBytes = byteData.buffer.asByteData();
  String doc = await pr.getImgFolder();

  writeToFile(pngBytes, doc + "$filename.png");
}

Future<void> writeToFile(ByteData data, String path) {
  final buffer = data.buffer;
  return new File(path)
      .writeAsBytes(buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
}

void export({String name, GlobalKey key}) {
  String date = DateTime.now().toIso8601String();
  String fname = "$name $date";
  capture(fname, key);
}
