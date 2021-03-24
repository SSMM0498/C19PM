import 'package:path_provider/path_provider.dart';

const String appName = "c19pm";

Future<String> getDocDirectory() async {
  String _docDirectory = (await getApplicationDocumentsDirectory()).path;
  return "$_docDirectory/c19pm/";
}

Future<String> getJsonFolder() async {
  String doc = await getDocDirectory();
  return doc+"json/";
}

Future<String> getXMLFolder() async {
  String doc = await getDocDirectory();
  return doc+"xml/";
}
