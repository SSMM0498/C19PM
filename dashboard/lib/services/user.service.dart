import 'package:covid19_progression_modeler/config/config.dart';
import 'package:covid19_progression_modeler/models/models.dart';
import 'package:mysql1/mysql1.dart';

class UserService {
  Future<Results> login(User user) async {
    Results result;
    try {
      MySqlConnection connection = await MysqlConfig.newConnection();
      if (connection != null) {
        String queryString =
            'select idUser, username, login, password from t_user where( login = ? and password = ? )';
        result =
            await connection.query(queryString, [user.login, user.password]);

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
