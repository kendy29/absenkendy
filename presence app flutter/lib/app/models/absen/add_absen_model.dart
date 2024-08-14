// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

AbsenModel absenFromJson(String str) => AbsenModel.fromJson(json.decode(str));

String welcomeToJson(AbsenModel data) => json.encode(data.toJson());

class AbsenModel {
    AbsenModel({
        required this.succes,
        required this.message,
        this.data,
    });

    bool succes;
    String message;
    dynamic data;

    factory AbsenModel.fromJson(Map<String, dynamic> json) => AbsenModel(
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
