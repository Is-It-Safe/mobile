import 'dart:async';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:is_it_safe_app/src/core/constants/string_constants.dart';
import 'package:is_it_safe_app/src/core/interfaces/safe_locator.dart';
import 'package:is_it_safe_app/src/core/util/safe_log_util.dart';
import 'package:is_it_safe_app/src/domain/use_case/get_best_rated_locations_use_case.dart';
import 'package:is_it_safe_app/src/core/interfaces/safe_bloc.dart';
import 'package:is_it_safe_app/src/domain/entity/location_entity.dart';
import 'package:is_it_safe_app/src/components/config/safe_event.dart';
import 'package:is_it_safe_app/src/domain/use_case/get_user_location_use_case.dart';
import 'package:is_it_safe_app/src/domain/use_case/save_user_location_use_case.dart';

import 'package:is_it_safe_app/src/service/api/configuration/api_interceptors.dart';
import 'package:is_it_safe_app/src/service/api/error/error_exceptions.dart';

class HomeBloc extends SafeBloC {
  final GetBestRatedLocationsUseCase getBestRatedLocationsUseCase;
  final SaveUserLocationTokenUseCase saveUserLocationTokenUseCase;
  final GetUserLocationTokenUseCase getUserLocationTokenUseCase;
  final ISafeLocator locator;

  late StreamController<SafeEvent<List<LocationEntity>>>
      bestRatedPlacesController;
  late StreamController<SafeEvent<Placemark>> userLocationController;
  List<LocationEntity> listBestRatedPlaces = [];

  HomeBloc({
    required this.getBestRatedLocationsUseCase,
    required this.saveUserLocationTokenUseCase,
    required this.getUserLocationTokenUseCase,
    required this.locator,
  }) {
    init();
  }

  @override
  Future<void> init() async {
    bestRatedPlacesController = StreamController.broadcast();
    userLocationController = StreamController.broadcast();
  }

  Future<Placemark?> getUserLocation() async {
    try {
      final userLocation = await getUserLocationTokenUseCase.call();
      return userLocation;
    } catch (e) {
      SafeLogUtil.instance.logError(e);
    }
    return null;
  }

  Future<void> saveUserLocation({required Placemark userLocation}) async {
    try {
      await saveUserLocationTokenUseCase.call(userLocation);
    } catch (e) {
      SafeLogUtil.instance.logError(e);
    }
  }

  Future<String> get userCity async {
    try {
      final userLocation = await getUserLocation();
      if (userLocation != null) {
        return userLocation.locality ?? StringConstants.empty;
      }
    } catch (e) {
      SafeLogUtil.instance.logError(e);
    }
    return StringConstants.empty;
  }

  Future<void> getBestRatedPlaces() async {
    try {
      bestRatedPlacesController.add(SafeEvent.load());
      listBestRatedPlaces =
          await getBestRatedLocationsUseCase.call(place: await userCity);
      bestRatedPlacesController.add(SafeEvent.done(listBestRatedPlaces));
    } on Exception catch (e) {
      if (e is UnauthorizedException) await ApiInterceptors.doLogout();
      bestRatedPlacesController.addError(e.toString());
    }
  }

  Future<void> getCurrentLocation() async {
    final Placemark? userLocation = await locator.getLocation(
      onLocationDenied: () => userLocationController.sink.addError(
        const LocationServiceDisabledException(),
      ),
    );
    if (userLocation != null) {
      await saveUserLocation(userLocation: userLocation);
      userLocationController.sink.add(SafeEvent.done(userLocation));
    }
  }

  @override
  Future<void> dispose() async {
    bestRatedPlacesController.close();
  }
}
