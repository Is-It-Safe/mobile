import 'package:flutter/material.dart';
import 'package:is_it_safe_app/src/app/modules/profile/presenter/bloc/profile_bloc.dart';

import '../../../../../../generated/l10n.dart';
import '../../../../../components/config/safe_event.dart';
import '../../../../../components/config/safe_layout.dart';
import '../../../../../components/widgets/safe_empty_card.dart';
import '../../../../../domain/entity/user_entity.dart';
import 'profile_review/profile_review.dart';

class ProfileReviewsList extends StatelessWidget {
  final ProfileBloc controller;
  const ProfileReviewsList({Key? key, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SafeStream<UserEntity>>(
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
                child: StreamBuilder<SafeStream<String>>(
                    stream: controller.deleteReviewController.stream,
                    builder: (context, snapshot) {
                      final message = snapshot.data?.data;
                      return ProfileReview(
                          review: reviews![index],
                          onDelete: () async {
                            final int idReview = reviews[index].id;
                            Navigator.pop(context);
                            await controller.deleteReview(idReview: idReview) ==
                                    true
                                ? controller.safeSnackBar.success(
                                    S.current.textDefaultDeleteReviewMessage,
                                  )
                                : controller.safeSnackBar.error(
                                    S.current.textErrorDeleteReview,
                                  );
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
