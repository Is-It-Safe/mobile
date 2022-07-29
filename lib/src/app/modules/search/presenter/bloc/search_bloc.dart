import 'dart:async';

import 'package:flutter/material.dart';
import 'package:is_it_safe_app/src/core/constants/string_constants.dart';
import 'package:is_it_safe_app/src/domain/use_case/get_locations_by_name_use_case.dart';
import 'package:is_it_safe_app/src/core/interfaces/safe_bloc.dart';
import 'package:is_it_safe_app/src/domain/entity/location_entity.dart';
import 'package:is_it_safe_app/src/components/config/safe_event.dart';

class SearchBloc extends SafeBloC {
  final GetLocationsByNameUseCase getLocationsByNameUseCase;
  late StreamController<SafeEvent<List<LocationEntity>>> searchController;
  late TextEditingController placeSearchController;

  String lastSearch = StringConstants.empty;
  List<LocationEntity> searchResultLocations = [];

  SearchBloc({
    required this.getLocationsByNameUseCase,
  }) {
    init();
  }

  @override
  Future<void> init() async {
    placeSearchController = TextEditingController();
    searchController = StreamController.broadcast();
  }

  Future<void> searchLocation() async {
    searchResultLocations.clear();

    try {
      if (placeSearchController.text.isEmpty) {
        searchController.add(SafeEvent.initial());
        return;
      }
      if (placeSearchController.text == lastSearch) return;
      searchController.add(SafeEvent.load());
      searchResultLocations = await getLocationsByNameUseCase.call(
        placeSearchController.text,
      );
      searchController.sink.add(SafeEvent.done(searchResultLocations));
      lastSearch = placeSearchController.text;
    } on Exception catch (e) {
      searchController.addError(e.toString());
    }
  }

  @override
  Future<void> dispose() async {
    searchController.close();
    placeSearchController.dispose();
  }
}
