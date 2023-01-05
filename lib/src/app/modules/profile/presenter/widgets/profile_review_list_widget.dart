import 'package:flutter/material.dart';
import 'package:is_it_safe_app/src/app/modules/profile/presenter/widgets/profile_review.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_empty_card.dart';
import 'package:is_it_safe_app/src/core/state/safe_builder.dart';
import 'package:is_it_safe_app/src/core/state/safe_stream.dart';
import 'package:is_it_safe_app/src/domain/entity/user_entity.dart';

class ProfileReviewListWidget extends StatefulWidget {
  final SafeStream<UserEntity?> user;
  final SafeStream<String> messageDeleteReview;
  final Function(int? idReview) deleteReview;
  final Function(int? idReview) shareReview;
  const ProfileReviewListWidget({
    Key? key,
    required this.user,
    required this.messageDeleteReview,
    required this.shareReview,
    required this.deleteReview,
  }) : super(key: key);

  @override
  State<ProfileReviewListWidget> createState() =>
      _ProfileReviewListWidgetState();
}

class _ProfileReviewListWidgetState extends State<ProfileReviewListWidget> {
  @override
  Widget build(BuildContext context) {
    return SafeBuilder<UserEntity?>(
      stream: widget.user,
      onError: (_) => SafeEmptyCard.profile(),
      builder: (user) {
        final reviews = user?.reviews?.reversed.toList();
        return Column(
          children: List.generate(
            reviews?.length ?? 0,
            (index) => Padding(
              padding: const EdgeInsets.only(top: 24.0),
              child: SafeBuilder<String>(
                  stream: widget.messageDeleteReview,
                  builder: (onDeleteReview) {
                    return ProfileReview(
                      review: reviews?[index],
                      onDelete: () => widget.deleteReview(reviews?[index].id),
                      onShare: () => widget.shareReview(reviews?[index].id),
                    );
                  }),
            ),
          ),
        );
      },
    );
  }
}
