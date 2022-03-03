import 'dart:async';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/core/data/service/config/base_response.dart';
import 'package:is_it_safe_app/core/data/service/home_service.dart';
import 'package:is_it_safe_app/core/model/location/location_info.dart';

class HomeBloc implements Disposable {
  final HomeService _service = HomeService();
  late StreamController<BaseResponse<List<LocationInfo>>> locationInfoController;

  HomeBloc(){
    locationInfoController = StreamController.broadcast();
  }

  Future getLocations() async {
    try{
      locationInfoController.sink.add(BaseResponse.loading());
      final locations = await _service.getLocations();
      locationInfoController.sink.add(BaseResponse.completed(data: locations));
    }catch(e){
      locationInfoController.sink.add(BaseResponse.error(e.toString()));
    }
  }


  @override
  void dispose() {}
}
