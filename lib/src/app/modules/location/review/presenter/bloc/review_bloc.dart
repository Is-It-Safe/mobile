import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/core/data/service/config/base_response.dart';
import 'package:is_it_safe_app/core/data/service/review_service.dart';
import 'package:is_it_safe_app/core/model/LocationByID.dart';
import 'package:is_it_safe_app/core/utils/helper/log.dart';

class ReviewBloc implements Disposable {
  final reviewService = ReviewService();

  late StreamController<BaseResponse<List<LocationByID>>> reviewController;
  late StreamController<String> impressionStatusController;

  late TextEditingController textReviewController;

  List<LocationByID> place = [];
  String impressionStatusResult = 'SAFE';

  ReviewBloc() {
    reviewController = StreamController.broadcast();
    impressionStatusController = StreamController.broadcast();
    textReviewController = TextEditingController();
  }

  setImpressionStatusResult(int activePage) {
    switch (activePage) {
      case 0:
        impressionStatusResult = 'SAFE';
        Log.log(impressionStatusResult, name: "IMPRESSION STATUS");
        impressionStatusController.sink.add(impressionStatusResult);
        break;
      case 1:
        impressionStatusResult = 'WARNING';
        Log.log(impressionStatusResult, name: "IMPRESSION STATUS");
        impressionStatusController.sink.add(impressionStatusResult);
        break;
      case 2:
        impressionStatusResult = 'DANGER';
        Log.log(impressionStatusResult, name: "IMPRESSION STATUS");
        impressionStatusController.sink.add(impressionStatusResult);
        break;
    }
  }

  Future getOnlyLocation(id) async {
    try {
      reviewController.sink.add(BaseResponse.loading());
      final place = await reviewService.getLocationById(id);
      reviewController.sink.add(BaseResponse.completed(data: place));
    } catch (e) {
      reviewController.sink.add(BaseResponse.error(e.toString()));
    }
  }

  Future postOnlyReview({required int id, required String? review, required double grade, required String impressionStatus}) async {
    try {
      reviewController.sink.add(BaseResponse.loading());
      final place =
          await reviewService.postReview(id, review, grade, impressionStatus);
      reviewController.sink.add(BaseResponse.completed(data: place));
    } catch (e) {
      reviewController.sink.add(BaseResponse.error(e.toString()));
    }
  }

  @override
  void dispose() {
    reviewController.close();
  }
}
