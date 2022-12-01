import 'dart:async';

import 'package:flutter/material.dart';
import 'package:is_it_safe_app/src/components/config/safe_event.dart';
import 'package:is_it_safe_app/src/core/enum/location_type_enum.dart';
import 'package:is_it_safe_app/src/core/interfaces/safe_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:is_it_safe_app/src/core/util/parse_enum.dart';
import 'package:is_it_safe_app/src/domain/use_case/save_location_use_case.dart';
import 'package:is_it_safe_app/src/service/api/modules/add_location/response/request_add_location.dart';

class AddLocaleBloc extends SafeBloC {
  final SaveLocationUseCase saveLocationUseCase;

  AddLocaleBloc({
    required this.saveLocationUseCase,
  });

  ValueNotifier<String?> imageNotifier = ValueNotifier(null);

  StreamController<SafeEvent<bool>>? isSavingLocation;

  TextEditingController localeNameController = TextEditingController();
  TextEditingController localeCepController = TextEditingController();
  TextEditingController localeAddressFieldController = TextEditingController();

  ValueNotifier<String> locationTypeNotifier = ValueNotifier(
    ParseEnum.parseLocationTypeEnum(
      LocationTypeEnum.pub,
    ),
  );

  @override
  Future<void> dispose() async {
    isSavingLocation?.close();
  }

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

  Future<void> sendNewLocation() async {
    isSavingLocation?.add(SafeEvent.load());
    int locationId = LocationTypeEnum.values.indexWhere(
      (element) =>
          ParseEnum.parseLocationTypeEnum(element) ==
          locationTypeNotifier.value,
    );
    final result = await saveLocationUseCase(
      request: RequestAddLocation(
        name: localeNameController.text,
        cep: localeCepController.text,
        locationTypeId: locationId,
        imgUrl: imageNotifier.value,
      ),
    );
    if (result == true) {
      isSavingLocation?.add(SafeEvent.done(true));
    }
  }
}
