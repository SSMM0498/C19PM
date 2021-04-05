import 'package:covid19_progression_modeler/config/config.dart';
import 'package:covid19_progression_modeler/models/User.dart';
import 'package:covid19_progression_modeler/redux/actions/user.action.dart';
import 'package:covid19_progression_modeler/screens/HomeScreen.dart';
import 'package:covid19_progression_modeler/services/user.service.dart';
import 'package:covid19_progression_modeler/widgets/FadeAnimation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
// import 'package:mysql1/mysql1.dart';
// import 'package:flutter/services.dart';
// import 'package:starflut/starflut.dart';

class LoginScreen extends StatefulWidget {
  // final User currentUser = new User();
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final User user = User();
  final UserService userService = UserService();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool loading = false;
  // String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    setState(() {
      this.loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.secondColor,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height - 82.0,
              width: MediaQuery.of(context).size.width,
              color: Colors.transparent,
            ),
            Positioned(
              top: 75.0,
              left: 100,
              right: 100,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(45.0),
                    topRight: Radius.circular(45.0),
                    bottomLeft: Radius.circular(45.0),
                    bottomRight: Radius.circular(45.0),
                  ),
                  color: Colors.white60,
                ),
                height: MediaQuery.of(context).size.height - 200,
                width: MediaQuery.of(context).size.width,
              ),
            ),
            Positioned(
              top: 150,
              left: MediaQuery.of(context).size.width / 4,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width / 2,
              child: Padding(
                padding: EdgeInsets.all(30.0),
                child: Column(
                  children: <Widget>[
                    FadeAnimation(
                        1.8,
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                    color: Color.fromRGBO(143, 148, 251, .2),
                                    blurRadius: 20.0,
                                    offset: Offset(0, 10))
                              ]),
                          child: Form(
                            key: this._formKey,
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom:
                                          BorderSide(color: Colors.grey[100]),
                                    ),
                                  ),
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Login',
                                      hintStyle:
                                          TextStyle(color: Colors.grey[400]),
                                    ),
                                    validator: (String value) {
                                      if (value.isEmpty) {
                                        return 'Le login est obligatoire';
                                      }
                                      return null;
                                    },
                                    onSaved: (String value) {
                                      this.user.login = value;
                                    },
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom:
                                          BorderSide(color: Colors.grey[100]),
                                    ),
                                  ),
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'mot de passe',
                                      hintStyle:
                                          TextStyle(color: Colors.grey[400]),
                                    ),
                                    validator: (String value) {
                                      if (value.isEmpty) {
                                        return 'le mot de passe est obligatoire';
                                      }
                                      return null;
                                    },
                                    onSaved: (String value) {
                                      this.user.password = value;
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )),
                    SizedBox(
                      height: 30,
                    ),
                    FadeAnimation(
                        2,
                        Container(
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: LinearGradient(colors: [
                                  Palette.lightSecondColor,
                                  Palette.secondColor,
                                ])),
                            child: InkWell(
                              onTap: () {
                                if (_formKey.currentState.validate()) {
                                  this._formKey.currentState.save();
                                  this.onSubmit(context, this.user);
                                }
                              },
                              child: Center(
                                  child: Text(
                                'Se connecter',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0,
                                ),
                              )),
                            ))),
                    SizedBox(
                      height: 70,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onSubmit(BuildContext context, User user) async {
    if (user.login == 'root' && user.password == 'passer') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ),
      );
    } else {
      await _showDialog(
        'Utilisateur introuvable !',
        'Login ou mot de passe Incorrect',
        'Réessayer SVP !',
      );
    }
    // setState(() {
    //   this.loading = !this.loading;
    // });
    // User currentUser = new User();
    // Results results = await this.userService.login(user);

    // if (results != null) {
    //   if (results.length > 0) {
    //     for (var row in results) {
    //       currentUser.idUser = row['idUser'];
    //       currentUser.username = row['username'];
    //       currentUser.login = row['login'];
    //       currentUser.password = row['password'];
    //       setState(() {
    //         this.loading = !this.loading;
    //       });
    //       setUser(context, currentUser);
    //     }
    //     Navigator.push(
    //       context,
    //       MaterialPageRoute(
    //         builder: (context) => HomeScreen(),
    //       ),
    //     );
    //   } else {
    //     await _showDialog(
    //       'Utilisateur introuvable !',
    //       'Login ou mot de passe Incorrect',
    //       'Réessayer SVP !',
    //     );
    //   }
    // } else {
    //   await _showDialog(
    //     'Connexion refusé !',
    //     'Impossible de se connecter à la base de données',
    //     'Redémarrez votre serveur mysql SVP !',
    //   );
    // }
  }

  Future<void> _showDialog(String title, String message, String advice) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message),
                Text(advice),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  setUser(BuildContext context, User user) {
    StoreProvider.of(context).dispatch(AddUserAction(user));
  }
  // Future<void> initPlatformState() async {
  //   String platformVersion;
  //   try {
  //     String Path1 = await Starflut.getResourcePath();
  //     String Path2 = await Starflut.getAssetsPath();
  //     StarCoreFactory starcore = await Starflut.getFactory();
  //     StarServiceClass Service =
  //         await starcore.initSimple("test", "123", 0, 0, []);
  //     await starcore.regMsgCallBackP(
  //         (int serviceGroupID, int uMsg, Object wParam, Object lParam) async {
  //       print("$serviceGroupID  $uMsg   $wParam   $lParam");
  //       return null;
  //     });
  //     StarSrvGroupClass SrvGroup = await Service["_ServiceGroup"];

  //     /*--macos--*/
  //     int Platform = await Starflut.getPlatform();
  //     if (Platform == Starflut.MACOS) {
  //       await starcore
  //           .setShareLibraryPath(Path1); //set path for interface library
  //       bool LoadResult =
  //           await Starflut.loadLibrary(Path1 + "/libpython3.9.dylib");
  //       print("$LoadResult"); //--load
  //       await Starflut.setEnv("PYTHONPATH",
  //           "/Library/Frameworks/Python.framework/Versions/3.9/lib/python3.9");
  //       String pypath = await Starflut.getEnv("PYTHONPATH");
  //       print("$pypath");
  //     } else if (Platform == Starflut.WINDOWS) {
  //       await starcore.setShareLibraryPath(
  //           Path1.replaceAll("\\", "/")); //set path for interface library
  //     }

  //     String docPath = await Starflut.getDocumentPath();
  //     print("docPath = $docPath");

  //     String resPath = await Starflut.getResourcePath();
  //     print("resPath = $resPath");

  //     String assetsPath = await Starflut.getAssetsPath();
  //     print("assetsPath = $assetsPath");

  //     dynamic rr1 = await SrvGroup.initRaw("python39", Service);

  //     print("initRaw = $rr1");
  //     var Result = await SrvGroup.loadRawModule("python", "",
  //         assetsPath + "/flutter_assets/starfiles/" + "testpy.py", false);
  //     print("loadRawModule = $Result");

  //     dynamic python =
  //         await Service.importRawContext(null, "python", "", false, "");
  //     print("python = " + await python.getString());

  //     StarObjectClass retobj = await python.call("tt", ["hello ", "world"]);
  //     print(await retobj[0]);
  //     print(await retobj[1]);

  //     print(await python["g1"]);

  //     StarObjectClass yy = await python.call("yy", ["hello ", "world", 123]);
  //     print(await yy.call("__len__", []));

  //     StarObjectClass multiply =
  //         await Service.importRawContext(null, "python", "Multiply", true, "");
  //     StarObjectClass multiply_inst =
  //         await multiply.newObject(["", "", 33, 44]);
  //     print(await multiply_inst.getString());

  //     print(await multiply_inst.call("multiply", [11, 22]));

  //     await SrvGroup.clearService();
  //     await starcore.moduleExit();

  //     print("finish");
  //   } on PlatformException catch (e) {
  //     print("{$e.message}");
  //     platformVersion = 'Failed to get platform version.';
  //   }

  //   if (!mounted) return;

  //   setState(() {
  //     _platformVersion = platformVersion;
  //   });
  // }
}
