// To parse this JSON data, do
//
//     final songModel = songModelFromJson(jsonString);

import 'dart:convert';

SongModel songModelFromJson(String str) => SongModel.fromJson(json.decode(str));

String songModelToJson(SongModel data) => json.encode(data.toJson());

class SongModel {
  int? id;
  String? name;
  String? assetPath;
  String? image;
  String? type;

  SongModel({
    this.id,
    this.name,
    this.assetPath,
    this.image,
    this.type,
  });

  factory SongModel.fromJson(Map<String, dynamic> json) => SongModel(
    id: json["id"],
    name: json["name"],
    assetPath: json["assetPath"],
    image: json["image"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "assetPath": assetPath,
    "image": image,
    "type": type,
  };
}
