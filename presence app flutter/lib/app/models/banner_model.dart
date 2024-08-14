// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

BannerModel bannerFromJson(String str) => BannerModel.fromJson(json.decode(str));

String bannerToJson(BannerModel data) => json.encode(data.toJson());

class BannerModel {
    bool succes;
    String message;
    List<ListBanner> data;

    BannerModel({
        required this.succes,
        required this.message,
        required this.data,
    });

    factory BannerModel.fromJson(Map<String, dynamic> json) => BannerModel(
        succes: json["succes"],
        message: json["message"],
        data:json["data"]==null?<ListBanner>[]: List<ListBanner>.from(json["data"].map((x) => ListBanner.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "succes": succes,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class ListBanner {
    int count;
    String name;

    ListBanner({
        required this.count,
        required this.name,
    });

    factory ListBanner.fromJson(Map<String, dynamic> json) => ListBanner(
        count: json["count"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "count": count,
        "name": name,
    };
}
