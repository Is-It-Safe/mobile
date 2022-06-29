import 'dart:async';

import 'package:flutter/material.dart';
import 'package:is_it_safe_app/src/domain/use_case/get_locations_by_name_use_case.dart';
import 'package:is_it_safe_app/src/core/interfaces/safe_bloc.dart';
import 'package:is_it_safe_app/src/domain/entity/location_entity.dart';
import 'package:is_it_safe_app/src/components/config/safe_event.dart';

class SearchBloc extends SafeBloC {
  final GetLocationsByNameUseCase getLocationsByNameUseCase;
  late StreamController<SafeEvent<List<LocationEntity>>> searchController;
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
      searchController.sink.add(SafeEvent.load());
      searchResultLocations = await getLocationsByNameUseCase.call(
        placeSearchController.text,
      );
      searchController.sink.add(SafeEvent.done(searchResultLocations));
    } catch (e) {
      searchController.sink.add(SafeEvent.error(e.toString()));
    }
  }

  @override
  Future<void> dispose() async {
    searchController.close();
  }
}
