import 'dart:async';

import 'package:is_it_safe_app/src/core/interfaces/safe_bloc.dart';
import 'package:is_it_safe_app/src/domain/entity/location_entity.dart';
import 'package:is_it_safe_app/src/domain/use_case/get_locations_by_id_use_case.dart';
import 'package:result_dart/result_dart.dart';

import '../../../../../components/config/safe_event.dart';
import '../../../../../service/api/configuration/api_interceptors.dart';
import '../../../../../service/api/error/error_exceptions.dart';

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

  @override
  Future<void> dispose() async {
    locationByIDController.close();
  }
}
