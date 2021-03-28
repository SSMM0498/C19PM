import 'package:covid19_progression_modeler/config/config.dart';
import 'package:covid19_progression_modeler/models/models.dart';
import 'package:mysql1/mysql1.dart';

class UserService {
  Future<Results> login(User user) async {
    print('login me: ' + user.login + ' ' + user.password);
    MySqlConnection connection = await MysqlConfig.newConnection();
    String queryString =
        'select idUser, username, login, password from t_user where( login = ? and password = ? )';
    Results result =
        await connection.query(queryString, [user.login, user.password]);

    connection.close();
    return result;
  }
}
