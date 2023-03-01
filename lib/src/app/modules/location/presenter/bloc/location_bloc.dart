import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:is_it_safe_app/generated/l10n.dart';
import 'package:is_it_safe_app/src/core/constants/string_constants.dart';
import 'package:is_it_safe_app/src/core/enum/location_type_enum.dart';
import 'package:is_it_safe_app/src/core/interfaces/safe_bloc.dart';
import 'package:is_it_safe_app/src/core/util/parse_enum.dart';
import 'package:is_it_safe_app/src/core/util/validation_util.dart';
import 'package:is_it_safe_app/src/domain/entity/location_entity.dart';
import 'package:is_it_safe_app/src/domain/use_case/get_locations_by_id_use_case.dart';
import 'package:is_it_safe_app/src/domain/use_case/save_location_use_case.dart';
import 'package:result_dart/result_dart.dart';

import '../../../../../components/config/safe_event.dart';
import '../../../../../service/api/configuration/api_interceptors.dart';
import '../../../../../service/api/error/error_exceptions.dart';

class LocationBloC extends SafeBloC {
  final GetLocationsByIdUseCase getLocationsByIdUseCase;
  final SaveLocationUseCase saveLocationUseCase;

  late StreamController<SafeEvent<LocationEntity>> locationByIDController;
  late LocationEntity locationById;

  late StreamController<SafeEvent<LocationEntity>> isSavingLocation;
  late ValueNotifier<String?> imageNotifier = ValueNotifier(null);

  late ValueNotifier<String> locationTypeNotifier = ValueNotifier(
    ParseEnum.parseLocationTypeEnum(LocationTypeEnum.pub),
  );

  late TextEditingController locationNameController;
  late TextEditingController locationCepController;
  late TextEditingController locationAddressFieldController;

  LocationBloC({
    required this.getLocationsByIdUseCase,
    required this.saveLocationUseCase,
  }) {
    init();
  }

  @override
  Future<void> init() async {
    locationByIDController = StreamController.broadcast();
    isSavingLocation = StreamController.broadcast();
    locationNameController = TextEditingController();
    locationCepController = TextEditingController();
    locationAddressFieldController = TextEditingController();
  }

  Future<void> getLocationById(int id) async {
    try {
      locationByIDController.add(SafeEvent.load());
      await getLocationsByIdUseCase.call(id).fold(
        (success) {
          locationById = success;
        },
        (error) {},
      );

      locationByIDController.add(SafeEvent.done(locationById));
    } on Exception catch (e) {
      if (e is UnauthorizedException) await ApiInterceptors.doLogout();
      locationByIDController.addError(e.toString());
    }
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
      await saveLocationUseCase
          .call(
        name: locationNameController.text,
        cep: locationCepController.text,
        locationTypeId: locationId + 1,
        imgUrl: imageNotifier.value,
      )
          .fold(
        (success) {
          isSavingLocation.add(SafeEvent.done(success));
        },
        (error) {},
      );
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
    locationByIDController.close();
    isSavingLocation.close();
    locationNameController = TextEditingController();
    locationCepController = TextEditingController();
    locationAddressFieldController = TextEditingController();
  }
}
