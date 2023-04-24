import 'dart:async';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/src/app/modules/location/location_module.dart';
import 'package:is_it_safe_app/src/app/modules/location/presenter/pages/location_page.dart';
import 'package:is_it_safe_app/src/app/modules/location/presenter/pages/save_location_page.dart';
import 'package:is_it_safe_app/src/core/state/safe_stream.dart';
import 'package:flutter/material.dart';
import 'package:is_it_safe_app/src/core/constants/string_constants.dart';
import 'package:is_it_safe_app/src/core/util/safe_log_util.dart';
import 'package:is_it_safe_app/src/domain/use_case/get_locations_by_name_use_case.dart';
import 'package:is_it_safe_app/src/core/interfaces/safe_bloc.dart';
import 'package:is_it_safe_app/src/app/modules/location/domain/entities/location_entity.dart';

class SearchBloc extends SafeBloC {
  final GetLocationsByNameUseCase getLocationsByNameUseCase;

  final locations = SafeStream<List<LocationEntity>>(data: []);
  final searchTextController = TextEditingController();
  String lastSearch = StringConstants.empty;

  SearchBloc({
    required this.getLocationsByNameUseCase,
  });

  @override
  Future<void> init() async {
    SafeLogUtil.instance.route(Modular.to.path);
  }

  bool get isSearchEmpty => searchTextController.text.isEmpty;

  Future<void> searchLocation() async {
    locations.data.clear();

    try {
      if (searchTextController.text.isEmpty) {
        locations.initial();
        return;
      }
      if (searchTextController.text == lastSearch) return;
      locations.loading();
      final result = await getLocationsByNameUseCase.call(
        searchTextController.text,
      );

      result.fold(
        (searchResultLocations) {
          locations.data = searchResultLocations;
          lastSearch = searchTextController.text;
        },
        (error) => locations.error(error.message),
      );
    } catch (e) {
      locations.error(e.toString());
    }
  }

  void navigateToLocationPage(LocationEntity location) {
    Modular.to.pushNamed(
      LocationModule.route + LocationPage.route,
      arguments: location,
    );
  }

  void navigateToAddLocationPage() {
    Modular.to.pushNamed(
      LocationModule.route + SaveLocationPage.route,
    );
  }

  @override
  Future<void> dispose() async {
    locations.data = [];
    searchTextController.clear();
    lastSearch = StringConstants.empty;
  }
}
