import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui' as ui;

void capture(GlobalKey key) async {
  if (key == null) return null;

  RenderRepaintBoundary boundary = key.currentContext.findRenderObject();
  final image = await boundary.toImage(pixelRatio: 3);
  final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
  final pngBytes = byteData.buffer.asByteData();

  writeToFile(pngBytes, "/home/ssmm0498/Documents/$key.png");
}

Future<void> writeToFile(ByteData data, String path) {
  final buffer = data.buffer;
  return new File(path)
      .writeAsBytes(buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
}

void export(GlobalKey key) {
  capture(key);
}
