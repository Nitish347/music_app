// To parse this JSON data, do
//
//     final avatarModel = avatarModelFromJson(jsonString);

import 'dart:convert';

AvatarModel avatarModelFromJson(String str) => AvatarModel.fromJson(json.decode(str));

String avatarModelToJson(AvatarModel data) => json.encode(data.toJson());

class AvatarModel {
  String? avatar;
  String? avatarTop;
  String? mood;

  AvatarModel({
    this.avatar,
    this.avatarTop,
    this.mood,
  });

  factory AvatarModel.fromJson(Map<String, dynamic> json) => AvatarModel(
    avatar: json["avatar"],
    avatarTop: json["avatar_top"],
    mood: json["mood"],
  );

  Map<String, dynamic> toJson() => {
    "avatar": avatar,
    "avatar_top": avatarTop,
    "mood": mood,
  };
}
