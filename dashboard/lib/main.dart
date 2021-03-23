import 'dart:io';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:covid19_progression_modeler/config/config.dart';
import 'package:covid19_progression_modeler/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:window_size/window_size.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    setWindowTitle('COVID19 Progression Modeler');
  }
  runApp(MyApp());
  doWhenWindowReady(() {
    final win = appWindow;
    win.minSize = Size(1000, 650);
    win.alignment = Alignment.center;
    win.show();
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'COVID19 Progression Modeler',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          scaffoldBackgroundColor: Palette.primeColor),
      home: HomeScreen(),
    );
  }
}
