import 'dart:async';

import 'package:flutter/material.dart';
import 'package:is_it_safe_app/generated/l10n.dart';
import 'package:is_it_safe_app/src/app/modules/profile/domain/usecases/save_review_use_case.dart';
import 'package:is_it_safe_app/src/components/config/safe_event.dart';
import 'package:is_it_safe_app/src/core/constants/assets_constants.dart';
import 'package:is_it_safe_app/src/core/constants/double_constants.dart';
import 'package:is_it_safe_app/src/core/constants/string_constants.dart';
import 'package:is_it_safe_app/src/core/interfaces/safe_bloc.dart';
import 'package:is_it_safe_app/src/domain/entity/review_entity.dart';
import 'package:result_dart/result_dart.dart';

class ReviewBloc extends SafeBloC {
  final SaveReviewUseCase saveReviewUseCase;

  late StreamController<SafeStream<ReviewEntity>> reviewController;
  late StreamController<double> gradeController;
  late StreamController<int> impressionStatusController;
  late StreamController<bool> isButtonEnabledController;

  late TextEditingController textReviewController;

  List<String> impressionStatusImages = [
    AssetConstants.impression.safe,
    AssetConstants.impression.warning,
    AssetConstants.impression.danger,
  ];
  List<String> impressionStatusTexts = [
    S.current.textSafeForLGBT,
    S.current.textSomeProblemsHappend,
    S.current.textDontRecomendThisPlace
  ];

  String impressionStatus = StringConstants.safe;
  double grade = 3;

  ReviewBloc({
    required this.saveReviewUseCase,
  }) {
    init();
  }

  @override
  Future<void> init() async {
    reviewController = StreamController.broadcast();
    gradeController = StreamController.broadcast();
    impressionStatusController = StreamController.broadcast();
    textReviewController = TextEditingController();
    isButtonEnabledController = StreamController.broadcast();

    isButtonEnabledController.add(false);
    gradeController.add(DoubleConstants.defaultEmotionGrade);
    impressionStatusController.add(0);
  }

  void onImpressionChanged(int index) {
    String status = StringConstants.safe;
    if (index == 0) status = StringConstants.safe;
    if (index == 1) status = StringConstants.warning;
    if (index == 2) status = StringConstants.danger;
    impressionStatus = status;
    impressionStatusController.add(index);
  }

  List<String> getImpressions(int index) {
    final impressions = <String>[];
    impressions.add(S.current.textStructure);
    impressions.add(S.current.textSecurity);
    if (index == 0 || index == 1) {
      impressions.add(S.current.textService);
    } else if (index == 2) {
      impressions.add(S.current.textLGBTFobia);
    }
    return impressions;
  }

  void onReviewChanged(String value) {
    isButtonEnabledController.add(value.trim().isNotEmpty);
  }

  Future sendReview({required int id}) async {
    try {
      reviewController.add(SafeStream.load());
      await saveReviewUseCase
          .call(
        review: textReviewController.text,
        grade: grade.toInt(),
        impressionStatus: impressionStatus,
        locationId: id,
      )
          .fold(
        (success) {
          reviewController.add(SafeStream.done(success));
        },
        (error) {},
      );
    } catch (e) {
      reviewController.addError(e.toString());
    }
  }

  void onGradeChanged(double value) {
    grade = value;
    gradeController.add(value);
  }

  @override
  Future<void> dispose() async {}
}
