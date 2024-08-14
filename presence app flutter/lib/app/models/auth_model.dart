// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

LoginModel loginFromJson(String str) => LoginModel.fromJson(json.decode(str));

String welcomeToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
    LoginModel({
        required this.succes,
        required this.message,
        required this.data,
    });

    bool succes;
    String message;
    ModelLogin data;

    factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        succes: json["succes"],
        message: json["message"],
        data: ModelLogin.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "succes": succes,
        "message": message,
        "data": data.toJson(),
    };
}

class ModelLogin {
    ModelLogin({
        required this.token,
        required this.name,
        this.faceId,
        required this.indentityId,
        required this.isAdmin,
    });

    String? token;
    String? name;
    String? faceId;
    String? isAdmin;
    int? indentityId;

    factory ModelLogin.fromJson(Map<String, dynamic> json) => ModelLogin(
        token: json["token"],
        name: json["name"],
        faceId: json["face_id"],
        isAdmin: json["is_admin"],
        indentityId: json["indentity_id"],
    );

    Map<String, dynamic> toJson() => {
        "token": token,
        "name": name,
        "face_id": faceId,
        "indentity_id": indentityId,
        "is_admin": isAdmin
    };
}
