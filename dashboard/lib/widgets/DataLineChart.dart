import 'package:covid19_progression_modeler/config/config.dart';
import 'package:covid19_progression_modeler/models/DataGetter.dart'
    as DataGetter;
import 'package:covid19_progression_modeler/widgets/Wrapper.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class DataLineChart extends StatelessWidget {
  final String localityname;
  const DataLineChart({Key key, this.localityname}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrapper(
      title: "Courbe d'évolution",
      downloadText: "Télécharger la courbe",
      childWidget: Container(
        color: Colors.white,
        child: LineChart(
          chartData(),
          swapAnimationDuration: const Duration(milliseconds: 250),
        ),
      ),
    );
  }

  LineChartData chartData() {
    return LineChartData(
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Palette.primeColor,
        ),
        touchCallback: (LineTouchResponse touchResponse) {},
        handleBuiltInTouches: true,
      ),
      gridData: FlGridData(
        show: false,
      ),
      titlesData: FlTitlesData(
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          getTextStyles: (value) => const TextStyle(
            color: Color(0xff212121),
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          margin: 10,
          getTitles: yearAxis,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => const TextStyle(
            color: Color(0xff212121),
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
          getTitles: nbCasesAxis,
          margin: 8,
          reservedSize: 30,
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: const Border(
          bottom: BorderSide(
            color: Palette.lightSecondColor,
            width: 2,
          ),
          left: BorderSide(
            color: Palette.lightSecondColor,
            width: 2,
          ),
          right: BorderSide(
            color: Colors.transparent,
          ),
          top: BorderSide(
            color: Colors.transparent,
          ),
        ),
      ),
      minX: 0,
      maxX: 12,
      maxY: 5,
      minY: 0,
      lineBarsData: linesBarData1(),
    );
  }

  List<LineChartBarData> linesBarData1() {
    final LineChartBarData lineChartBarData = LineChartBarData(
      spots: DataGetter.createGraphPoint(localityname),
      isCurved: true,
      colors: [
        Palette.secondColor,
      ],
      barWidth: 5,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: false,
      ),
      belowBarData: BarAreaData(show: false, colors: [
        const Color(0x0000000),
      ]),
    );
    return [lineChartBarData];
  }
}

String yearAxis(value) {
  switch (value.toInt()) {
    case 1:
      return 'JAN';
    case 2:
      return 'FEV';
    case 3:
      return 'MAR';
    case 4:
      return 'AVR';
    case 5:
      return 'MAI';
    case 6:
      return 'JUN';
    case 7:
      return 'JUL';
    case 8:
      return 'AOÛ';
    case 9:
      return 'SEP';
    case 10:
      return 'OCT';
    case 11:
      return 'NOV';
    case 12:
      return 'DEC';
  }
  return '';
}

String nbCasesAxis(value) {
  switch (value.toInt()) {
    case 1:
      return '10';
    case 2:
      return '20';
    case 3:
      return '30';
    case 4:
      return '40';
    case 5:
      return '50';
    case 6:
      return '60';
    case 7:
      return '70';
    case 8:
      return '80';
    case 9:
      return '90';
    case 10:
      return '100';
  }
  return '';
}
