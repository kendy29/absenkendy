// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

UpdateFaceModel faceFromJson(String str) => UpdateFaceModel.fromJson(json.decode(str));

String welcomeToJson(UpdateFaceModel data) => json.encode(data.toJson());

class UpdateFaceModel {
    UpdateFaceModel({
        required this.status,
        required this.message,
        this.data,
    });

    bool status;
    String message;
    dynamic data;

    factory UpdateFaceModel.fromJson(Map<String, dynamic> json) => UpdateFaceModel(
        status: json["status"],
        message: json["message"],
        data: json["data"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data,
    };
}
