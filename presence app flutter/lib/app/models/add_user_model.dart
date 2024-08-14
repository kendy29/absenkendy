// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

AddUserModel addUserModelFromJson(String str) => AddUserModel.fromJson(json.decode(str));

String addUserModelToJson(AddUserModel data) => json.encode(data.toJson());

class AddUserModel {
    AddUserModel({
        required this.succes,
        required this.message,
        this.data,
    });

    bool succes;
    String message;
    dynamic data;

    factory AddUserModel.fromJson(Map<String, dynamic> json) => AddUserModel(
        succes: json["succes"],
        message: json["message"],
        data: json["data"],
    );

    Map<String, dynamic> toJson() => {
        "succes": succes,
        "message": message,
        "data": data,
    };
}
