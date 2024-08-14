// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

DeleteAcountModel deleteAccountFromJson(String str) => DeleteAcountModel.fromJson(json.decode(str));

String welcomeToJson(DeleteAcountModel data) => json.encode(data.toJson());

class DeleteAcountModel {
    DeleteAcountModel({
        required this.succes,
        required this.message,
        this.data,
    });

    bool succes;
    String message;
    dynamic data;

    factory DeleteAcountModel.fromJson(Map<String, dynamic> json) => DeleteAcountModel(
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
