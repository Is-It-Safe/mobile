import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/generated/l10n.dart';
import 'package:is_it_safe_app/src/app/modules/profile/presenter/bloc/profile_bloc.dart';
import 'package:is_it_safe_app/src/app/modules/profile/presenter/widgets/profile_review.dart';
import 'package:is_it_safe_app/src/components/style/text/text_styles.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_dialogs.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_empty_card.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_loading.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_profile_header.dart';
import 'package:is_it_safe_app/src/core/util/log_util.dart';
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
    LogUtil().route(Modular.to.path);
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
          switch (snapshot.data?.status) {
            case Status.loading:
              return const SafeLoading();
            case Status.error:
              showDialog(
                context: context,
                builder: (context) => SafeDialogs.error(
                  message: snapshot.data?.message,
                ),
              );
              break;
            case Status.done:
              //TODO salvar o usuário no shared preferences
              return SafeProfileHeader(
                nickname: user?.nickname,
                //TODO descomentar a foto
                //photo: user?.profilePhoto,
                pronoun: user?.pronoun,
                gender: user?.gender,
                sexualOrientation: user?.orientation,
              );
            default:
              return const SafeProfileHeader();
          }
          return const SafeProfileHeader();
        });
  }

  Widget _mountReviews() {
    return StreamBuilder<SafeEvent<UserEntity>>(
      stream: controller.userController.stream,
      builder: (context, snapshot) {
        final reviews = snapshot.data?.data?.reviews;
        if (snapshot.data?.data != null) {
          switch (snapshot.data?.status) {
            case Status.loading:
              return const SafeLoading();
            case Status.error:
              showDialog(
                context: context,
                builder: (context) => SafeDialogs.error(
                  message: snapshot.data?.message,
                ),
              );
              break;
            case Status.done:
              if (reviews!.isEmpty) return SafeEmptyCard.profile();
              return Column(
                children: List.generate(
                  reviews.length,
                  (index) => Padding(
                    padding: const EdgeInsets.only(top: 24.0),
                    child: ProfileReview(
                      review: reviews[index],
                      //TODO substituir por: controller.deleteReview
                      // onDelete: () {},
                      //TODO substituir por: controller.shareReview
                      // onShare: () {},
                    ),
                  ),
                ),
              );
            default:
              return const SafeLoading();
          }
        }
        return SafeEmptyCard.profile();
      },
    );
  }
}