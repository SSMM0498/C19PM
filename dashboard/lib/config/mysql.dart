import 'package:mysql1/mysql1.dart';

class MysqlConfig {
  static const String host = 'localhost';
  static const int port = 3306;
  static const String user = 'userc19pm';
  static const String db = 'c19pm';
  static const String password = 'passer';
  static MySqlConnection con;

  static Future<MySqlConnection> newConnection() async {
    MySqlConnection connection;
    try {
      connection = await MySqlConnection.connect(ConnectionSettings(
          host: host, port: port, user: user, db: db, password: password));
    } catch (e) {
      print(e);
    }
    con = connection;
    return connection;
  }

  
}
