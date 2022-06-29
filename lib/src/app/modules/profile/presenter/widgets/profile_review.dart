import 'package:flutter/material.dart';
import 'package:is_it_safe_app/generated/l10n.dart';
import 'package:is_it_safe_app/src/components/style/colors/safe_colors.dart';
import 'package:is_it_safe_app/src/components/style/text/text_styles.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_modal.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_snack_bar.dart';
import 'package:is_it_safe_app/src/core/constants/assets_constants.dart';
import 'package:is_it_safe_app/src/core/constants/string_constants.dart';
import 'package:is_it_safe_app/src/domain/entity/review_entity.dart';
import 'package:flutter_svg/svg.dart';

class ProfileReview extends StatefulWidget {
  final ReviewEntity review;
  final Function()? onDelete;
  final Function()? onShare;

  const ProfileReview({
    Key? key,
    required this.review,
    this.onDelete,
    this.onShare,
  }) : super(key: key);

  @override
  State<ProfileReview> createState() => _ProfileReviewState();
}

class _ProfileReviewState extends State<ProfileReview> {
  bool _isTextExpanded = false;
  String _textSeeMore = S.current.textSeeMore;

  String _getEmotionImage(double? grade) {
    if (grade == null) return AssetConstants.emoticon.neutral;
    if (grade == 0.0 && grade < 1.0) return AssetConstants.emoticon.angry;
    if (grade >= 1.0 && grade < 2.0) return AssetConstants.emoticon.sad;
    if (grade >= 2.0 && grade < 3.0) return AssetConstants.emoticon.neutral;
    if (grade >= 3.0 && grade < 4.0) return AssetConstants.emoticon.happy;
    if (grade >= 4.0) return AssetConstants.emoticon.excited;

    return AssetConstants.emoticon.neutral;
  }

  String _getEmotionText(double? grade) {
    if (grade == null) return S.current.textNeutral;
    if (grade == 0.0 && grade < 1.0) return S.current.textAngry;
    if (grade >= 1.0 && grade < 2.0) return S.current.textUpset;
    if (grade >= 2.0 && grade < 3.0) return S.current.textNeutral;
    if (grade >= 3.0 && grade < 4.0) return S.current.textHappy;
    if (grade >= 4.0) return S.current.textExcited;

    return S.current.textNeutral;
  }

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
          _mountEmotion(),
          const SizedBox(width: 4.0),
          _mountReview(),
          _mountMoreButton(),
        ],
      ),
    );
  }

  Widget _mountEmotion() {
    return Column(
      mainAxisAlignment:
          _isTextExpanded ? MainAxisAlignment.start : MainAxisAlignment.center,
      children: [
        SvgPicture.asset(_getEmotionImage(widget.review.myGrade)),
        const SizedBox(height: 4.0),
        Text(
          _getEmotionText(widget.review.myGrade),
          style: TextStyles.bodyText2(),
        ),
      ],
    );
  }

  Widget _mountReview() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _mountReviewTitle(),
        _mountReviewBody(),
      ],
    );
  }

  Widget _mountReviewBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.5,
          child: Text(
            widget.review.review ?? StringConstants.empty,
            style: TextStyles.caption(),
            softWrap: true,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.start,
            maxLines: _isTextExpanded ? 30 : 3,
          ),
        ),
        const SizedBox(width: 4),
        Visibility(
          visible: widget.review.review!.length > 80,
          child: GestureDetector(
            onTap: doSeeMore,
            child: Text(
              _textSeeMore,
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

  Widget _mountReviewTitle() {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.5,
      child: Text(
        widget.review.location?.name ?? StringConstants.empty,
        style: TextStyles.subtitle2(),
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
    );
  }

  Widget _mountMoreButton() {
    return IconButton(
      padding: EdgeInsets.zero,
      alignment: Alignment.topRight,
      icon: Icon(
        Icons.more_horiz,
        color: SafeColors.buttonColors.primary,
      ),
      onPressed: () => SafeModal(
        tiles: [
          _mountDeleteButton(),
          _mountShareButton(),
        ],
      ).show(context),
    );
  }

  _mountDeleteButton() {
    return ModalTile(
      text: S.current.textDelete,
      icon: Icons.delete_outline_rounded,
      onTap: widget.onDelete ??
          () {
            Navigator.pop(context);
            return SafeSnackBar(
              message: S.current.textFeatureAvailableSoon,
              type: SnackBarType.info,
            ).show(context);
          },
    );
  }

  _mountShareButton() {
    return ModalTile(
      text: S.current.textShare,
      icon: Icons.share,
      onTap: widget.onShare ??
          () {
            Navigator.pop(context);
            return SafeSnackBar(
              message: S.current.textFeatureAvailableSoon,
              type: SnackBarType.info,
            ).show(context);
          },
    );
  }
}
