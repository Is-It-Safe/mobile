import 'package:flutter/material.dart';
import 'package:is_it_safe_app/src/core/state/safe_builder.dart';
import 'package:is_it_safe_app/src/core/state/safe_stream.dart';

import '../../../../../components/widgets/safe_empty_card.dart';
import '../../../../../domain/entity/user_entity.dart';
import 'profile_review/profile_review.dart';

class ProfileReviewsList extends StatelessWidget {
  final SafeStream<UserEntity> user;
  final SafeStream<String> deleteReview;
  final Future<bool> Function(int id) onDeleteReview;
  const ProfileReviewsList(
      {Key? key,
      required this.user,
      required this.deleteReview,
      required this.onDeleteReview})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeBuilder<UserEntity>(
      stream: user,
      builder: (user) {
        final reviews = user.reviews?.reversed.toList();
        if (reviews == null || reviews.isEmpty) {
          return SafeEmptyCard.profile();
        }
        return Column(
          children: List.generate(
            reviews.length,
            (index) => Padding(
              padding: const EdgeInsets.only(top: 24.0),
              child: SafeBuilder<String>(
                stream: deleteReview,
                builder: (deleteReview) {
                  return ProfileReview(
                    review: reviews[index],
                    onDelete: () async {
                      final int idReview = reviews[index].id;
                      Navigator.pop(context);
                      onDeleteReview(idReview);
                    },
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
