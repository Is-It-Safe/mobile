import 'package:flutter/material.dart';
import 'package:is_it_safe_app/generated/l10n.dart';
import 'package:is_it_safe_app/src/components/style/colors/safe_colors.dart';
import 'package:is_it_safe_app/src/components/style/text/text_styles.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_profile_avatar.dart';
import 'package:is_it_safe_app/src/core/constants/assets_constants.dart';
import 'package:is_it_safe_app/src/core/constants/string_constants.dart';
import 'package:is_it_safe_app/src/core/util/formatter_util.dart';
import 'package:is_it_safe_app/src/domain/entity/review_entity.dart';

class SafeReviewCard extends StatefulWidget {
  final ReviewEntity? review;

  const SafeReviewCard({
    Key? key,
    required this.review,
  }) : super(key: key);

  @override
  State<SafeReviewCard> createState() => _SafeReviewCardState();
}

class _SafeReviewCardState extends State<SafeReviewCard> {
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
        color: SafeColors.generalColors.background,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 2,
                  child: SafeProfileAvatar(
                    image: PlaceHolderAssets.profileAvatar,
                    type: ProfileAvatarType.main,
                    size: MediaQuery.of(context).size.width * 0.1,
                  ),
                ),
                Flexible(
                  fit: FlexFit.tight,
                  flex: 6,
                  child: Text(
                    widget.review?.author ?? StringConstants.empty,
                    style: TextStyles.subtitle2(),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                Flexible(
                  flex: 4,
                  child: Text(
                    FormatterUtil.dateFormatter(
                      widget.review?.createdAt ?? StringConstants.empty,
                    ),
                    style: TextStyles.bodyText2(),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 14),
                  width: MediaQuery.of(context).size.width,
                  child: (widget.review?.review?.length ?? 0) > 200
                      ? Text(
                          _isTextExpanded
                              ? widget.review?.review ?? StringConstants.empty
                              : '${widget.review?.review?.substring(0, 200)}...',
                          style: TextStyles.bodyText2(),
                          softWrap: true,
                          textAlign: TextAlign.left,
                        )
                      : Text(
                          widget.review?.review ?? StringConstants.empty,
                          style: TextStyles.bodyText2(),
                          softWrap: true,
                          textAlign: TextAlign.left,
                        ),
                ),
                const SizedBox(height: 4),
                Visibility(
                  visible: (widget.review?.review?.length ?? 0) >= 200,
                  child: GestureDetector(
                    onTap: doSeeMore,
                    child: _textSeeMore != S.current.textSeeMore
                        ? Text(
                            _textSeeMore,
                            style: TextStyles.caption(
                              color: SafeColors.buttonColors.primary,
                              textDecoration: TextDecoration.underline,
                            ),
                          )
                        : Text(
                            _textSeeMore,
                            style: TextStyles.caption(
                              color: SafeColors.buttonColors.primary,
                              textDecoration: TextDecoration.underline,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
