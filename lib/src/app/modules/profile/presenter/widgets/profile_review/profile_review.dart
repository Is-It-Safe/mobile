import 'package:flutter/material.dart';
import 'package:is_it_safe_app/generated/l10n.dart';
import 'package:is_it_safe_app/src/app/modules/profile/presenter/widgets/profile_review/profile_review_card.dart';
import 'package:is_it_safe_app/src/app/modules/profile/presenter/widgets/profile_review/profile_review_more_button.dart';
import 'package:is_it_safe_app/src/components/style/colors/safe_colors.dart';
import 'package:is_it_safe_app/src/components/style/text/text_styles.dart';
import 'package:is_it_safe_app/src/core/constants/assets_constants.dart';
import 'package:is_it_safe_app/src/core/constants/double_constants.dart';
import 'package:is_it_safe_app/src/core/constants/string_constants.dart';
import 'package:is_it_safe_app/src/domain/entity/review_entity.dart';
import 'package:flutter_svg/svg.dart';

class ProfileReview extends StatefulWidget {
  final ReviewEntity review;
  final Function() onDelete;
  final Function()? onShare;
  final String? name;

  const ProfileReview({
    Key? key,
    required this.review,
    required this.onDelete,
    this.onShare,
    this.name,
  }) : super(key: key);

  @override
  State<ProfileReview> createState() => _ProfileReviewState();
}

class _ProfileReviewState extends State<ProfileReview> {
  bool _isTextExpanded = false;
  String _textSeeMore = S.current.textSeeMore;

  void doSeeMore() {
    setState(() {
      _isTextExpanded = !_isTextExpanded;
      if (_isTextExpanded) {
        _textSeeMore = S.current.textSeeLess;
      } else {
        _textSeeMore = S.current.textSeeMore;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 17.0),
      decoration: BoxDecoration(
        color: SafeColors.generalColors.primary,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MountEmoticon(
            isTextExpanded: _isTextExpanded,
            myGrade: widget.review.myGrade ?? DoubleConstants.empty,
          ),
          const SizedBox(width: 4.0),
          ProfileReviewCard(
            review: widget.review,
            onSeeMoreTap: doSeeMore,
            isTextExpanded: _isTextExpanded,
            textSeeMore: _textSeeMore,
          ),
          ProfileReviewMoreButton(
            name: widget.name ?? StringConstants.hyphen,
            review: widget.review.review ?? StringConstants.hyphen,
            onDeleteReview: () => widget.onDelete(),
          ),
        ],
      ),
    );
  }
}

class MountEmoticon extends StatelessWidget {
  final double myGrade;
  final bool isTextExpanded;

  const MountEmoticon({
    Key? key,
    required this.myGrade,
    required this.isTextExpanded,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment:
      isTextExpanded ? MainAxisAlignment.start : MainAxisAlignment.center,
      children: [
        SvgPicture.asset(_getEmotionImage(myGrade)),
        const SizedBox(height: 4.0),
        Text(
          _getEmotionText(myGrade),
          style: TextStyles.bodyText2(),
        ),
      ],
    );
  }

  String _getEmotionImage(double? grade) {
    if (grade == null) return AssetConstants.emoticon.neutral;
    if (grade == 1.0) return AssetConstants.emoticon.angry;
    if (grade == 2.0) return AssetConstants.emoticon.sad;
    if (grade == 3.0) return AssetConstants.emoticon.neutral;
    if (grade == 4) return AssetConstants.emoticon.happy;
    if (grade >= 4.0) return AssetConstants.emoticon.excited;

    return AssetConstants.emoticon.neutral;
  }

  String _getEmotionText(double? grade) {
    if (grade == null) return S.current.textRegular;
    if (grade == 1.0) return S.current.textAngry;
    if (grade == 2.0) return S.current.textUpset;
    if (grade == 3.0) return S.current.textRegular;
    if (grade == 4) return S.current.textSatisfied;
    if (grade >= 4.0) return S.current.textIncredible;

    return S.current.textRegular;
  }
}
