import 'dart:async';

import 'package:flutter/material.dart';
import 'package:is_it_safe_app/src/components/config/safe_event.dart';
import 'package:is_it_safe_app/src/core/interfaces/safe_bloc.dart';
import 'package:image_picker/image_picker.dart';

class AddLocaleBloc extends SafeBloC {
  ValueNotifier<String?> imageNotifier = ValueNotifier(null);

  StreamController<SafeEvent>? addLocaleController;

  @override
  Future<void> dispose() async {
    addLocaleController?.close();
  }

  @override
  Future<void> init() async {
    addLocaleController = StreamController.broadcast();
  }

  Future<String?> handleCameraTap() async {
    final XFile? photo = await ImagePicker().pickImage(source: ImageSource.camera);
    if (photo != null && photo.path.isNotEmpty) {
      return photo.path;
    }
    return null;
  }

  Future<void> sendNewLocation() async {

  }
}