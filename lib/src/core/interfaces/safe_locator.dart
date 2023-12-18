import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

abstract class SafeLocator {
  Future<bool> verifyPermission();
  Future<bool> requestPermission();
  Future<Placemark?> getLocation();
  Future<Position> get kUserPosition;
}
