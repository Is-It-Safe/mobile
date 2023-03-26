import 'package:flutter/material.dart';
import 'package:is_it_safe_app/generated/l10n.dart';
import 'package:is_it_safe_app/src/components/style/colors/safe_colors.dart';
import 'package:is_it_safe_app/src/components/style/text/text_styles.dart';

class OnBoardingWidget extends StatelessWidget {
  final String backgroundImage;
  final Widget text;
  final bool? isButtonVisible;
  final Function()? onButtonPressed;

  const OnBoardingWidget({
    Key? key,
    required this.backgroundImage,
    required this.text,
    this.isButtonVisible = false,
    this.onButtonPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(backgroundImage),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.grey[800]!,
                Colors.transparent,
                Colors.grey[900]!,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _mountSkipButton(),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 64),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(32, 0, 32, 22),
                      child: text,
                    ),
                    Visibility(
                      visible: isButtonVisible ?? false,
                      child: _mountLoginButton(context),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _mountLoginButton(BuildContext context) {
    return GestureDetector(
      onTap: onButtonPressed,
      child: Padding(
        padding: const EdgeInsets.only(left: 64, right: 64),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: Colors.white,
              width: 1.5,
            ),
          ),
          child: Text(
            S.current.textLogin,
            textAlign: TextAlign.center,
            style: TextStyles.subtitle1(
              color: SafeColors.textColors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _mountSkipButton() {
    final isVisible = isButtonVisible == true ? false : true;
    return Visibility(
      visible: isVisible,
      child: Align(
        alignment: Alignment.topRight,
        child: Padding(
          padding: const EdgeInsets.only(right: 32.0),
          child: IconButton(
            icon: Icon(
              Icons.close,
              color: SafeColors.generalColors.white,
            ),
            onPressed: onButtonPressed,
          ),
        ),
      ),
    );
  }
}
