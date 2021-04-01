import 'package:covid19_progression_modeler/redux/AppState.dart';
import 'package:covid19_progression_modeler/redux/viewModel/ViewModel.dart';
import 'package:covid19_progression_modeler/widgets/DataViewer.dart';
import 'package:covid19_progression_modeler/widgets/GlobalMap.dart';
import 'package:covid19_progression_modeler/widgets/MainHeader.dart';
import 'package:covid19_progression_modeler/widgets/SideBar.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:covid19_progression_modeler/config/config.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeHelper.getScreenSize(context);
    return Scaffold(
      body: StoreConnector<AppState, ViewModelRegion>(
        converter: (Store<AppState> store) => ViewModelRegion.create(store),
        builder: (BuildContext context, ViewModelRegion viewModel) => Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Container(
              width: SizeHelper.width() * 0.05,
              height: double.infinity,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(18)),
                color: Colors.white,
              ),
              margin: EdgeInsets.fromLTRB(SizeHelper.margin(),
                  SizeHelper.margin(), 0, SizeHelper.margin()),
              child: SideBar(),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              width: SizeHelper.width() * 0.64,
              height: SizeHelper.height() * 1,
              color: Palette.primeColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  MainHeader(),
                  SizedBox(height: 30),
                  GlobalMap(model: viewModel,)
                ],
              ),
            ),
            Container(
              width: SizeHelper.width() * 0.3,
              color: Colors.white,
              child: DataViewer(),
            ),
          ],
        ),
      ),
    );
  }
}
