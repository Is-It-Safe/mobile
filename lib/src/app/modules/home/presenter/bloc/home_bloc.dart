import 'dart:async';

import 'package:catcher_2/catcher_2.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:geocoding/geocoding.dart';
import 'package:is_it_safe_app/generated/l10n.dart';

import 'package:is_it_safe_app/src/app/modules/home/presenter/VOs/home_drawer_vo.dart';
import 'package:is_it_safe_app/src/app/modules/home/domain/usecases/get_best_rated_locations_use_case.dart';
import 'package:is_it_safe_app/src/app/modules/home/domain/usecases/get_locations_near_user_use_case.dart';
import 'package:is_it_safe_app/src/app/modules/location/domain/usecases/get_user_location_permission_use_case.dart';
import 'package:is_it_safe_app/src/app/modules/location/domain/usecases/save_user_location_permission_use_case.dart';
import 'package:is_it_safe_app/src/core/constants/string_constants.dart';
import 'package:is_it_safe_app/src/core/interfaces/safe_locator.dart';
import 'package:is_it_safe_app/src/core/util/safe_log_util.dart';
import 'package:is_it_safe_app/src/core/interfaces/safe_bloc.dart';
import 'package:is_it_safe_app/src/app/modules/location/domain/entities/location_entity.dart';
import 'package:is_it_safe_app/src/core/state/safe_stream.dart';
import 'package:is_it_safe_app/src/app/modules/home/domain/usecases/get_user_name_use_case.dart';
import 'package:is_it_safe_app/src/app/modules/home/domain/usecases/get_user_image_use_case.dart';
import 'package:is_it_safe_app/src/service/api/configuration/api_interceptors.dart';
import 'package:is_it_safe_app/src/service/api/error/error_exceptions.dart';
import 'package:is_it_safe_app/src/app/modules/home/domain/models/request/get_location_near_user_request.dart';

class HomeBloc extends SafeBloC {
  final GetBestRatedLocationsUseCase getBestRatedLocationsUseCase;
  final SaveUserLocationPermissionUseCase saveLocationPermissionUseCase;
  final GetUserLocationPermissionUseCase getLocationPermissionUseCase;
  final GetLocationsNearUser getLocationsNearUserUsecase;
  final SafeLocator safeLocator;
  final GetUserNameUseCase getUserNameUseCase;
  final GetUserImageUseCase getUserImageUseCase;

  final bestRatedPlaces = SafeStream<List<LocationEntity>>(data: []);
  final locationsNearUser = SafeStream<List<LocationEntity>>(data: []);
  final userDrawerData = SafeStream<HomeDrawerVO>(data: HomeDrawerVO.empty);
  final userLocation = SafeStream<Placemark?>(data: null);

  HomeBloc({
    required this.getBestRatedLocationsUseCase,
    required this.getLocationsNearUserUsecase,
    required this.safeLocator,
    required this.getUserNameUseCase,
    required this.getUserImageUseCase,
    required this.getLocationPermissionUseCase,
    required this.saveLocationPermissionUseCase,
  });

  @override
  Future<void> init() async {
    SafeLogUtil.instance.route(Modular.to.path);
    await getHomeDrawerInfo();
  }

  Future<void> saveLocationPermission({required bool value}) async {
    try {
      await saveLocationPermissionUseCase.call(value);
    } catch (e, stacktrace) {
      Catcher2.reportCheckedError(e, stacktrace);
      SafeLogUtil.instance.logError(e);
    }
  }

  Future<bool> getLocationPermission() async {
    try {
      return await getLocationPermissionUseCase.call();
    } catch (e, stacktrace) {
      Catcher2.reportCheckedError(e, stacktrace);
      SafeLogUtil.instance.logError(e);
    }
    return false;
  }

  Future<void> getUserLocationAndNearPlaces() async {
    Placemark? placemark = await getUserLocation();
    if (placemark != null) await getLocationsNearUser();
  }

  Future<void> getHomeDrawerInfo() async {
    userDrawerData.loading();
    try {
      final userName = await getUserNameUseCase.call();
      final userImage = await getUserImageUseCase.call();
      userDrawerData.data = userDrawerData.data.copyWith(
        userName: userName,
        userImage: userImage,
      );
    } catch (e, stacktrace) {
      Catcher2.reportCheckedError(e, stacktrace);
      SafeLogUtil.instance.logError(e);
      userDrawerData.error(S.current.textErrorToLoadTheUsersInformation);
    }
  }

  Future<Placemark?> getUserLocation() async {
    try {
      userLocation.data = await safeLocator.getLocation();
      return userLocation.data;
    } catch (e, stacktrace) {
      Catcher2.reportCheckedError(e, stacktrace);
      SafeLogUtil.instance.logError(e);
    }
    return null;
  }

  Future<String?> get userCity async {
    try {
      if (userLocation.data != null) {
        return userLocation.data?.locality;
      }
    } catch (e, stacktrace) {
      Catcher2.reportCheckedError(e, stacktrace);
      SafeLogUtil.instance.logError(e);
    }
    return null;
  }

  Future<void> getBestRatedPlaces() async {
    bestRatedPlaces.loading();
    try {
      final result = await getBestRatedLocationsUseCase.call(
        place: await userCity,
      );

      bestRatedPlaces.data.clear();
      bestRatedPlaces.data = result;

      bestRatedPlaces.show();
    } on Exception catch (e, stacktrace) {
      Catcher2.reportCheckedError(e, stacktrace);
      if (e is UnauthorizedException) await ApiInterceptors.doLogout();
      bestRatedPlaces.error(e.toString());
    }
  }

  Future<void> getLocationsNearUser() async {
    locationsNearUser.loading();
    try {
      final location = await safeLocator.kUserPosition;
      final result = await getLocationsNearUserUsecase.call(
        request: GetLocationNearUserRequest(
          latitude: location.latitude,
          longitude: location.longitude,
        ),
      );

      locationsNearUser.data.clear();
      locationsNearUser.data = result;
      locationsNearUser.show();
    } on Exception catch (e, stacktrace) {
      Catcher2.reportCheckedError(e, stacktrace);
      SafeLogUtil.instance.logError(e);
      locationsNearUser.error(e.toString());
    }
  }

  onTabIndexChange(int index) async {
    switch (index) {
      case 0:
        await getLocationsNearUser();
        break;
      case 1:
        await getBestRatedPlaces();
        break;
    }
  }

  @override
  Future<void> dispose() async {
    bestRatedPlaces.data.clear();
    locationsNearUser.data.clear();
  }
}
