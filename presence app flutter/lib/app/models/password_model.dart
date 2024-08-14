// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

ChangePasswordModel passwordModelFromJson(String str) => ChangePasswordModel.fromJson(json.decode(str));

String passwordModelToJson(ChangePasswordModel data) => json.encode(data.toJson());

class ChangePasswordModel {
    ChangePasswordModel({
        required this.succes,
        required this.message,
        this.data,
    });

    bool succes;
    String message;
    dynamic data;

    factory ChangePasswordModel.fromJson(Map<String, dynamic> json) => ChangePasswordModel(
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
