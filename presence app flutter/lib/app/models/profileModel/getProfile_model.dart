// To parse this JSON data, do
//
//     final ProfileModel = ProfileModelFromJson(jsonString);

import 'dart:convert';

ProfileModel profileModelFromJson(String str) =>
    ProfileModel.fromJson(json.decode(str));

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
  ProfileModel({
    required this.succes,
    required this.message,
    required this.data,
  });

  bool? succes;
  String? message;
  ModelProfile? data;

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        succes: json["succes"],
        message: json["message"],
        data: json["data"] != null
            ? ModelProfile.fromJson(json["data"])
            : ModelProfile(),
      );

  Map<String, dynamic> toJson() => {
        "succes": succes,
        "message": message,
        "data": data!.toJson(),
      };
}

class ModelProfile {
  ModelProfile({
    this.id,
    this.indentityIdUsers,
    this.agencyName,
    this.image,
    this.logType,
    this.open,
    this.permit,
    this.leave,
    this.grade,
    this.dateNotAbsen,
    this.latitude,
    this.longitude,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? indentityIdUsers;
  String? agencyName;
  String? image;
  String? logType;
  int? open;
  int? permit;
  int? leave;
  String? grade;
  String? dateNotAbsen;
  String? latitude;
  String? longitude;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory ModelProfile.fromJson(Map<String, dynamic> json) => ModelProfile(
        id: json["id"],
        indentityIdUsers: json["indentity_id_users"] ?? 0,
        agencyName: json["agency_name"] ?? "Edit Profile Dulu",
        image: json["image"],
        logType: json["log_type"] ?? "0",
        open: json["open"] ?? 0,
        permit: json["permit"] ?? 0,
        leave: json["leave"] ?? 0,
        dateNotAbsen: json["date_not_absen"] ?? "",
        grade: json["grade"] ?? "",
        latitude: json["latitude"] ?? "0",
        longitude: json["longitude"] ?? "0",
        createdAt:json["created_at"]==null?DateTime.now(): DateTime.parse(json["created_at"]),
        updatedAt:json["created_at"]==null?DateTime.now(): DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "indentity_id_users": indentityIdUsers,
        "agency_name": agencyName,
        "image": image,
        "log_type": logType,
        "open": open,
        "permit": permit,
        "date_not_absen": dateNotAbsen,
        "leave": leave,
        "grade": grade,
        "latitude": latitude,
        "longitude": longitude,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };
}
