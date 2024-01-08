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
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController locationNameController = TextEditingController();
  TextEditingController locationCepController = TextEditingController();
  TextEditingController locationAddressFieldController =
      TextEditingController();

  void closeDrawer() {
    _scaffoldKey.currentState!.closeDrawer();
  }

  ValueNotifier<String?> errorMessageNotifier = ValueNotifier<String?>(null);

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

  Future<String?> getLocationByCep(String? zipCode) async {
    String? errorMessage;

    try {
      final result = await getLocationsByCepUseCase.call(
        zipCode: UtilBrasilFields.removeCaracteres(locationCepController.text),
      );

      result.fold(
        (success) {
          if (success.isErro ?? false) {
            errorMessage = S.current.textErrorZipCode;
          }
          location.data = success;
        },
        (error) {
          location.data = null;
          location.show();
          location.error(error.message);
          errorMessage;
        },
      );
    } catch (e) {
      location.data = null;
      errorMessage = S.current.textErrorZipCode;
    }

    return errorMessage;
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
        address: locationAddressFieldController.text,
      );
      result.fold(
        (success) {
          location.data = success;
          Modular.to.pop();
        },
        (error) {
          Modular.to.pop();
          closeDrawer();
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
    if (!(value ?? StringConstants.empty).isName || value == null) {
      return S.current.textErrorEmptyField;
    } else if (value.length < 10) {
      return S.current.textErrorZipCode;
    } else if (location.data?.isErro == true || location.data?.isErro == null) {
      return errorMessageNotifier.value;
    }
    return null;
  }

  @override
  Future<void> dispose() async {
    location.data = null;
    locationNameController = TextEditingController();
    locationCepController = TextEditingController();
    locationAddressFieldController = TextEditingController();
  }
}
