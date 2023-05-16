import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

abstract class SafeLocator {
  Future<bool> verifyPermission();
  Future<Placemark?> getLocation();
  Future<Position> get kUserPosition;
}
