// To parse this JSON data, do
//
//     final modelUser = modelUserFromJson(jsonString);

import 'dart:convert';

ModelUser modelUserFromJson(String str) => ModelUser.fromJson(json.decode(str));

String modelUserToJson(ModelUser data) => json.encode(data.toJson());

class ModelUser {
  ModelUser({
    this.status,
    this.message,
    this.user,
  });

  int status;
  String message;
  List<User> user;

  factory ModelUser.fromJson(Map<String, dynamic> json) => ModelUser(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    user: json["user"] == null ? null : List<User>.from(json["user"].map((x) => User.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
    "user": user == null ? null : List<dynamic>.from(user.map((x) => x.toJson())),
  };
}

class User {
  User({
    this.idUser,
    this.fullnameUser,
    this.emailUser,
    this.passwordUser,
  });

  String idUser;
  String fullnameUser;
  String emailUser;
  String passwordUser;

  factory User.fromJson(Map<String, dynamic> json) => User(
    idUser: json["id_user"] == null ? null : json["id_user"],
    fullnameUser: json["fullname_user"] == null ? null : json["fullname_user"],
    emailUser: json["email_user"] == null ? null : json["email_user"],
    passwordUser: json["password_user"] == null ? null : json["password_user"],
  );

  Map<String, dynamic> toJson() => {
    "id_user": idUser == null ? null : idUser,
    "fullname_user": fullnameUser == null ? null : fullnameUser,
    "email_user": emailUser == null ? null : emailUser,
    "password_user": passwordUser == null ? null : passwordUser,
  };
}
