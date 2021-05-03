import 'package:covid19_progression_modeler/config/config.dart';
import 'package:mysql1/mysql1.dart';

class RegionService {
  static Future<Results> getDayStat(DateTime date) async {
    Results result;
    try {
      MySqlConnection connection = await MysqlConfig.newConnection();
      if (connection != null && date != null) {
        String queryString = '''
          SELECT r1.localityName AS localityName,
            r1.newCases AS newCases,
            r1.regionName AS regionName
          FROM (
            SELECT locality.localityName AS localityName,
              locality.regionName AS regionName,
              l.newCases AS newCases,
              l.idDay AS idDay
            FROM locality
            LEFT JOIN (
              SELECT * FROM localityStat
              NATURAL JOIN dayStat
              WHERE dayStat.annoucementDate = ?
            ) l
            ON locality.idLocality=l.idLocality
          ) r1;
        ''';
        result = await connection.query(queryString, [date.toUtc()]);
        connection.close();
      } else {
        print('Erreur de la connexion à la base de donnée');
      }
      return result;
    } catch (e) {
      print(e);
    }
    return result;
  }
}
