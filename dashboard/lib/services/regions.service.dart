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
            r1.locationName,
            r1.nbNewCases as newCases,
            daystat.nbNewCases,
            daystat.nbTests,
            daystat.nbCommunityCases,
            daystat.nbContactCases,
            daystat.nbHealed,
            daystat.nbDeath,
            daystat.extractionDate,
            r1.nbPopulation,
            daystat.annoucementDate
          from
          (
            select *
            from locationstat
            natural join location
          ) r1
          join daystat
          WHERE (daystat.extractionDate = ? AND r1.idDay = daystat.idDay);
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
