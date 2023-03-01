import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../../../generated/l10n.dart';
import '../../../../../../components/style/colors/safe_colors.dart';
import '../../../../../../components/widgets/safe_modal.dart';
import '../../../../../../components/widgets/safe_snack_bar.dart';
import '../../../../../../core/constants/string_constants.dart';

class ProfileReviewMoreButton extends StatelessWidget {
  final String name;
  final String review;
  const ProfileReviewMoreButton(
      {Key? key, required this.name, required this.review})
      : super(key: key);

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
        tiles: [
          _DeleteButton(
            text: S.current.textDelete,
            icon: Icons.delete_outline_rounded,
            onTap: () {
              Navigator.pop(context);
              return SafeSnackBar(
                message: S.current.textFeatureAvailableSoon,
                type: SnackBarType.info,
              ).show(context);
            },
          ),
          _ShareButton(
            text: S.current.textShare,
            icon: Icons.share,
            onTap: () {
              ClipboardUtils.copy('$name: $review');

              ClipboardUtils.paste().toString();
              Navigator.pop(context);
              return SafeSnackBar(
                message: S.current.textShareUserReview,
                type: SnackBarType.info,
              ).show(context);
            },
          ),
        ],
      ).show(context),
    );
  }
}

class _DeleteButton extends ModalTile {
  const _DeleteButton(
      {required String text, required IconData icon, required Function() onTap})
      : super(text: text, icon: icon, onTap: onTap);

  @override
  Widget build(BuildContext context) {
    return ModalTile(
      text: text,
      icon: icon,
      onTap: onTap,
    );
  }
}

class _ShareButton extends ModalTile {
  const _ShareButton({
    required String text,
    required IconData icon,
    required Function() onTap,
  }) : super(text: text, icon: icon, onTap: onTap);

  @override
  Widget build(BuildContext context) {
    return ModalTile(
      text: text,
      icon: icon,
      onTap: onTap,
    );
  }
}

///Classe para compartilhamento da review
class ClipboardUtils {
  ClipboardUtils._();

  static Future<void> copy<String>(value) async {
    await Clipboard.setData(ClipboardData(text: value.toString()));
  }

  static Future<dynamic> paste() async {
    final result = await Clipboard.getData(Clipboard.kTextPlain);
    return result?.text ?? StringConstants.empty;
  }
}
