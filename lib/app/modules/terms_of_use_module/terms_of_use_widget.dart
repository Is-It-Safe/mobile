import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:is_it_safe_app/core/utils/style/colors/general_colors.dart';
import 'package:is_it_safe_app/core/utils/style/themes/text_styles.dart';

class TermsOfUseWidget extends StatelessWidget {
  const TermsOfUseWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 100,
        leading: InkWell(
          onTap: () {
            Modular.to.pop();
          },
          child: SvgPicture.asset(
            'images/app/home/drawer/back_button.svg',
            fit: BoxFit.none,
          ),
        ),
        title: Text(
          'Privacidade',
          style: TextStyles.subtitle1(),
        ),
        backgroundColor: kColorBackgroundLight,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 34),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 25,
            ),
            Text(
              'Quem pode ver minhas informações pessoais',
              style: TextStyles.subtitle2(fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo.',
              style: TextStyles.bodyText2(),
            ),
          ],
        ),
      ),
    );
  }
}
