import 'dart:async';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:is_it_safe_app/generated/l10n.dart';
import 'package:is_it_safe_app/src/app/modules/location/domain/usecases/get_location_by_cep_use_case.dart';
import 'package:is_it_safe_app/src/core/constants/string_constants.dart';
import 'package:is_it_safe_app/src/core/enum/location_type_enum.dart';
import 'package:is_it_safe_app/src/core/extentions/validation_extentions.dart';
import 'package:is_it_safe_app/src/core/interfaces/safe_bloc.dart';
import 'package:is_it_safe_app/src/core/state/safe_stream.dart';
import 'package:is_it_safe_app/src/app/modules/location/domain/entities/location_entity.dart';
import 'package:is_it_safe_app/src/app/modules/location/domain/usecases/save_location_use_case.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/src/core/util/safe_log_util.dart';

class SaveLocationBloC extends SafeBloC {
  final SaveLocationUseCase saveLocationUseCase;
  final GetLocationByCepUseCase getLocationsByCepUseCase;

  final location = SafeStream<LocationEntity?>(data: null);
  final locationType = SafeStream<LocationTypeEnum>(data: LocationTypeEnum.pub);
  late ValueNotifier<String?> imageNotifier = ValueNotifier(null);

  TextEditingController locationNameController = TextEditingController();
  TextEditingController locationCepController = TextEditingController();
  TextEditingController locationAddressFieldController =
      TextEditingController();

  SaveLocationBloC({
    required this.saveLocationUseCase,
    required this.getLocationsByCepUseCase,
  });

  @override
  Future<void> init() async {
    SafeLogUtil.instance.route(Modular.to.path);
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

  Future<String> getLocationByCep(String? cep) async {
    try {
      final result = await getLocationsByCepUseCase.call(
          cep: UtilBrasilFields.removeCaracteres(locationCepController.text));

      result.fold(
        (success) {
          location.data = success;
          Modular.to.pop();
          safeSnackBar.success(S.current.textSuccessSaveLocation);
        },
        (error) {
          Modular.to.pop();
          location.show();
          location.error(error.message);
          safeSnackBar.error(S.current.textErrorZipCode);
        },
      );
    } catch (e) {
      S.current.textErrorZipCode;
    }
    return '';
  }

  Future<void> sendNewLocation() async {
    try {
      location.loading();
      int locationId = LocationTypeEnum.values.indexWhere(
        (element) => locationType.data.name == element.name,
      );
      final result = await saveLocationUseCase.call(
        name: locationNameController.text,
        cep: UtilBrasilFields.removeCaracteres(locationCepController.text),
        locationTypeId: locationId + 1,
        imgUrl: imageNotifier.value,
      );
      result.fold(
        (success) {
          location.data = success;
          Modular.to.pop();
          safeSnackBar.success(S.current.textSuccessSaveLocation);
        },
        (error) {
          Modular.to.pop();
          location.show();
          location.error(error.message);
          safeSnackBar.error(S.current.textFailedToSaveLocation);
        },
      );
    } catch (e) {
      Modular.to.pop();
      location.show();
      location.error(e.toString());
      safeSnackBar.error(S.current.textErrorZipCode);
    }
  }

  validateTextField(String? value) {
    if (!(value ?? StringConstants.empty).isName || value == null) {
      return S.current.textErrorEmptyField;
    }
    return null;
  }

  validateZipcode(String? value) {
    if (value == null || value.isEmpty) {
      return S.current.textErrorEmptyField;
    } else if (value.length < 10 || value == '') {
      return S.current.textErrorZipCode;
    }
    return '';
  }

  @override
  Future<void> dispose() async {
    location.data = null;
    locationNameController = TextEditingController();
    locationCepController = TextEditingController();
    locationAddressFieldController = TextEditingController();
  }
}
