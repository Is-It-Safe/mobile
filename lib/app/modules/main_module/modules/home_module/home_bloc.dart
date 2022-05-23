import 'dart:async';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/core/data/service/config/base_response.dart';
import 'package:is_it_safe_app/core/data/service/home/home.dart';
import 'package:is_it_safe_app/core/data/service/home/home_contract.dart';
import 'package:is_it_safe_app/core/model/location/location.dart';
import 'package:is_it_safe_app/core/model/location/location_info.dart';

class HomeBloc implements Disposable {
  final HomeContract service;
  late StreamController<BaseResponse<List<Location>>> bestRatedPlacesController;
  late StreamController<BaseResponse<List<Location>>> closePlacesController;

  HomeBloc({required this.service}) {
    bestRatedPlacesController = StreamController.broadcast();
    closePlacesController = StreamController.broadcast();
  }

  Future getBestRatedLocations() async {
    try {
      bestRatedPlacesController.sink.add(BaseResponse.loading());
      final Locations locations = await service.getBestRatedLocations();
      bestRatedPlacesController.sink.add(
        BaseResponse.completed(
          data: locations.content,
        ),
      );
    } catch (e) {
      bestRatedPlacesController.sink.add(BaseResponse.error(e.toString()));
    }
  }

  Future getClosePlacesLocations() async {
    try {
      closePlacesController.sink.add(BaseResponse.loading());
      final Locations locations = await service.getClosePlacesLocations();
      closePlacesController.sink.add(
        BaseResponse.completed(data: locations.content),
      );
    } catch (e) {
      closePlacesController.sink.add(BaseResponse.error(e.toString()));
    }
  }

  @override
  void dispose() {}
}
