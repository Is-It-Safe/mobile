import 'dart:async';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/core/data/service/config/base_response.dart';
import 'package:is_it_safe_app/core/data/service/home_service.dart';
import 'package:is_it_safe_app/core/model/location/location.dart';
import 'package:is_it_safe_app/core/model/location/location_info.dart';

class HomeBloc implements Disposable {
  final HomeService _service = HomeService();
  late StreamController<BaseResponse<List<Location>>> bestRatedPlacesController;
  late StreamController<BaseResponse<List<Location>>> closePlacesController;

  HomeBloc() {
    bestRatedPlacesController = StreamController.broadcast();
    closePlacesController = StreamController.broadcast();
  }

  Future getBestRatedLocations() async {
    try {
      bestRatedPlacesController.sink.add(BaseResponse.loading());
      final Locations locations = await _service.getBestRatedLocations();
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
      final Locations locations = await _service.getClosePlacesLocations();
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
