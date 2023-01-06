import 'dart:async';

import 'package:is_it_safe_app/src/core/interfaces/safe_bloc.dart';
import 'package:is_it_safe_app/src/domain/entity/location_entity.dart';
import 'package:is_it_safe_app/src/domain/use_case/get_locations_by_id_use_case.dart';

import '../../../../../components/config/safe_event.dart';
import '../../../../../service/api/configuration/api_interceptors.dart';
import '../../../../../service/api/error/error_exceptions.dart';

import 'package:flutter/material.dart';
import 'package:is_it_safe_app/generated/l10n.dart';
import 'package:is_it_safe_app/src/components/config/safe_event.dart';
import 'package:is_it_safe_app/src/core/constants/string_constants.dart';
import 'package:is_it_safe_app/src/core/enum/location_type_enum.dart';
import 'package:is_it_safe_app/src/core/interfaces/safe_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:is_it_safe_app/src/core/util/parse_enum.dart';
import 'package:is_it_safe_app/src/core/util/validation_util.dart';
import 'package:is_it_safe_app/src/domain/entity/location_entity.dart';
import 'package:is_it_safe_app/src/domain/use_case/save_location_use_case.dart';

class LocationBloC extends SafeBloC {
  final GetLocationsByIdUseCase getLocationsByIdUseCase;

  late StreamController<SafeEvent<LocationEntity>> locationByIDController;
  late LocationEntity locationById;

  LocationBloC({
    required this.getLocationsByIdUseCase,
  }) {
    init();
  }
 
    @override
  Future<void> init() async {
    locationByIDController = StreamController.broadcast();
  }

  Future<void> getLocationById(int id) async {
    try {
      locationByIDController.add(SafeEvent.load());
      await getLocationsByIdUseCase.call(id).then((location) {
        locationById = location;
      });
      locationByIDController.add(SafeEvent.done(locationById));
    } on Exception catch (e) {
      if (e is UnauthorizedException) await ApiInterceptors.doLogout();
      locationByIDController.addError(e.toString());
    }
  }

  @override
  Future<void> dispose() async {
    locationByIDController.close();
  }
 
 }


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
