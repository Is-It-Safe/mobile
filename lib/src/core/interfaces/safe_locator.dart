import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

abstract class ISafeLocator {
  Future<bool> verifyPermission();
  Future<Placemark?> getLocation();
  Future<Position> get kUserPosition;
}
