// ignore_for_file: deprecated_member_use_from_same_package

import 'dart:async';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/src/app/modules/location/domain/usecases/get_locations_by_id_use_case.dart';
import 'package:is_it_safe_app/src/app/modules/review/presenter/pages/review_page.dart';
import 'package:is_it_safe_app/src/core/interfaces/safe_bloc.dart';
import 'package:is_it_safe_app/src/core/state/safe_stream.dart';
import 'package:is_it_safe_app/src/app/modules/location/domain/entities/location_entity.dart';
import 'package:is_it_safe_app/src/service/api/configuration/api_interceptors.dart';
import 'package:is_it_safe_app/src/service/api/error/error_exceptions.dart';

import '../../location_module.dart';

class LocationBloC extends SafeBloC {
  final GetLocationsByIdUseCase getLocationsByIdUseCase;

  final location = SafeStream<LocationEntity?>(data: null);

  LocationBloC({
    required this.getLocationsByIdUseCase,
  });

  @override
  Future<void> init() async {}

  Future<void> getLocationById(int? id) async {
    location.loading();
    try {
      if (id == null) {
        throw Exception(
          "Não foi possível capturar o estabelecimento.",
        );
      }
      final result = await getLocationsByIdUseCase.call(id);
      result.fold(
        (data) => location.data = data,
        (error) => throw Exception(error.message),
      );
    } on Exception catch (e) {
      if (e is UnauthorizedException) await ApiInterceptors.doLogout();
      location.error(e.toString());
      safeSnackBar.error(e.toString());
      location.show();
    }
  }

  void navigateToReviewPage() {
    Modular.to
        .pushNamed(
      LocationModule.route + ReviewPage.route,
      arguments: location.data,
    )
        .then((value) {
      if (value == true) {
        getLocationById(location.data?.id);
      }
    });
  }

  @override
  Future<void> dispose() async {
    location.data = null;
  }
}
