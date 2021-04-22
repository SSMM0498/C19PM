import 'package:covid19_progression_modeler/config/config.dart';
import 'package:covid19_progression_modeler/widgets/popup/ValidatorPopup.dart';
import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';
import 'package:covid19_progression_modeler/models/models.dart';

Future<Widget> send(
  List<Day> days,
  Set<Month> month,
  bool isTransaction,
  BuildContext context,
) async {
  var conn = await MysqlConfig.newConnection();

  if (isTransaction) {
    await conn.query('START TRANSACTION');
    try {
      await loadMonth(conn, days, month, context);
      return showDialog(
        context: context,
        builder: (ctx) => ValidatorPopup(
          title: "Mode Transactionnel",
          message: "Le chargement des données a été effectué avec succés.",
          question: "Voulez vous valider le processus ?",
          okCallback: () async {
            await conn.query('COMMIT');
          },
          noCallback: () async {
            await conn.query('ROLLBACK');
          },
        ),
      );
    } catch (e) {
      await conn.query('ROLLBACK');
    }
  } else {
    await loadMonth(conn, days, month, context);
  }

  // await conn.close();
  return showDialog(
    context: context,
    builder: (ctx) => ValidatorPopup(
      title: "Chargement des données",
      message:
          "Le chargement des données est terminé et a été effectué avec succés.",
    ),
  );
}

Future<void> loadMonth(
  MySqlConnection conn,
  List<Day> days,
  Set<Month> month,
  BuildContext context,
) async {
  for (var m in month) {
    var r = await conn.query(
      'SELECT idMonth FROM monthStat WHERE sourceFileName = ?',
      [m.sourceFileName],
    );
    if (r.isEmpty) {
      await conn.query(
        'INSERT INTO monthStat (totalCases, totalHealed, totalDeath, sourceFileName) VALUES (?,?,?,?)',
        [
          m.totalCases,
          m.totalHealed,
          m.totalDeath,
          m.sourceFileName,
        ],
      );
    }
    days
        .where((d) => d.annoucementDate.startsWith(m.sourceFileName))
        .toList()
        .forEach((d) async {
      int idm;
      var r = await conn.query(
        'SELECT idDay FROM dayStat WHERE annoucementDate = ?',
        [d.annoucementDate],
      );
      var re = await conn.query(
        "SELECT idMonth FROM monthStat WHERE sourceFileName = DATE_FORMAT(?, '%Y-%m')",
        [d.annoucementDate],
      );
      idm = re.last[0];
      if (r.isEmpty) {
        loadDays(conn, d, idm);
        await conn.query(
          'UPDATE monthStat SET totalCases = totalCases + ?,totalHealed = totalHealed + ?,totalDeath = totalDeath + ? WHERE idMonth = ?',
          [
            m.totalCases,
            m.totalHealed,
            m.totalDeath,
            idm,
          ],
        );
      } else {
        return showDialog(
          context: context,
          builder: (ctx) => ValidatorPopup(
            title: "Risque de dupliquation",
            message:
                "La date ${d.annoucementDate} a déjà été envoyé dans la base",
            question: "Voulez vous ignorer la donnée ?",
            okCallback: () {},
            noCallback: () async {
              loadDays(conn, d, idm);
            },
          ),
        );
      }
    });
  }
}

Future<void> loadDays(MySqlConnection m, Day d, int idm) async {
  var result = await m.query(
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
    var r = await m.query(
      'SELECT idLocality FROM locality WHERE localityName = ?',
      [l.localityName],
    );
    await m.query(
      'INSERT INTO localityStat (newCases,isRegion,idDay,idLocality) VALUES (?,?,?,?)',
      [
        l.newCases,
        l.isRegion,
        result.insertId,
        r.last[0],
      ],
    );
  }
}
