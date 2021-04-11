import 'package:mysql1/mysql1.dart';
import 'package:covid19_progression_modeler/models/models.dart';
import 'package:intl/intl.dart';

void send(List<Day> days, bool isTransaction) async {
  var settings = new ConnectionSettings(
    host: 'localhost',
    port: 3306,
    user: 'userc19pm',
    password: 'passer',
    db: 'c19pm',
  );
//DateFormat("YYYY-MM-DD").format
  var conn = await MySqlConnection.connect(settings);
  var iduser = await conn.query('select idUser from t_user ');

  for (var d in days) {
    var day =
        DateFormat('yyyy-MM-dd').format(DateFormat('dd-MM-yyyy').parse(d.date));
    var result = await conn.query(
        'INSERT INTO dayStat (date,numberOfTests,numberOfNewCases,numberOfCommunityCases,numberOfContactCases,numberOfHealed,numberOfDeath,t_user_iduser) VALUES (?,?,?,?,?,?,?,?)',
        [
          day,
          d.dayStats.numberOfTests,
          d.dayStats.numberOfNewCases,
          d.dayStats.numberOfCommunityCases,
          d.dayStats.numberOfContactCases,
          d.dayStats.numberOfHealed,
          d.dayStats.numberOfDeaths,
          iduser.last[0]
        ]);
    // for (var l = 0; l < d.dayStats.localities.length; l++) {
    //   await conn.query(
    //       'INSERT INTO location (locationName,locNumberOfNewCases,administrativeLevel,dayStat_idday) VALUES (?,?,?,?)',
    //       [
    //         d.dayStats.localities[l].name,
    //         d.dayStats.localities[l].newCases,
    //         d.dayStats.localities[l].adminLevel,
    //         result.insertId
    //       ]);
    // }
  }
  print(isTransaction);
  print("Send file");
  await conn.close();
}
