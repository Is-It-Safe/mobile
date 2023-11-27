import 'package:is_it_safe_app/generated/l10n.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_snack_bar.dart';
import 'package:is_it_safe_app/src/core/interfaces/safe_locator.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class SafeLocatorImpl implements SafeLocator {
  final ISafeSnackBar safeSnackBar = SafeSnackBar();

  @override
  Future<Placemark?> getLocation() async {
    List<Placemark> placemarks = [];
    final bool isPermission = await verifyPermission();
    if (isPermission) {
      final Position userPosition = await kUserPosition;

      placemarks = await GeocodingPlatform.instance.placemarkFromCoordinates(
        userPosition.latitude,
        userPosition.longitude,
      );

      return placemarks.first;
    }
    return null;
  }

  @override
  Future<Position> get kUserPosition async {
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  @override
  Future<bool> verifyPermission() async {
    LocationPermission permission;

    await _isLocationServiceEnabled();

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      return true;
    }
    return false;
  }

  Future<bool> _isLocationServiceEnabled() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (serviceEnabled == false) {
      safeSnackBar.alert(S.current.textDeniedServiceLocation);
    }

    return serviceEnabled;
  }

  bool _onPermissionDenied() {
    safeSnackBar.alert(S.current.textDeniedPermissionLocation);
    return false;
  }

  @override
  Future<bool> requestPermission() async {
    final permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      final result = await Geolocator.requestPermission();
      if (result == LocationPermission.deniedForever ||
          result == LocationPermission.denied) {
        return _onPermissionDenied();
      }
    } else if (permission == LocationPermission.deniedForever ||
        permission == LocationPermission.denied) {
      return _onPermissionDenied();
    }
    return true;
  }
}
