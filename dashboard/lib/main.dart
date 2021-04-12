import 'dart:io';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:covid19_progression_modeler/config/config.dart';
import 'package:covid19_progression_modeler/redux/AppState.dart';
import 'package:covid19_progression_modeler/redux/middleware.dart';
import 'package:covid19_progression_modeler/redux/reducers/reducers.dart';
import 'package:covid19_progression_modeler/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:window_size/window_size.dart';
// import 'package:redux/redux.dart';
// import 'package:flutter_redux_dev_tools/flutter_redux_dev_tools.dart';
import 'package:redux_dev_tools/redux_dev_tools.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    setWindowTitle('COVID19 Progression Modeler');
  }
  runApp(MyApp());
  doWhenWindowReady(() {
    final win = appWindow;
    win.minSize = Size(1000, 650);
  });
}

class MyApp extends StatelessWidget {
  // final Store<AppState> _store = Store<AppState>(
  //   appStateReducer,
  //   initialState: AppState.initialState(),
  //   middleware: [
  //     appStateMiddleware,
  //   ],
  // );

  final DevToolsStore<AppState> _store = DevToolsStore<AppState>(
    appStateReducer,
    initialState: AppState.initialState(),
    middleware: [
      appStateMiddleware,
    ],
  );

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: _store,
      child: MaterialApp(
        title: 'COVID19 Progression Modeler',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            scaffoldBackgroundColor: Palette.primeColor),
        home: LoginScreen(),
        localizationsDelegates: [GlobalMaterialLocalizations.delegate],
        supportedLocales: [const Locale('en'), const Locale('fr')],
      ),
    );
  }
}
