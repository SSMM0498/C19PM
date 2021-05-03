import 'dart:ui';

import 'package:covid19_progression_modeler/redux/AppState.dart';
import 'package:covid19_progression_modeler/redux/viewModel/ViewModel.dart';
import 'package:covid19_progression_modeler/widgets/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:covid19_progression_modeler/config/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux_dev_tools/flutter_redux_dev_tools.dart';
import 'package:redux/redux.dart';
import 'package:redux_dev_tools/redux_dev_tools.dart';

class HomeScreen extends StatelessWidget {
  final DevToolsStore<AppState> store;
  HomeScreen({this.store});

  @override
  Widget build(BuildContext context) {
    SizeHelper.getScreenSize(context);
    return Scaffold(
      body: StoreConnector<AppState, ViewModel>(
        converter: (Store<AppState> store) => ViewModel.create(store),
        builder: (BuildContext context, ViewModel viewModel) => backGround(
          Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Container(
                width: SizeHelper.width() * 0.05,
                height: double.infinity,
                decoration: const BoxDecoration(
                  border: Border.fromBorderSide(
                    BorderSide(
                      color: Colors.white,
                      width: 2.5,
                    ),
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  color: Colors.white54,
                ),
                margin: EdgeInsets.fromLTRB(
                  SizeHelper.margin(),
                  SizeHelper.margin(),
                  0,
                  SizeHelper.margin(),
                ),
                child: SideBar(),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 25,
                  vertical: 10,
                ),
                width: SizeHelper.width() * 0.645,
                height: SizeHelper.height() * 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    MainHeader(
                      model: viewModel,
                    ),
                    SizedBox(height: 10),
                    GlobalMap(model: viewModel)
                  ],
                ),
              ),
              Container(
                width: SizeHelper.width() * 0.3,
                decoration: BoxDecoration(
                  color: Colors.white54,
                  border: Border(
                    left: BorderSide(
                      color: Colors.white,
                      width: 2.5,
                    ),
                  ),
                ),
                child: DataViewer(
                  model: viewModel,
                ),
              ),
            ],
          ),
        ),
      ),
      drawer: Container(
        child: ReduxDevTools(store),
      ),
    );
  }
}
