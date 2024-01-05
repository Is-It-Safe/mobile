import 'dart:convert';
import 'dart:io';

import 'package:is_it_safe_app/src/app/modules/location/domain/entities/request/request_get_location_by_cep.dart';
import 'package:is_it_safe_app/src/app/modules/location/domain/entities/request/request_save_location.dart';
import 'package:is_it_safe_app/src/app/modules/home/domain/models/response/response_get_best_rated_places.dart';
import 'package:is_it_safe_app/src/app/modules/location/domain/entities/response/response_get_location_by_id.dart';
import 'package:is_it_safe_app/src/app/modules/location/domain/entities/response/response_location_by_cep.dart';
import 'package:is_it_safe_app/src/app/modules/location/domain/entities/response/response_save_location.dart';
import 'package:is_it_safe_app/src/app/modules/location/services/location_service_interface.dart';

class MockLocationService implements ILocationService {
  @override
  Future<ResponseGetLocationsById> getLocationById(int id) {
    throw UnimplementedError();
  }

  @override
  Future<ResponseSaveLocation> saveLocation(RequestSaveLocation request) async {
    return ResponseSaveLocation.fromJson(
      jsonDecode(
          File("test/app/modules/location_module/savelocation_response.json")
              .readAsStringSync()),
    );
  }

  Future<List<ResponseGetRatedPlaces>> getBestRatedPlaces(String? place) {
    throw UnimplementedError();
  }

  @override
  Future<ResponseLocationByCep> getLocationByCep(RequestGetLocationByCep cep) {
    var jsonContent =
        File("test/app/modules/location_module/savelocation_response.json")
            .readAsStringSync();

    var response = ResponseLocationByCep.fromJson(jsonDecode(jsonContent));
    return Future.value(response);
  }
}
