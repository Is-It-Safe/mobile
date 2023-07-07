import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/generated/l10n.dart';
import 'package:is_it_safe_app/src/app/modules/review/domain/usecases/save_review_use_case.dart';
import 'package:is_it_safe_app/src/core/constants/double_constants.dart';
import 'package:is_it_safe_app/src/core/enum/impression_status_enum.dart';
import 'package:is_it_safe_app/src/core/interfaces/safe_bloc.dart';
import 'package:is_it_safe_app/src/core/state/safe_stream.dart';
import 'package:is_it_safe_app/src/domain/entity/review_entity.dart';

class ReviewBloc extends SafeBloC {
  final SaveReviewUseCase saveReviewUseCase;

  final review = SafeStream<ReviewEntity?>(data: null);
  final grade = SafeStream<double>(data: DoubleConstants.defaultEmotionGrade);
  final impressionStatus = SafeStream<ImpressionStatusEnum>(
    data: ImpressionStatusEnum.safe,
  );
  final isButtonEnabled = SafeStream<bool>(data: false);

  final textReviewController = TextEditingController();

  ReviewBloc({
    required this.saveReviewUseCase,
  });

  @override
  Future<void> init() async {}

  void onImpressionChanged(int index) {
    impressionStatus.data = ImpressionStatusEnum.values[index];
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
    isButtonEnabled.data = value.trim().isNotEmpty;
  }

  Future sendReview({required int id}) async {
    review.loading();
    try {
      final result = await saveReviewUseCase.call(
        review: textReviewController.text,
        grade: grade.data.toInt(),
        impressionStatus: impressionStatus.data.name,
        locationId: id,
      );

      result.fold(
        (success) {
          review.data = success;
          Modular.to.pop(true);
          safeSnackBar.success('Review enviada com sucesso!');
        },
        (error) => throw Exception(error),
      );
    } catch (e) {
      review.error(e.toString());
      safeSnackBar.error(e.toString());
    }
  }

  void onGradeChanged(double value) => grade.data = value;

  @override
  Future<void> dispose() async {
    review.data = null;
    grade.data = DoubleConstants.defaultEmotionGrade;
    impressionStatus.data = ImpressionStatusEnum.safe;
    isButtonEnabled.data = false;
    textReviewController.dispose();
  }
}
