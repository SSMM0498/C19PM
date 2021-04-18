import 'package:covid19_progression_modeler/config/config.dart';
import 'package:mysql1/mysql1.dart';

class RegionService {
  static Future<Results> getDayStat(DateTime date) async {
    Results result;
    try {
      MySqlConnection connection = await MysqlConfig.newConnection();
      if (connection != null && date != null) {
        String queryString = '''
          select
            r1.localityName as localityName,
            r1.newCases as newCases,
            r1.regionName as regionName, 
            r1.nbPopulation as nbPopulation,
            r1.regionName as regionName,
            daystat.numberOfNewCases,
            daystat.numberOfTests,
            daystat.numberOfCommunityCases,
            daystat.numberOfContactCases,
            daystat.numberOfHealed,
            daystat.numberOfDeaths,
            daystat.extractionDate,
            daystat.annoucementDate
          from
          (
            SELECT *
            FROM localityStat
            NATURAL JOIN locality
          ) r1
          join daystat
          WHERE (daystat.annoucementDate = ? AND r1.idDay = daystat.idDay);
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
