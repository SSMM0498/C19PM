import 'dart:io';
import 'dart:typed_data';
import 'package:covid19_progression_modeler/models/models.dart';
import 'package:covid19_progression_modeler/utils/pathResolver.dart' as pr;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui' as ui;
import 'package:csv/csv.dart';

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
  if (Platform.isWindows) {
    fname = fname.replaceAll(" ", "_");
    fname = fname.replaceAll(":", "-");
  }
  capture(fname, key);
}

Future<File> generateCountryCSV(List<dynamic> data, String filename) async {
  try {
    List<List<String>> csvData = [
      <String>['region', 'nombre de cas'],
      ...data.map((region) => [region.getName(), region.getNbCase()])
    ];
    String csv = const ListToCsvConverter().convert(csvData);
    print(csv);
    String doc = await pr.getCSVFolder();
    String path = '$doc\ $filename';
    final File csvFile = new File(path);

    return await csvFile.writeAsString(csv);
  } catch (e) {
    print(e);
    return null;
  }
}
