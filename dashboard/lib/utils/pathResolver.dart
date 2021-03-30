import 'dart:io';

import 'package:path_provider/path_provider.dart';

const String appName = "c19pm";

Future<String> getDocDirectory() async {
  String _docDirectory = (await getApplicationDocumentsDirectory()).path;
  if (Platform.isWindows) {
    return "$_docDirectory\\c19pm\\"; 
  }
  return "$_docDirectory/c19pm/";
}

Future<String> getJsonFolder() async {
  String doc = await getDocDirectory();
  if (Platform.isWindows) {
    return doc+"json\\";
  }
  return doc+"json/";
}

Future<String> getImgFolder() async {
  String doc = await getDocDirectory();
  return doc+"img/";
}

Future<String> getXMLFolder() async {
  String doc = await getDocDirectory();
  if (Platform.isWindows) {
    return doc+"xml\\";
  }
  return doc+"xml/";
}
