import 'dart:async';

import 'package:flutter/material.dart';
import 'package:is_it_safe_app/src/l10n/l10n.dart';
import 'package:is_it_safe_app/src/components/config/safe_event.dart';
import 'package:is_it_safe_app/src/core/constants/assets_constants.dart';
import 'package:is_it_safe_app/src/core/constants/string_constants.dart';
import 'package:is_it_safe_app/src/core/interfaces/safe_bloc.dart';
import 'package:is_it_safe_app/src/domain/entity/review_entity.dart';
import 'package:is_it_safe_app/src/domain/use_case/save_review_use_case.dart';

class ReviewBloc extends SafeBloC {
  final SaveReviewUseCase saveReviewUseCase;

  late StreamController<SafeEvent<ReviewEntity>> reviewController;
  late StreamController<double> gradeController;
  late StreamController<int> impressionStatusController;
  late StreamController<bool> isButtonEnabledController;

  late TextEditingController textReviewController;

  final double defaultEmotionGrade = 3;
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
    gradeController.add(defaultEmotionGrade);
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
      reviewController.add(SafeEvent.load());
      final place = await saveReviewUseCase.call(
        review: textReviewController.text,
        grade: grade.toInt(),
        impressionStatus: impressionStatus,
        locationId: id,
      );
      reviewController.add(SafeEvent.done(place));
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
