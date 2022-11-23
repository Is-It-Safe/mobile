import 'dart:async';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:is_it_safe_app/src/core/interfaces/safe_locator.dart';
import 'package:is_it_safe_app/src/domain/use_case/get_best_rated_places_use_case.dart';
import 'package:is_it_safe_app/src/core/interfaces/safe_bloc.dart';
import 'package:is_it_safe_app/src/domain/entity/location_entity.dart';
import 'package:is_it_safe_app/src/components/config/safe_event.dart';

import 'package:is_it_safe_app/src/service/api/configuration/api_interceptors.dart';
import 'package:is_it_safe_app/src/service/api/error/error_exceptions.dart';

class HomeBloc extends SafeBloC {
  final GetBestRatedPlacesUseCase getBestRatedPlacesUseCase;
  final ISafeLocator safeLocatorContract;

  late StreamController<SafeEvent<List<LocationEntity>>>
      bestRatedPlacesController;
  late StreamController<SafeEvent<Placemark>> userLocationController;
  List<LocationEntity> listBestRatedPlaces = [];

  HomeBloc({
    required this.getBestRatedPlacesUseCase,
    required this.safeLocatorContract,
  }) {
    init();
  }

  @override
  Future<void> init() async {
    bestRatedPlacesController = StreamController.broadcast();
    userLocationController = StreamController.broadcast();
  }

  Future<void> getBestRatedPlaces() async {
    try {
      //TODO Somente chamar a api mediante um isRefresh == true ou caso listBestRatedLocations esteja vazia
      bestRatedPlacesController.add(SafeEvent.load());
      listBestRatedPlaces = await getBestRatedPlacesUseCase.call('Salvador');
      bestRatedPlacesController.add(SafeEvent.done(listBestRatedPlaces));
    } on Exception catch (e) {
      if (e is UnauthorizedException) await ApiInterceptors.doLogout();
      bestRatedPlacesController.addError(e.toString());
    }
  }

  Future<void> getCurrentLocation() async {
    final Placemark? userLocation = await safeLocatorContract.getLocation(
      onLocationDenied: () => userLocationController.sink.addError(
        const LocationServiceDisabledException(),
      ),
    );
    if (userLocation != null) {
      userLocationController.sink.add(
        SafeEvent.done(
          userLocation,
        ),
      );
    }
  }

  @override
  Future<void> dispose() async {
    bestRatedPlacesController.close();
  }
}
