// To parse this JSON data, do
//
//     final GetUserModel = GetUserModelFromJson(jsonString);

import 'dart:convert';

GetUserModel getUserModelFromJson(String str) =>
    GetUserModel.fromJson(json.decode(str));

String getUserModelToJson(GetUserModel data) => json.encode(data.toJson());

class GetUserModel {
  GetUserModel({
    required this.succes,
    required this.message,
    required this.data,
  });

  bool succes;
  String message;
  List<ModelUser>? data;

  factory GetUserModel.fromJson(Map<String, dynamic> json) => GetUserModel(
        succes: json["succes"],
        message: json["message"],
        data: json["data"] == null
            ? <ModelUser>[]
            : List<ModelUser>.from(
                json["data"].map((x) => ModelUser.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "succes": succes,
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class ModelUser {
  ModelUser(
      {required this.name,
      required this.email,
      this.agencyName,
      this.grade,
      required this.open,
      required this.permit,
      required this.leave,
      required this.absenMasukCount,
      required this.absenKeluarCount,
      this.image,
      this.faceId,
      required this.indentityId,
      this.latitude,
      this.longitude});

  String name;
  String email;
  String? faceId;
  String? latitude;
  String? longitude;
  dynamic agencyName;
  dynamic grade;
  int open;
  int indentityId;
  int permit;
  int leave;
  int absenMasukCount;
  int absenKeluarCount;
  dynamic image;
  factory ModelUser.fromJson(Map<String, dynamic> json) => ModelUser(
        name: json["name"] ?? '',
        email: json["email"] ?? '',
        agencyName: json["agency_name"] ?? '',
        indentityId: json["indentity_id"] ?? 0,
        grade: json["grade"] ?? 'Title Belum Di isi',
        open: json["open"] ?? 0,
        permit: json["permit"] ?? 0,
        leave: json["leave"] ?? 0,
        absenMasukCount: json["absen_masuk_count"] ?? 0,
        absenKeluarCount: json["absen_keluar_count"] ?? 0,
        latitude: json["latitude"],
        longitude: json["longitude"],
        faceId: json["face_id"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "agency_name": agencyName,
        "grade": grade,
        "open": open,
        "permit": permit,
        "absen_masuk_count": absenMasukCount,
        "absen_keluar_count": absenKeluarCount,
        "leave": leave,
        "image": image,
      };
}
