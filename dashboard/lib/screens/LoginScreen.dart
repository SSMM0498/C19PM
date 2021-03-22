import 'package:covid19_progression_modeler/config/config.dart';
import 'package:covid19_progression_modeler/models/User.dart';
import 'package:covid19_progression_modeler/screens/HomeScreen.dart';
import 'package:covid19_progression_modeler/widgets/FadeAnimation.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  final User currentUser = new User();
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final User user = User();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.primaryAppColor,
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
                                Palette.primaryAppColor,
                                Palette.secondaryAppColor,
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
                                "Se connecter",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0,
                                ),
                              ),
                            ),
                          ),
                        )),
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
    print(user.login);
    print(user.password);
    
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HomeScreen(),
      ),
    );
  }
}
