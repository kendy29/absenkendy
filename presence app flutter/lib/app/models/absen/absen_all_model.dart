// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

AbsenAllModel absenAllFromJson(String str) =>
    AbsenAllModel.fromJson(json.decode(str));

String absenAllToJson(AbsenAllModel data) => json.encode(data.toJson());

class AbsenAllModel {
  bool succes;
  String message;
  List<AllAbsenModel> data;

  AbsenAllModel({
    required this.succes,
    required this.message,
    required this.data,
  });

  factory AbsenAllModel.fromJson(Map<String, dynamic> json) => AbsenAllModel(
        succes: json["succes"],
        message: json["message"],
        data: json["data"] == null
            ? <AllAbsenModel>[]
            : List<AllAbsenModel>.from(
                json["data"].map((x) => AllAbsenModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "succes": succes,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class AllAbsenModel {
  String name;
  int id;
  int indentityIdUsers;
  String date;
  String opened;
  String closed;
  dynamic image;
  DateTime createdAt;
  DateTime updatedAt;

  AllAbsenModel({
    required this.name,
    required this.id,
    required this.indentityIdUsers,
    required this.date,
    required this.opened,
    required this.closed,
    this.image,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AllAbsenModel.fromJson(Map<String, dynamic> json) => AllAbsenModel(
        name: json["name"],
        id: json["id"],
        indentityIdUsers: json["indentity_id_users"],
        date: json["date"], 
        opened: json["opened"]??'',
        closed: json["closed"]??'',
        image: json["image"]??'',
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
        "indentity_id_users": indentityIdUsers,
        "date": date,
        "opened": opened,
        "closed": closed,
        "image": image,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
