import 'package:is_it_safe_app/src/core/interfaces/safe_locator.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class SafeLocator implements ISafeLocator {
  @override
  Future<Placemark?> getLocation({Function? onLocationDenied}) async {
    final Position? userPosition = await getLastKnownPosition(
      onLocationDenied: onLocationDenied,
    );
    if (userPosition != null) {
      List<Placemark> resultList =
          await GeocodingPlatform.instance.placemarkFromCoordinates(
        userPosition.latitude,
        userPosition.longitude,
      );
      return resultList.first;
    }
    return null;
  }

  @override
  Future<List<Placemark>> getLocationList({Function? onLocationDenied}) async {
    final Position? userPosition = await getLastKnownPosition(
      onLocationDenied: onLocationDenied,
    );
    if (userPosition != null) {
      List<Placemark> resultList =
          await GeocodingPlatform.instance.placemarkFromCoordinates(
        userPosition.latitude,
        userPosition.longitude,
      );
      return resultList;
    }
    return List.empty();
  }

  @override
  Future<Position?> getLastKnownPosition({Function? onLocationDenied}) async {
    final locationPermission = await Geolocator.checkPermission();
    if (locationPermission == LocationPermission.denied ||
        locationPermission == LocationPermission.deniedForever) {
      if (onLocationDenied != null) {
        onLocationDenied();
      }
      return null;
    }
    return Geolocator.getLastKnownPosition();
  }

  @override
  Future<Stream<Position>> getLocationStream({Duration? timeLimit}) async {
    final bool isLocationEnabled = await verifyPermission();
    if (isLocationEnabled) {
      return Geolocator.getPositionStream(
        locationSettings: LocationSettings(
          accuracy: LocationAccuracy.best,
          distanceFilter: 10,
          timeLimit: timeLimit ?? const Duration(days: 5),
        ),
      );
    }
    return const Stream.empty();
  }

  @override
  Future<bool> requestPermission() => Geolocator.openLocationSettings();

  @override
  Future<bool> verifyPermission({Function? onLocationDenied}) async {
    final locationPermission = await Geolocator.checkPermission();
    if (locationPermission == LocationPermission.denied ||
        locationPermission == LocationPermission.deniedForever) {
      if (onLocationDenied != null) {
        onLocationDenied();
      }
      return false;
    }
    return true;
  }
}
