import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/generated/l10n.dart';
import 'package:is_it_safe_app/src/app/modules/profile/presenter/bloc/profile_bloc.dart';
import 'package:is_it_safe_app/src/app/modules/profile/presenter/widgets/profile_review.dart';
import 'package:is_it_safe_app/src/components/config/safe_layout.dart';
import 'package:is_it_safe_app/src/components/style/text/text_styles.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_empty_card.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_profile_header.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_snack_bar.dart';
import 'package:is_it_safe_app/src/core/constants/string_constants.dart';
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
            context: context,
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
          ).build;
        });
  }

  Widget _mountReviews() {
    return StreamBuilder<SafeEvent<UserEntity>>(
      stream: controller.userController.stream,
      builder: (context, snapshot) {
        final reviews = snapshot.data?.data?.reviews;
        final name = snapshot.data?.data?.name;
        return SafeLayout(
          snapshot: snapshot,
          context: context,
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
                          await controller.deleteReview(idReview: idReview) ==
                                  true
                              ? SafeSnackBar(
                                  message: message ??
                                      S.current.textDefaultDeleteReviewMessage,
                                  type: SnackBarType.success,
                                ).show(context)
                              : SafeSnackBar(
                                  message: message ??
                                      S.current.textErrorDeleteReview,
                                  type: SnackBarType.error,
                                ).show(context);
                        },
                        name: name,

                        //TODO substituir por: controller.shareReview
                        // onShare: () {},
                      );
                    }),
              ),
            ),
          ),
        ).build;
      },
    );
  }
}
