import 'package:is_it_safe_app/core/model/location/location.dart';

abstract class HomeContract {
  Future<Locations> getBestRatedLocations();
  Future<Locations> getClosePlacesLocations();
}