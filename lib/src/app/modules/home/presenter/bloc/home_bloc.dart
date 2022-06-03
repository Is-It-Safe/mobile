import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/src/app/modules/home/domain/entity/home_location_entity.dart';
import 'package:is_it_safe_app/src/app/modules/home/domain/use_case/get_best_rated_locations_use-case.dart';
import 'package:is_it_safe_app/src/core/interfaces/safe_bloc.dart';
import 'package:is_it_safe_app/src/service/api/configuration/stream_response.dart';

class HomeBloc extends SafeBloC {
  late final GetBestRatedLocationsUseCase _getBestRatedLocationsUseCase;

  late StreamController<SafeResponse<List<HomeLocationEntity>>>
      bestRatedPlacesController;
  List<HomeLocationEntity> listBestRatedLocations = [];

  HomeBloc() {
    init();
    getBestRatedLocations();
  }

  @override
  Future<void> init() async {
    _getBestRatedLocationsUseCase = Modular.get<GetBestRatedLocationsUseCase>();
    bestRatedPlacesController = StreamController.broadcast();
  }

  Future<void> getBestRatedLocations({
    bool isRefresh = false,
  }) async {
    try {
      if (listBestRatedLocations.isEmpty || isRefresh) {
        bestRatedPlacesController.sink.add(SafeResponse.loading());
        listBestRatedLocations = await _getBestRatedLocationsUseCase.call();
        bestRatedPlacesController.sink.add(
          SafeResponse.completed(
            data: listBestRatedLocations,
          ),
        );
      }
    } on DioError catch (e) {
      bestRatedPlacesController.sink.add(
        SafeResponse.error(e.response?.data),
      );
    }
  }

  @override
  Future<void> dispose() async {
    bestRatedPlacesController.close();
  }
}
