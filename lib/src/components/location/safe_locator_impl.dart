import 'package:catcher_2/catcher_2.dart';
import 'package:is_it_safe_app/generated/l10n.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_snack_bar.dart';
import 'package:is_it_safe_app/src/core/interfaces/safe_locator.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:is_it_safe_app/src/core/util/safe_log_util.dart';

class SafeLocatorImpl implements SafeLocator {
  final ISafeSnackBar safeSnackBar = SafeSnackBar();

  @override
  Future<Placemark?> getLocation() async {
    try {
      final Position userPosition = await kUserPosition;

      List<Placemark> placemarks =
          await GeocodingPlatform.instance.placemarkFromCoordinates(
        userPosition.latitude,
        userPosition.longitude,
        localeIdentifier: "en",
      );
      return placemarks.first;
    } on Exception catch (e, stacktrace) {
      Catcher2.reportCheckedError(e, stacktrace);
      SafeLogUtil.instance.logError(e);
    }
    return null;
  }

  @override
  Future<Position> get kUserPosition async {
    final lastKnownPosition = await Geolocator.getLastKnownPosition(
      forceAndroidLocationManager: true,
    );

    if (lastKnownPosition != null) return lastKnownPosition;

    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
      forceAndroidLocationManager: true,
      timeLimit: null,
    );
  }

  @override
  Future<bool> verifyPermission() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (serviceEnabled == false) {
      safeSnackBar.alert(S.current.textDeniedServiceLocation);
      return serviceEnabled;
    }

    return await requestPermission();
  }

  bool _onPermissionDenied() {
    safeSnackBar.alert(S.current.textDeniedPermissionLocation);
    return false;
  }

  @override
  Future<bool> requestPermission() async {
    await Geolocator.checkPermission().then((permission) async {
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();

        if (permission == LocationPermission.deniedForever) {
          return _onPermissionDenied();
        }
      }

      if (permission == LocationPermission.denied) {
        return _onPermissionDenied();
      }
    });

    return true;
  }
}
