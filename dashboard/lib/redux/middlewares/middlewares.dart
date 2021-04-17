// import './middlewares.dart' as monthStateMiddleware;

import 'package:covid19_progression_modeler/redux/AppState.dart';
import 'package:covid19_progression_modeler/redux/middlewares/regions.middleware.dart';
import 'package:covid19_progression_modeler/redux/middlewares/month.middleware.dart';
import 'package:redux/redux.dart';

const List<
        dynamic Function(Store<AppState>, dynamic, dynamic Function(dynamic))>
    middlewares = [
  monthStateMiddleware,
  regionsMiddleware,
];
