// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

AbsenPermitModel absenPermitFromJson(String str) => AbsenPermitModel.fromJson(json.decode(str));

String absenPermitToJson(AbsenPermitModel data) => json.encode(data.toJson());

class AbsenPermitModel {
    AbsenPermitModel({
        required this.succes,
        required this.message,
        this.data,
    });

    bool succes;
    String message;
    dynamic data;

    factory AbsenPermitModel.fromJson(Map<String, dynamic> json) => AbsenPermitModel(
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
