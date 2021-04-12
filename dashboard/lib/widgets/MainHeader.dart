import 'package:covid19_progression_modeler/redux/viewModel/ViewModel.dart';
// import 'package:covid19_progression_modeler/widgets/DatePicker.dart';
import 'package:flutter/material.dart';

class MainHeader extends StatelessWidget {
  final ViewModel model;
  const MainHeader({
    Key key,
    this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          flex: 6,
          // child: DatePciker(model: model),
          child: Center(
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () async {
                    DateTime newDate = await displayDatePicker(context);
                    print(newDate);
                    model.onSetSelectedDate(newDate);
                  },
                  child: Text('Choisir une date'),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      horizontal: 50,
                      vertical: 20,
                    ),
                    textStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Text(
                  'Choisir une date',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

displayDatePicker(BuildContext context) {
  return showDatePicker(
    context: context,
    locale: const Locale("fr", "FR"),
    initialDate: DateTime.now(),
    firstDate: DateTime(2020),
    lastDate: DateTime(2030),
    builder: (context, child) {
      return Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 50.0),
            child: Container(
              height: 600,
              width: 700,
              child: child,
            ),
          ),
        ],
      );
    },
  );
}
