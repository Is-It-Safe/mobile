import 'dart:async';

import 'package:flutter/material.dart';
import 'package:is_it_safe_app/src/components/config/safe_event.dart';
import 'package:is_it_safe_app/src/core/enum/location_type_enum.dart';
import 'package:is_it_safe_app/src/core/interfaces/safe_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:is_it_safe_app/src/core/util/parse_enum.dart';
import 'package:is_it_safe_app/src/domain/entity/location_entity.dart';
import 'package:is_it_safe_app/src/domain/use_case/save_location_use_case.dart';

class SaveLocationBloc extends SafeBloC {
  final SaveLocationUseCase saveLocationUseCase;

  SaveLocationBloc({
    required this.saveLocationUseCase,
  });

  ValueNotifier<String?> imageNotifier = ValueNotifier(null);

  StreamController<SafeEvent<LocationEntity>>? isSavingLocation;

  TextEditingController localeNameController = TextEditingController();
  TextEditingController localeCepController = TextEditingController();
  TextEditingController localeAddressFieldController = TextEditingController();

  ValueNotifier<String> locationTypeNotifier = ValueNotifier(
    ParseEnum.parseLocationTypeEnum(
      LocationTypeEnum.pub,
    ),
  );

  @override
  Future<void> init() async {
    isSavingLocation = StreamController.broadcast();
  }

  Future<String?> handleCameraTap() async {
    final XFile? photo =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (photo != null && photo.path.isNotEmpty) {
      return photo.path;
    }
    return null;
  }

  Future<bool> sendNewLocation() async {
    try {
      isSavingLocation?.add(SafeEvent.load());
      int locationId = LocationTypeEnum.values.indexWhere(
        (element) =>
            ParseEnum.parseLocationTypeEnum(element) ==
            locationTypeNotifier.value,
      );
      final result = await saveLocationUseCase(
        name: localeNameController.text,
        cep: localeCepController.text,
        locationTypeId: locationId + 1,
        imgUrl: imageNotifier.value,
      );
      isSavingLocation?.add(SafeEvent.done(result));
      return true;
    } catch (e) {
      isSavingLocation?.addError(e.toString());
      return false;
    }
  }

  @override
  Future<void> dispose() async {
    isSavingLocation?.close();
  }
}
