import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:is_it_safe_app/src/core/interfaces/safe_bloc.dart';

import '../../../../core/constants/assets_constants.dart';
import '../../../../core/constants/string_constants.dart';

class SafeProfilePictureBloC extends SafeBloC {
  List<String> listProfilePicturePaths = [];
  String selectedProfilePhoto = StringConstants.empty;
  late StreamController<String> profilePictureController;

  SafeProfilePictureBloC() {
    init();
  }

  @override
  Future<void> init() async {
    profilePictureController = StreamController.broadcast();
  }

  Future<void> getProfilePicturePathsList(BuildContext context) async {
    listProfilePicturePaths.clear();
    final assetManifestJson =
        await DefaultAssetBundle.of(context).loadString('AssetManifest.json');
    final List<String> profilePicturePaths = json
        .decode(assetManifestJson)
        .keys
        .where((String key) =>
            key.startsWith(AssetConstants.general.profilePictures))
        .toList();
    listProfilePicturePaths.addAll(profilePicturePaths);
  }

  void setProfilePicture(String path) {
    selectedProfilePhoto = path;
    profilePictureController.sink.add(path);
  }

  @override
  Future<void> dispose() async {
    profilePictureController.close();
  }
}
