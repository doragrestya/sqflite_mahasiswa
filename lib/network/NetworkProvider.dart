import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:sqflitemahasiswa/constant/ConstantFile.dart';
import 'package:http/http.dart' as http;
import 'package:sqflitemahasiswa/crud/list_mahasiswa.dart';
import 'package:sqflitemahasiswa/model/ModelUser.dart';

abstract class BaseEndPoint {
  void registerUser(
      String myName, String myEmail, String myPassword, BuildContext contex);
  Future<List> loginUser(
      String myEmail, String myPassword, BuildContext context);
}

class NetworkProvider extends BaseEndPoint {
  @override
  Future<List> loginUser(
      String myEmail, String myPassword, context) async {
    // TODO: implement loginUser
    final response = await http.post(ConstantFile().baseUrl + "loginUser",
        body: {'email': myEmail, 'password': myPassword});

    ModelUser listData = modelUserFromJson(response.body);
    if (listData.status == 200) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => ListMahasiswa()));
      return listData.user;
    } else {
      return null;
    }
  }

  @override
  void registerUser(
      String myName, myEmail, String myPassword, BuildContext contex) async {
    // TODO: implement registerUser

    final response = await http.post(ConstantFile().baseUrl + "registerUser",
        body: {'name': myName, 'email': myEmail, 'password': myPassword});
    var listData = jsonDecode(response.body);

    if (listData['status'] == 200) {
      print(listData['message']);
      AwesomeDialog(
              context: contex,
              dialogType: DialogType.SUCCES,
              animType: AnimType.BOTTOMSLIDE,
              title: 'Information Register',
              desc: listData['message'],
              btnOkText: 'Go to Login',
              btnOkOnPress: () {})
          .show();
    } else {
      print(listData['message']);
      AwesomeDialog(
              context: contex,
              dialogType: DialogType.ERROR,
              animType: AnimType.BOTTOMSLIDE,
              title: 'Information Register',
              desc: listData['message'],
              btnOkOnPress: () {})
          .show();
    }
  }
}
