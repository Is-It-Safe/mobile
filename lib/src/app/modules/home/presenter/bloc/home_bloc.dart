import 'dart:async';

import 'package:dio/dio.dart';
import 'package:is_it_safe_app/src/domain/use_case/get_best_rated_locations_use-case.dart';
import 'package:is_it_safe_app/src/core/interfaces/safe_bloc.dart';
import 'package:is_it_safe_app/src/domain/entity/location_entity.dart';
import 'package:is_it_safe_app/src/service/api/configuration/stream_response.dart';

class HomeBloc extends SafeBloC {
  final GetBestRatedLocationsUseCase getBestRatedLocationsUseCase;

  late StreamController<SafeResponse<List<LocationEntity>>>
      bestRatedPlacesController;
  List<LocationEntity> listBestRatedLocations = [];

  HomeBloc({
    required this.getBestRatedLocationsUseCase,
  }) {
    init();
  }

  @override
  Future<void> init() async {
    bestRatedPlacesController = StreamController.broadcast();
  }

  Future<void> getBestRatedLocations() async {
    try {
      //TODO Somente chamar a api mediante um isRefresh == true ou caso listBestRatedLocations esteja vazia
      bestRatedPlacesController.sink.add(SafeResponse.loading());
      listBestRatedLocations = await getBestRatedLocationsUseCase.call();
      bestRatedPlacesController.sink.add(
        SafeResponse.completed(data: listBestRatedLocations),
      );
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
