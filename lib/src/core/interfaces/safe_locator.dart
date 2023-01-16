import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

abstract class ISafeLocator {
  Future<List<Placemark>?> getLocationList({Function? onLocationDenied});
  Future<Placemark?> getLocation({Function? onLocationDenied});
  Future<bool> verifyPermission({Function? onLocationDenied});
  Future<void> requestPermission();
  Future<Stream<Position>> getLocationStream({Duration? timeLimit});
  Future<void> getLastKnownPosition({Function? onLocationDenied});
}