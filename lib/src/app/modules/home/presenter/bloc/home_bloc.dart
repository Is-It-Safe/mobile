import 'dart:async';

import 'package:catcher/catcher.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:is_it_safe_app/generated/l10n.dart';
import 'package:is_it_safe_app/src/app/modules/home/presenter/widgets/home_drawer.dart';
import 'package:is_it_safe_app/src/app/modules/location/domain/usecases/get_best_rated_locations_use_case.dart';
import 'package:is_it_safe_app/src/app/modules/location/domain/usecases/get_locations_near_user_use_case.dart';
import 'package:is_it_safe_app/src/core/constants/string_constants.dart';
import 'package:is_it_safe_app/src/core/interfaces/safe_locator.dart';
import 'package:is_it_safe_app/src/core/util/safe_log_util.dart';
import 'package:is_it_safe_app/src/core/interfaces/safe_bloc.dart';
import 'package:is_it_safe_app/src/app/modules/location/domain/entities/location_entity.dart';
import 'package:is_it_safe_app/src/components/config/safe_event.dart';
import 'package:is_it_safe_app/src/domain/use_case/get_user_location_use_case.dart';
import 'package:is_it_safe_app/src/domain/use_case/get_user_name_use_case.dart';
import 'package:is_it_safe_app/src/domain/use_case/get_user_image_use_case.dart';
import 'package:is_it_safe_app/src/domain/use_case/save_user_location_use_case.dart';
import 'package:is_it_safe_app/src/service/api/configuration/api_interceptors.dart';
import 'package:is_it_safe_app/src/service/api/error/error_exceptions.dart';
import '../../../../../domain/use_case/get_user_location_permission_usecase.dart';
import '../../../../../domain/use_case/save_user_location_permission_use_case.dart';

class HomeBloc extends SafeBloC {
  final GetBestRatedLocationsUseCase getBestRatedLocationsUseCase;
  final GetLocationsNearUser getLocationsNearUserUsecase;
  final SaveUserLocationTokenUseCase saveUserLocationTokenUseCase;
  final GetUserLocationTokenUseCase getUserLocationTokenUseCase;
  final SaveUserLocationPermissionFirstSettingsUseCase
      saveUserLocationPermissionFirstSettingsUseCase;
  final GetUserLocationPermissionUseCase
      getUserLocationPermissionFirstSettingsUseCase;
  final ISafeLocator locator;

  final GetUserNameUseCase getUserNameUseCase;
  final GetUserImageUseCase getUserImageUseCase;

  late StreamController<SafeStream<List<LocationEntity>>>
      bestRatedPlacesController;
  late StreamController<SafeStream<List<LocationEntity>>>
      locationsNearUserController;
  late StreamController<SafeStream<Placemark>> userLocationController;
  late StreamController<SafeStream<HomeDrawerVO>> userDrawerDataController;
  List<LocationEntity> listBestRatedPlaces = [];
  List<LocationEntity> listLocationsNeartUser = [];
  SafeStream<HomeDrawerVO> lastDrawerEvent = SafeStream.load();

  HomeBloc({
    required this.getBestRatedLocationsUseCase,
    required this.getLocationsNearUserUsecase,
    required this.saveUserLocationTokenUseCase,
    required this.getUserLocationTokenUseCase,
    required this.saveUserLocationPermissionFirstSettingsUseCase,
    required this.getUserLocationPermissionFirstSettingsUseCase,
    required this.locator,
    required this.getUserNameUseCase,
    required this.getUserImageUseCase,
  }) {
    init();
  }

  @override
  Future<void> init() async {
    bestRatedPlacesController = StreamController.broadcast();
    locationsNearUserController = StreamController.broadcast();
    userLocationController = StreamController.broadcast();
    userDrawerDataController = StreamController.broadcast();
    await getHomeDrawerInfo();
  }

  Future<void> getHomeDrawerInfo() async {
    userDrawerDataController.add(SafeStream.load());
    try {
      final userName = await getUserNameUseCase.call();
      final userImage = await getUserImageUseCase.call();
      final homeDrawerVO = HomeDrawerVO(
        userName: userName,
        userImage: userImage,
      );
      lastDrawerEvent = SafeStream.done(homeDrawerVO);
      return userDrawerDataController.add(lastDrawerEvent);
    } catch (e, stacktrace) {
      Catcher.reportCheckedError(e, stacktrace);
      SafeLogUtil.instance.logError(e);
    }
    return userDrawerDataController.add(
      SafeStream.done(
        HomeDrawerVO(
          userName: StringConstants.empty,
          userImage: StringConstants.empty,
        ),
      ),
    );
  }

  Future<Placemark?> getUserLocation() async {
    try {
      final userLocation = await getUserLocationTokenUseCase.call();
      return userLocation;
    } catch (e, stacktrace) {
      Catcher.reportCheckedError(e, stacktrace);
      SafeLogUtil.instance.logError(e);
    }
    return null;
  }

  Future<void> saveUserLocation({required Placemark userLocation}) async {
    try {
      await saveUserLocationTokenUseCase.call(userLocation);
    } catch (e, stacktrace) {
      Catcher.reportCheckedError(e, stacktrace);
      SafeLogUtil.instance.logError(e);
    }
  }

  Future<String> get userCity async {
    try {
      final userLocation = await getUserLocation();
      if (userLocation != null) {
        return userLocation.locality ?? StringConstants.empty;
      }
    } catch (e, stacktrace) {
      Catcher.reportCheckedError(e, stacktrace);
      SafeLogUtil.instance.logError(e);
    }
    return StringConstants.empty;
  }

  Future<void> getBestRatedPlaces() async {
    try {
      bestRatedPlacesController.add(SafeStream.load());
      await getBestRatedLocationsUseCase
          .call(place: await userCity)
          .then((locations) {
        listBestRatedPlaces.clear();
        listBestRatedPlaces.addAll(locations);
      });
      bestRatedPlacesController.add(SafeStream.done(listBestRatedPlaces));
    } on Exception catch (e, stacktrace) {
      Catcher.reportCheckedError(e, stacktrace);
      if (e is UnauthorizedException) await ApiInterceptors.doLogout();
      bestRatedPlacesController.addError(e.toString());
    }
  }

  Future<void> getLocationsNearUser() async {
    try {
      locationsNearUserController.add(SafeStream.load());
      final location = await Geolocator.getCurrentPosition();
      await getLocationsNearUserUsecase
          .call(location.latitude, location.longitude)
          .then((locations) {
        listLocationsNeartUser.clear();
        listLocationsNeartUser.addAll(locations);
      });
      locationsNearUserController.add(SafeStream.done(listLocationsNeartUser));
    } on Exception catch (e, stacktrace) {
      Catcher.reportCheckedError(e, stacktrace);
      SafeLogUtil.instance.logError(e);
      if (e.toString() == S.current.textErrorDeniedPermissionLocation) {
        locationsNearUserController
            .addError(S.current.textDeniedPermissionLocation);
      } else if (e.toString() == S.current.textErrorDeniedServiceLocation) {
        locationsNearUserController
            .addError(S.current.textDeniedServiceLocation);
      } else {
        locationsNearUserController.addError(e.toString());
      }
    }
  }

  Future<bool> verifyLocationPermission() async {
    return await locator.verifyPermission();
  }

  Future<void> getCurrentLocation({bool forceRequest = false}) async {
    final Placemark? userLocation =
        await locator.getLocation(onLocationDenied: () async {
      await _getUserAlreadyRequestedLocationPermission()
          .then((alreadySeeIt) async {
        if (!alreadySeeIt) {
          await locator.requestPermission();
        }
        if (forceRequest) {
          await locator.requestPermission();
        }
      });
    });
    if (userLocation != null) {
      await saveUserLocation(userLocation: userLocation);
      userLocationController.sink.add(SafeStream.done(userLocation));
    }
  }

  Future<bool> _getUserAlreadyRequestedLocationPermission() async {
    try {
      final permission =
          await getUserLocationPermissionFirstSettingsUseCase.call();
      return permission;
    } catch (e, stacktrace) {
      Catcher.reportCheckedError(e, stacktrace);
      SafeLogUtil.instance.logError(e);
    }
    return false;
  }

  Future<void> _saveUserAlreadyRequestedLocationPermission(
      bool alreadySeeIt) async {
    try {
      await saveUserLocationPermissionFirstSettingsUseCase.call(alreadySeeIt);
    } catch (e, stacktrace) {
      Catcher.reportCheckedError(e, stacktrace);
      SafeLogUtil.instance.logError(e);
    }
  }

  Future<bool> _requestAppLocationPermission() async {
    bool granted = false;
    await getCurrentLocation();
    if (!(await _getUserAlreadyRequestedLocationPermission())) {
      _saveUserAlreadyRequestedLocationPermission(true);
      await Future.doWhile(() async {
        granted = !(await verifyLocationPermission());
        return granted;
      });
    }
    return !granted;
  }

  Future<bool> forcedRequestLocationPermission() async {
    bool granted = false;
    await getCurrentLocation(forceRequest: true);
    await Future.doWhile(() async {
      granted = !(await verifyLocationPermission());
      return granted;
    });
    return !granted;
  }

  Future<void> requestAccessLocationPermission() async {
    await _requestAppLocationPermission().then((granted) async {
      if (granted) {
        await getLocationsNearUser();
      }
    });
  }

  onTabIndexChange(int index) async {
    switch (index) {
      case 0:
        await requestAccessLocationPermission();
        break;
      case 1:
        await getBestRatedPlaces();
        break;
    }
  }

  @override
  Future<void> dispose() async {
    bestRatedPlacesController.close();
    locationsNearUserController.close();
  }
}
