import 'package:flutter/material.dart';
import 'package:is_it_safe_app/src/domain/entity/review_entity.dart';

import '../../../../../../components/style/colors/safe_colors.dart';
import '../../../../../../components/style/text/text_styles.dart';
import '../../../../../../core/constants/string_constants.dart';

class ProfileReviewCard extends StatelessWidget {
  final ReviewEntity review;
  final Function onSeeMoreTap;
  final bool isTextExpanded;
  final String textSeeMore;
  const ProfileReviewCard(
      {Key? key,
      required this.review,
      required this.onSeeMoreTap,
      required this.isTextExpanded,
      required this.textSeeMore})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _ReviewTitle(
          locationName: review.location!.name,
        ),
        _ReviewBody(
          review: review.review ?? StringConstants.empty,
          isTextExpanded: isTextExpanded,
          onTap: onSeeMoreTap,
          textSeeMore: textSeeMore,
        ),
      ],
    );
  }
}

class _ReviewBody extends StatelessWidget {
  final String review;
  final bool isTextExpanded;
  final Function onTap;
  final String textSeeMore;
  const _ReviewBody(
      {Key? key,
      required this.review,
      required this.isTextExpanded,
      required this.onTap,
      required this.textSeeMore})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.5,
          child: Text(
            review,
            style: TextStyles.caption(),
            softWrap: true,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.start,
            maxLines: isTextExpanded ? 30 : 3,
          ),
        ),
        const SizedBox(width: 4),
        Visibility(
          visible: (review.length) > 80,
          child: GestureDetector(
            // onTap: doSeeMore,
            onTap: onTap as void Function(),
            child: Text(
              textSeeMore,
              style: TextStyles.caption(
                color: SafeColors.buttonColors.primary,
                textDecoration: TextDecoration.underline,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _ReviewTitle extends StatelessWidget {
  final String locationName;
  const _ReviewTitle({Key? key, required this.locationName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.5,
      child: Text(
        locationName,
        style: TextStyles.subtitle2(),
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
    );
  }
}
