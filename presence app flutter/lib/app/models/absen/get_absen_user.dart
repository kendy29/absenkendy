// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

GEtModelUser getModelUserFromJson(String str) => GEtModelUser.fromJson(json.decode(str));

String welcomeToJson(GEtModelUser data) => json.encode(data.toJson());

class GEtModelUser {
    GEtModelUser({
        required this.succes,
        required this.message,
         this.data,
    });

    bool succes;
    String message;
    List<ModelGetUser>? data;

    factory GEtModelUser.fromJson(Map<String, dynamic> json) => GEtModelUser(
        succes: json["succes"],
        message: json["message"],
        data:json["data"]==null?<ModelGetUser>[]: List<ModelGetUser>.from(json["data"].map((x) => ModelGetUser.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "succes": succes,
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class ModelGetUser {
    ModelGetUser({
        required this.id,
        required this.indentityIdUsers,
        required this.opened,
        required this.closed,
        required this.date,
        required this.createdAt,
        required this.updatedAt,
    });

    int id;
    int? indentityIdUsers;
    String? opened;
    String? closed;
    String? date;
    DateTime? createdAt;
    DateTime? updatedAt;

    factory ModelGetUser.fromJson(Map<String, dynamic> json) => ModelGetUser(
        id: json["id"],
        indentityIdUsers: json["indentity_id_users"]??0,
        opened: json["opened"]??"Belum Absen Masuk",
        closed: json["closed"]??"Belum Absen Pulang",
        date: json["date"]??"Silakan Absen Terlebih Dahulu",
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "indentity_id_users": indentityIdUsers,
        "opened": opened,
        "closed": closed,
        "date": date,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
    };
}
