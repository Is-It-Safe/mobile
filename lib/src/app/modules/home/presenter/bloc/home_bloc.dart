import 'dart:async';

import 'package:is_it_safe_app/src/domain/use_case/get_best_rated_locations_use_case.dart';
import 'package:is_it_safe_app/src/core/interfaces/safe_bloc.dart';
import 'package:is_it_safe_app/src/domain/entity/location_entity.dart';
import 'package:is_it_safe_app/src/components/config/safe_event.dart';
import 'package:is_it_safe_app/src/service/api/configuration/api_interceptors.dart';
import 'package:is_it_safe_app/src/service/api/error/error_exceptions.dart';

class HomeBloc extends SafeBloC {
  final GetBestRatedLocationsUseCase getBestRatedLocationsUseCase;

  late StreamController<SafeEvent<List<LocationEntity>>>
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
      bestRatedPlacesController.add(SafeEvent.load());
      listBestRatedLocations = await getBestRatedLocationsUseCase.call();
      bestRatedPlacesController.add(SafeEvent.done(listBestRatedLocations));
    } on Exception catch (e) {
      if (e is UnauthorizedException) await ApiInterceptors.doLogout();
      bestRatedPlacesController.addError(e.toString());
    }
  }

  @override
  Future<void> dispose() async {
    bestRatedPlacesController.close();
  }
}
