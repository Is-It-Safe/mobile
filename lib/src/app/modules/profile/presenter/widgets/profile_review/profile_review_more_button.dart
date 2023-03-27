import 'package:flutter/material.dart';

import '../../../../../../../generated/l10n.dart';
import '../../../../../../components/style/colors/safe_colors.dart';
import '../../../../../../components/widgets/safe_modal.dart';

class ProfileReviewMoreButton extends StatelessWidget {
  final String name;
  final String review;
  final Function() onDeleteReview;
  const ProfileReviewMoreButton({
    Key? key,
    required this.name,
    required this.review,
    required this.onDeleteReview,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: EdgeInsets.zero,
      alignment: Alignment.topRight,
      icon: Icon(
        Icons.more_horiz,
        color: SafeColors.buttonColors.primary,
      ),
      onPressed: () => SafeModal(
        height: MediaQuery.of(context).size.height * 0.15,
        tiles: [
          ModalTile(
            text: S.current.textDelete,
            icon: Icons.delete_outline_rounded,
            onTap: onDeleteReview,
          ),
        ],
      ).show(context),
    );
  }
}
