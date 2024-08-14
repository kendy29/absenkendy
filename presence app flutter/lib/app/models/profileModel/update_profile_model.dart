// To parse this JSON data, do
//
//     final updateProfile = updateProfileFromJson(jsonString);

import 'dart:convert';

UpdateProfileModel updateProfileFromJson(String str) => UpdateProfileModel.fromJson(json.decode(str));

String updateProfileToJson(UpdateProfileModel data) => json.encode(data.toJson());

class UpdateProfileModel {
    UpdateProfileModel({
        required this.succes,
        required this.message,
        this.data,
    });

    bool succes;
    String message;
    dynamic data;

    factory UpdateProfileModel.fromJson(Map<String, dynamic> json) => UpdateProfileModel(
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
