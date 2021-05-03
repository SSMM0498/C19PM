import 'package:covid19_progression_modeler/config/config.dart';
import 'package:covid19_progression_modeler/models/models.dart';
import 'package:flutter/material.dart';

class DataPopup extends StatelessWidget {
  final Day day;

  DataPopup({Key key, this.day}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("${day.annoucementDate}"),
      titleTextStyle: TextStyle(color: Palette.fontColor, fontSize: 24),
      titlePadding: EdgeInsets.all(15),
      contentPadding: EdgeInsets.all(10),
      backgroundColor: Palette.backgroundColor,
      scrollable: true,
      content: Container(
        width: SizeHelper.width() * 0.6,
        height: SizeHelper.height() * 0.75,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                numberInfos(
                  nb: day.dayStats.numberOfTests,
                  label: "tests",
                ),
                SizedBox(width: 50),
                numberInfos(
                  nb: day.dayStats.numberOfNewCases,
                  label: "nouveaux cas",
                ),
                SizedBox(width: 50),
                numberInfos(
                  nb: day.dayStats.numberOfHealed,
                  label: "guérris",
                ),
                SizedBox(width: 50),
                numberInfos(
                  nb: day.dayStats.numberOfDeaths,
                  label: "morts",
                ),
                SizedBox(width: 50),
                numberInfos(
                  nb: day.dayStats.numberOfContactCases,
                  label: "cas contact",
                ),
                SizedBox(width: 50),
                numberInfos(
                  nb: day.dayStats.numberOfCommunityCases,
                  label: "cas communautaire",
                ),
              ],
            ),
            SizedBox(height: 50),
            Expanded(
              child: Container(
                width: SizeHelper.width() * 0.35,
                child: Scrollbar(
                  child: ListView.builder(
                    itemCount: day.dayStats.localities.length,
                    itemBuilder: (BuildContext context, int index) {
                      Locality l = day.dayStats.localities[index];
                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              numberInfos(
                                nb: l.localityName,
                                label: (l.isRegion) ? "region" : "département",
                              ),
                              SizedBox(width: 20),
                              numberInfos(
                                nb: l.newCases,
                                label: "nouveaux cas",
                              ),
                            ],
                          ),
                          SizedBox(height: 25),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Column numberInfos({dynamic nb, String label}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "$nb",
        style: TextStyle(
          fontSize: 30,
          color: Palette.fontColor,
        ),
      ),
      SizedBox(height: 5),
      Text(
        label,
        style: TextStyle(
          fontSize: 15,
          color: Palette.fontColor,
        ),
      ),
    ],
  );
}
