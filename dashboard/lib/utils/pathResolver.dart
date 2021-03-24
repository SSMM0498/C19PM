import 'dart:io';

import 'package:path_provider/path_provider.dart';

const String appName = "c19pm";

Future<String> getDocDirectory() async {
  String _docDirectory = (await getApplicationDocumentsDirectory()).path;
  if (Platform.isWindows) {
    return "$_docDirectory\\c19pm\\";
  } else if (Platform.isLinux || Platform.isMacOS) {
    return "$_docDirectory/c19pm/";
  }
  return "";
}

Future<String> getJsonFolder() async {
  String doc = await getDocDirectory();
  if (Platform.isWindows) {
    return doc+"json\\";
  } else if (Platform.isLinux || Platform.isMacOS) {
    return doc+"json/";
  }
  return "";
}

Future<String> getXMLFolder() async {
  String doc = await getDocDirectory();
  if (Platform.isWindows) {
    return doc+"xml\\";
  } else if (Platform.isLinux || Platform.isMacOS) {
    return doc+"xml/";
  }
  return "";
}
