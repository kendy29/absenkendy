// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

SetNullModel setNullModelFromJson(String str) => SetNullModel.fromJson(json.decode(str));

String setNullModelToJson(SetNullModel data) => json.encode(data.toJson());

class SetNullModel {
    SetNullModel({
        required this.succes,
        required this.message,
        this.data,
    });

    bool succes;
    String message;
    dynamic data;

    factory SetNullModel.fromJson(Map<String, dynamic> json) => SetNullModel(
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
