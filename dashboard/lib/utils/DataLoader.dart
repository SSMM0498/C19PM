import 'package:mysql1/mysql1.dart';
import 'package:covid19_progression_modeler/models/models.dart';

void send(List<Day> days, Set<Month> month, bool isTransaction) async {
  var settings = new ConnectionSettings(
    host: 'localhost',
    port: 3306,
    user: 'userc19pm',
    password: 'passer',
    db: 'c19pm',
  );

  var conn = await MySqlConnection.connect(settings);

  for (var m in month) {
    var r = await conn.query(
        'SELECT idMonth FROM monthStat WHERE sourceFileName = ?',
        [m.sourceFileName]);
    int idm;
    if (r.isEmpty) {
      var result = await conn.query(
        'INSERT INTO monthStat (totalCases, totalHealed, totalDeath, sourceFileName) VALUES (?,?,?,?)',
        [
          m.totalCases,
          m.totalHealed,
          m.totalDeath,
          m.sourceFileName,
        ],
      );
      idm = result.insertId;
    } else {
      var result = await conn.query(
        'UPDATE monthStat SET totalCases = totalCases + ?,totalHealed = totalHealed + ?,totalDeath = totalDeath + ? WHERE idMonth = ?',
        [
          m.totalCases,
          m.totalHealed,
          m.totalDeath,
          r.last[0],
        ],
      );
      idm = r.last[0];
    }
    for (var d in days) {
      var r = await conn.query(
          'SELECT idDay FROM dayStat WHERE annoucementDate = ?',
          [d.annoucementDate]);
      if (r.isEmpty) {
        var result = await conn.query(
          'INSERT INTO dayStat (annoucementDate,numberOfTests,numberOfNewCases,numberOfContactCases,numberOfCommunityCases,numberOfHealed,numberOfDeaths,idMonth) VALUES (?,?,?,?,?,?,?,?)',
          [
            d.annoucementDate,
            d.dayStats.numberOfTests,
            d.dayStats.numberOfNewCases,
            d.dayStats.numberOfCommunityCases,
            d.dayStats.numberOfContactCases,
            d.dayStats.numberOfHealed,
            d.dayStats.numberOfDeaths,
            idm
          ],
        );
        for (var l in d.dayStats.localities) {
          print(l.isRegion);
          if (l.isRegion) {
            continue;
          }
          var r = await conn.query(
              'SELECT idLocality FROM locality WHERE localityName = ?',
              [l.localityName]);
          await conn.query(
            'INSERT INTO localityStat (newCases,isRegion,idDay,idLocality) VALUES (?,?,?,?)',
            [
              l.newCases,
              l.isRegion,
              result.insertId,
              r.last[0],
            ],
          );
        }
      } else {
        print("Déjà envoyé");
      }
    }
  }
  await conn.close();
}
