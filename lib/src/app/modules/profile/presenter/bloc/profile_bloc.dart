import 'dart:async';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_snack_bar.dart';
import 'package:is_it_safe_app/src/core/constants/string_constants.dart';
import 'package:is_it_safe_app/src/core/state/safe_stream.dart';
import 'package:is_it_safe_app/src/core/util/safe_log_util.dart';
import 'package:is_it_safe_app/src/domain/use_case/delete_review_use_case.dart';
import 'package:is_it_safe_app/src/domain/use_case/get_user_use_case.dart';
import 'package:is_it_safe_app/src/core/interfaces/safe_bloc.dart';
import 'package:is_it_safe_app/src/domain/entity/user_entity.dart';
import 'package:is_it_safe_app/src/domain/use_case/save_user_login_use_case.dart';
import 'package:is_it_safe_app/src/l10n/l10n.dart';
import 'package:is_it_safe_app/src/service/api/configuration/api_interceptors.dart';
import 'package:is_it_safe_app/src/service/api/error/error_exceptions.dart';

class ProfileBloc extends SafeBloC {
  final SafeSnackBar safeSnackbar;
  final GetUserUseCase getUserUseCase;
  final SaveUserLoginUseCase saveUserLoginUseCase;
  final DeleteReviewUseCase deleteReviewUseCase;

  final user = SafeStream<UserEntity?>(data: null);
  final messageDeleteReview = SafeStream<String>(data: StringConstants.empty);

  ProfileBloc({
    required this.safeSnackbar,
    required this.getUserUseCase,
    required this.saveUserLoginUseCase,
    required this.deleteReviewUseCase,
  });

  @override
  Future<void> init() async {
    SafeLogUtil.instance.route(Modular.to.path);
    getUser();
  }

  Future<void> getUser() async {
    try {
      user.loading();
      final response = await getUserUseCase.call();
      user.data = response;
      user.show();
    } on UnauthorizedException {
      safeSnackbar.error(S.current.textErrorLoginExpired);
      await ApiInterceptors.doLogout();
    } catch (e) {
      user.show();
      safeSnackbar.error('$e');
    }
  }

  Future<void> deleteReview({required int? idReview}) async {
    try {
      final review = await deleteReviewUseCase.call(idReview);
      messageDeleteReview.data = review;
      user.data = user.data?.copyWith(
        reviews: (user.data?.reviews ?? [])
            .where((element) => element.id != idReview)
            .toList(),
      );
      safeSnackbar.success(S.current.textDefaultDeleteReviewMessage);
    } catch (e) {
      messageDeleteReview.show();
      safeSnackbar.error(S.current.textErrorDeleteReview);
    }
  }

  void shareReview({required int? idReview}) {
    safeSnackbar.info(S.current.textFeatureAvailableSoon);
  }

  @override
  Future<void> dispose() async {
    user.data = null;
    messageDeleteReview.data = StringConstants.empty;
  }
}
