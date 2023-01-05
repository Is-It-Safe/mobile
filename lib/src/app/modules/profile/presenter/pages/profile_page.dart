import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/src/l10n/l10n.dart';
import 'package:is_it_safe_app/src/app/modules/profile/presenter/bloc/profile_bloc.dart';
import 'package:is_it_safe_app/src/app/modules/profile/presenter/widgets/profile_review.dart';
import 'package:is_it_safe_app/src/components/config/safe_layout.dart';
import 'package:is_it_safe_app/src/components/style/text/text_styles.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_empty_card.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_profile_header.dart';
import 'package:is_it_safe_app/src/core/util/safe_log_util.dart';
import 'package:is_it_safe_app/src/domain/entity/user_entity.dart';
import 'package:is_it_safe_app/src/components/config/safe_event.dart';

class ProfilePage extends StatefulWidget {
  static const route = '/profile/';
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ModularState<ProfilePage, ProfileBloc> {
  @override
  void initState() {
    super.initState();
    SafeLogUtil.instance.route(Modular.to.path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 24.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _mountHeader(),
              const SizedBox(height: 40.0),
              Text(
                S.current.textYourReviews,
                style: TextStyles.headline3(),
              ),
              _mountReviews(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _mountHeader() {
    return StreamBuilder<SafeEvent<UserEntity>>(
        stream: controller.userController.stream,
        builder: (context, snapshot) {
          final user = snapshot.data?.data;
          return SafeLayout(
            snapshot: snapshot,
            showErrorDialog: false,
            onEmpty: const SafeProfileHeader(),
            onError: const SafeProfileHeader(),
            //TODO salvar o usuário no shared preferences
            onCompleted: SafeProfileHeader(
              nickname: user?.nickname,
              //TODO descomentar a foto
              //photo: user?.profilePhoto,
              pronoun: user?.pronoun,
              gender: user?.gender,
              sexualOrientation: user?.orientation,
            ),
          );
        });
  }

  Widget _mountReviews() {
    return StreamBuilder<SafeEvent<UserEntity>>(
      stream: controller.userController.stream,
      builder: (context, snapshot) {
        final reviews = snapshot.data?.data?.reviews?.reversed.toList();
        return SafeLayout(
          snapshot: snapshot,
          onEmpty: SafeEmptyCard.profile(),
          onCompleted: Column(
            children: List.generate(
              reviews?.length ?? 0,
              (index) => Padding(
                padding: const EdgeInsets.only(top: 24.0),
                child: StreamBuilder<SafeEvent<String>>(
                    stream: controller.deleteReviewController.stream,
                    builder: (context, snapshot) {
                      final message = snapshot.data?.data;
                      return ProfileReview(
                          review: reviews?[index],
                          onDelete: () async {
                            final int? idReview = reviews?[index].id;
                            Navigator.pop(context);
                            // await controller.deleteReview(idReview: idReview) ==
                            //         true
                            //     ? SafeSnackBar(
                            //         message: message ??
                            //             S.current
                            //                 .textDefaultDeleteReviewMessage,
                            //         type: SnackBarTypeEnum.success,
                            //       ).show()
                            //     : SafeSnackBar(
                            //         message: message ??
                            //             S.current.textErrorDeleteReview,
                            //         type: SnackBarTypeEnum.error,
                            //       ).show();
                          }

                          //TODO substituir por: controller.shareReview
                          // onShare: () {},
                          );
                    }),
              ),
            ),
          ),
        );
      },
    );
  }
}
