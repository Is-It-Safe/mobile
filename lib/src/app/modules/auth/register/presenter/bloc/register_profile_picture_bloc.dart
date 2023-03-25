import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:is_it_safe_app/src/app/modules/auth/register/presenter/store/register_store.dart';
import 'package:is_it_safe_app/src/core/constants/assets_constants.dart';
import 'package:is_it_safe_app/src/core/constants/string_constants.dart';
import 'package:is_it_safe_app/src/core/interfaces/safe_bloc.dart';

class RegisterProfilePictureBloc extends SafeBloC {
  final RegisterStore store;

  RegisterProfilePictureBloc({
    required this.store,
  });

  @override
  Future<void> init() async {}

  Future<void> getProfilePicturePathsList(BuildContext context) async {
    store.listProfilePicturePaths.data.clear();

    final assetManifestJson = await DefaultAssetBundle.of(context).loadString(
      StringConstants.assetsManifestPath,
    );

    final List<String> profilePicturePaths = json
        .decode(assetManifestJson)
        .keys
        .where((String key) =>
            key.startsWith(AssetConstants.general.profilePictures))
        .toList();
    store.listProfilePicturePaths.data = profilePicturePaths;
  }

  void setProfilePicture(String path) {
    store.selectedProfilePhoto.data = path;
  }

  void setTempProfilePicture(String path) {
    store.temporarySelectedProfilePhoto.data = path;
  }

  @override
  Future<void> dispose() async {}
}
