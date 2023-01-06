import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../../generated/l10n.dart';
import '../../../../../components/config/safe_event.dart';
import '../../../../../core/constants/string_constants.dart';
import '../../../../../core/enum/location_type_enum.dart';
import '../../../../../core/interfaces/safe_bloc.dart';
import '../../../../../core/util/parse_enum.dart';
import '../../../../../core/util/validation_util.dart';
import '../../../../../domain/entity/location_entity.dart';
import '../../../../../domain/use_case/save_location_use_case.dart';

class SaveLocationBloc extends SafeBloC {
  final SaveLocationUseCase saveLocationUseCase;

  late StreamController<SafeEvent<LocationEntity>> isSavingLocation;

  late ValueNotifier<String?> imageNotifier = ValueNotifier(null);

  late TextEditingController locationNameController;
  late TextEditingController locationCepController;
  late TextEditingController locationAddressFieldController;

  late ValueNotifier<String> locationTypeNotifier = ValueNotifier(
    ParseEnum.parseLocationTypeEnum(LocationTypeEnum.pub),
  );

  SaveLocationBloc({
    required this.saveLocationUseCase,
  }) {
    init();
  }

  @override
  Future<void> init() async {
    isSavingLocation = StreamController.broadcast();
    locationNameController = TextEditingController();
    locationCepController = TextEditingController();
    locationAddressFieldController = TextEditingController();
  }

  Future<String?> handleCameraTap() async {
    final XFile? photo = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 5,
    );
    if (photo != null && photo.path.isNotEmpty) {
      return photo.path;
    }
    return null;
  }

  Future<bool> sendNewLocation() async {
    try {
      isSavingLocation.add(SafeEvent.load());
      int locationId = LocationTypeEnum.values.indexWhere(
        (element) =>
            ParseEnum.parseLocationTypeEnum(element) ==
            locationTypeNotifier.value,
      );
      final response = await saveLocationUseCase(
        name: locationNameController.text,
        cep: locationCepController.text,
        locationTypeId: locationId + 1,
        imgUrl: imageNotifier.value,
      );
      isSavingLocation.add(SafeEvent.done(response));
      return true;
    } catch (e) {
      isSavingLocation.addError(e.toString());
      return false;
    }
  }

  validateTextField(String? value) {
    if (!ValidationUtil.name(value ?? StringConstants.empty) || value == null) {
      return S.current.textErrorEmptyField;
    }
    return null;
  }

  @override
  Future<void> dispose() async {
    isSavingLocation.close();
    locationNameController = TextEditingController();
    locationCepController = TextEditingController();
    locationAddressFieldController = TextEditingController();
  }
}
