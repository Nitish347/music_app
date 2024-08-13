import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task1/data/app_url.dart';
import 'package:task1/data/network/network_api_services.dart';
import 'package:task1/models/song_model.dart';
import 'package:task1/utils/avatars.dart';

import '../../models/avatar_model.dart';

class SongsControllers extends GetxController {
  RxList<AvatarModel> avatars = <AvatarModel>[].obs;
  RxList<SongModel> songs = <SongModel>[].obs;
  RxBool avatarLoading = false.obs;
  RxBool songLoading = false.obs;

  void getAvatar() {
    avatarLoading.value = true;
    for (var avatar in Avatars.avatars) {
      AvatarModel avatarModel = AvatarModel.fromJson(avatar);
      avatars.add(avatarModel);
    }
    avatarLoading.value = false;
  }

   getSongs({required String mood}) async {
    songLoading.value = true;
    var res = await NetworkApiServices().getApi(AppUrl.baseUrl + mood);
    for (var song in res["data"]) {
      SongModel songModel = SongModel.fromJson(song);
      songs.add(songModel);
    }
    songLoading.value = false;
  }
}
