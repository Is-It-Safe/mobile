import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:is_it_safe_app/src/l10n/l10n.dart';
import 'package:is_it_safe_app/src/components/style/colors/safe_colors.dart';
import 'package:is_it_safe_app/src/components/style/text/text_styles.dart';
import 'package:is_it_safe_app/src/core/constants/assets_constants.dart';

class SafeEmptyCard extends StatelessWidget {
  final String image;
  final String text;

  const SafeEmptyCard({
    Key? key,
    required this.image,
    required this.text,
  }) : super(key: key);

  static Widget home() {
    return SafeEmptyCard(
      image: AssetConstants.empty.home,
      text: S.current.textErrorHome,
    );
  }

  static Widget search({String? message}) {
    return SafeEmptyCard(
      image: AssetConstants.empty.search,
      text: message ?? S.current.textErrorSearch,
    );
  }

  static Widget profile() {
    return SafeEmptyCard(
      image: AssetConstants.empty.profile,
      text: S.current.textErrorProfile,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Column(
          children: [
            SvgPicture.asset(image),
            const SizedBox(height: 24),
            Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyles.bodyText1(
                color: SafeColors.textColors.label,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
