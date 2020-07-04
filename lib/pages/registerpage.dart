import 'package:flutter/material.dart';
import 'package:sqflitemahasiswa/network/NetworkProvider.dart';
import 'package:sqflitemahasiswa/pages/loginpage.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  BaseEndPoint network = NetworkProvider();
  GlobalKey<FormState> _key = GlobalKey();
  String myName, myEmail, myPass;
  var _obSecure = true;

  void onHideSecure() {
    if (_obSecure == true) {
      setState(() {
        _obSecure = false;
      });
    } else {
      setState(() {
        _obSecure = true;
      });
    }
  }

  void sendToDatabase() {
    if (_key.currentState.validate()) {
      _key.currentState.save();
      if (myName.isEmpty || myEmail.isEmpty || myPass.isEmpty) {
        print('Form Tidak Boleh Kosong');
      } else {
        network.registerUser(myName, myEmail, myPass, context);
      }
    } else {
      print('Not Validate');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink,
      body: Center(
        child: ListView(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 70, left: 40),
                  child: Text(
                    'REGISTER',
                    style: TextStyle(
                        letterSpacing: 10,
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                Form(
                  key: _key,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 150, bottom: 50, left: 20, right: 20),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 50, left: 30, right: 50, bottom: 50),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                children: <Widget>[
                                  TextFormField(
                                    decoration: InputDecoration(
                                      hintText: 'Nama Lengkap',
                                      prefixIcon: Icon(Icons.person),
                                    ),
                                    onSaved: (value) {
                                      myName = value;
                                    },
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                  ),
                                  TextFormField(
                                    decoration: InputDecoration(
                                        hintText: 'Email',
                                        prefixIcon: Icon(Icons.email)),
                                    onSaved: (value) {
                                      myEmail = value;
                                    },
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                  ),
                                  TextFormField(
                                    obscureText: _obSecure,
                                    onSaved: (value) {
                                      myPass = value;
                                    },
                                    decoration: InputDecoration(
                                        hintText: 'Password',
                                        prefixIcon: Icon(Icons.vpn_key),
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                            _obSecure
                                                ? Icons.visibility
                                                : Icons.visibility_off,
                                            size: 25,
                                          ),
                                          onPressed: () {
                                            onHideSecure();
                                          },
                                        )),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                  ),
                                  RaisedButton(
                                    onPressed: () {
                                      sendToDatabase();
                                    },
                                    color: Colors.cyan,
                                    child: Text(
                                      'Sign Up',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                  ),
                                  FlatButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      'Already have an Account? Sign In',
                                      style: TextStyle(color: Colors.cyan),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
