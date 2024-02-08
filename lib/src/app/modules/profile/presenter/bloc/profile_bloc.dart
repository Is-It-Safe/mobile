import 'dart:async';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/generated/l10n.dart';
import 'package:is_it_safe_app/src/app/modules/configuration/account/domain/usecases/save_user_login_use_case.dart';
import 'package:is_it_safe_app/src/app/modules/review/domain/usecases/delete_review_use_case.dart';
import 'package:is_it_safe_app/src/app/modules/profile/domain/usecases/get_user_use_case.dart';
import 'package:is_it_safe_app/src/core/constants/string_constants.dart';
import 'package:is_it_safe_app/src/core/state/safe_stream.dart';
import 'package:is_it_safe_app/src/core/util/safe_log_util.dart';
import 'package:is_it_safe_app/src/core/interfaces/safe_bloc.dart';
import 'package:is_it_safe_app/src/app/modules/profile/domain/models/user_entity.dart';

class ProfileBloc extends SafeBloC {
  final GetUserUseCase getUserUseCase;
  final SaveUserLoginUseCase saveUserLoginUseCase;
  final DeleteReviewUseCase deleteReviewUseCase;

  final user = SafeStream<UserEntity>(data: UserEntity.empty());
  final deleteReview = SafeStream<String>(data: StringConstants.empty);

  ProfileBloc({
    required this.getUserUseCase,
    required this.saveUserLoginUseCase,
    required this.deleteReviewUseCase,
  });

  @override
  Future<void> init() async {
    user.loading();
    SafeLogUtil.instance.route(Modular.to.path);
    getUser();
  }

  Future<void> getUser() async {
    try {
      final result = await getUserUseCase.call();

      result.fold(
        (userEntity) => user.data = userEntity,
        (error) => null,
      );
    } on Exception catch (e) {
      user.error(e.toString());
    }
  }

  Future<bool> onDeleteReview({required int? idReview}) async {
    try {
      deleteReview.loading();
      final result = await deleteReviewUseCase.call(idReview);

      result.fold(
        (review) => deleteReview.data = review,
        (error) => null,
      );

      getUser();
      user.loading();
      safeSnackBar.success(S.current.textDefaultDeleteReviewMessage);
      return true;
    } catch (e) {
      deleteReview.error(e.toString());
      safeSnackBar.error(S.current.textErrorDeleteReview);
      return false;
    }
  }

  @override
  Future<void> dispose() async {
    user.data = UserEntity.empty();
    deleteReview.data = StringConstants.empty;
  }
}
