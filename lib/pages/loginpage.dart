import 'package:flutter/material.dart';
import 'package:sqflitemahasiswa/crud/list_mahasiswa.dart';
import 'package:sqflitemahasiswa/model/ModelUser.dart';
import 'package:sqflitemahasiswa/network/NetworkProvider.dart';
import 'package:sqflitemahasiswa/pages/registerpage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  BaseEndPoint network = NetworkProvider();
  var status = false;
  var _obSecure = true;

  TextEditingController etEmail = TextEditingController();
  TextEditingController etPass = TextEditingController();

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

  void onValidate() async {
    if (etEmail.text.isEmpty || etPass.text.isEmpty) {
      print('Gagal');
    } else {
      List listData = await network.loginUser(
          etEmail.text.toString(), etPass.text.toString(), context);
      User data = listData[0];
      print("myData : ${data.idUser} ${data.fullnameUser} ${data.emailUser} ");
      setState(() {
        status = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan,
      body: Center(
        child: ListView(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: Column(
                    children: <Widget>[
                      Image.asset('images/logo.png'),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 50, right: 50, top: 40),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            children: <Widget>[
                              TextFormField(
                                style: TextStyle(color: Colors.white),
                                controller: etEmail,
                                decoration: InputDecoration(
                                    hintText: 'Email',
                                    prefixIcon: Icon(Icons.email),
                                    hintStyle: TextStyle(
                                      color: Colors.white,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    )),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              TextFormField(
                                controller: etPass,
                                obscureText: _obSecure,
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                    hintText: 'Password',
                                    prefixIcon: Icon(Icons.vpn_key),
                                    hintStyle: TextStyle(color: Colors.white),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        _obSecure
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        size: 35,
                                      ),
                                      onPressed: () {
                                        onHideSecure();
                                      },
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    )),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              SizedBox(
                                height: 50,
                                width: 320,
                                child: RaisedButton(
                                  onPressed: () {
                                    onValidate();
                                  },
                                  color: Colors.pink,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    'Sign In',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 15),
                              ),
                              Text(
                                'Or',
                                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                              ),
                              FlatButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              RegisterPage()));
                                },
                                color: Colors.pink,
                                child: Text(
                                  'Register',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
