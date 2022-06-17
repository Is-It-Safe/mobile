import 'dart:async';

import 'package:flutter/material.dart';
import 'package:is_it_safe_app/src/app/modules/search/domain/use_case/get_locations_by_name_use_case.dart';
import 'package:is_it_safe_app/src/core/interfaces/safe_bloc.dart';
import 'package:is_it_safe_app/src/domain/entity/location_entity.dart';
import 'package:is_it_safe_app/src/service/api/configuration/stream_response.dart';

class SearchBloc extends SafeBloC {
  final GetLocationsByNameUseCase getLocationsByNameUseCase;
  late StreamController<SafeResponse<List<LocationEntity>>> searchController;
  late TextEditingController placeSearchController;

  List<LocationEntity> searchResultLocations = [];

  SearchBloc({
    required this.getLocationsByNameUseCase,
  }) {
    init();
  }

  @override
  Future<void> init() async {
    searchController = StreamController.broadcast();
    placeSearchController = TextEditingController();
  }

  Future<void> searchLocation() async {
    try {
      searchResultLocations.clear();
      searchController.sink.add(SafeResponse.loading());
      searchResultLocations = await getLocationsByNameUseCase.call(
        placeSearchController.text,
      );
      searchController.sink
          .add(SafeResponse.completed(data: searchResultLocations));
    } catch (e) {
      searchController.sink.add(SafeResponse.error(e.toString()));
    }
  }

  @override
  Future<void> dispose() async {
    searchController.close();
  }
}
