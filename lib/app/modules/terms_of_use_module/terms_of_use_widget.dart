import 'package:flutter/material.dart';
import 'package:is_it_safe_app/core/components/app_bar.dart';
import 'package:is_it_safe_app/core/utils/style/themes/text_styles.dart';

import '../../../generated/l10n.dart';

class TermsOfUseWidget extends StatelessWidget {
  const TermsOfUseWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context: context, title: 'Privacidade', hasLeading: true),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 34),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 25,
            ),
            Text(
              S.of(context).textWhoCanSeeMyProfile,
              style: TextStyles.subtitle2(fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              S.of(context).textLoremIpsum,
              style: TextStyles.bodyText2(),
            ),
          ],
        ),
      ),
    );
  }
}
