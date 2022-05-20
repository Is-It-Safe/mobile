import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/core/utils/config/custom_shared_preferences.dart';
import 'package:is_it_safe_app/core/utils/constants/routes.dart';
import 'package:is_it_safe_app/generated/l10n.dart';

///Widget responsável por montar as telas de OnBoarding.
///
///Pode ser implementado da seguinte forma:
///
/// ```dart
///OnBoardingPageTemplate(
///   imagePath: "images/app/on_boarding/onBoarding1.png",
///   text: RichText(text: TextSpan(text: 'Hello ')),
///   haveButton: false,
/// ),
/// ```
class OnBoardingPageTemplate extends StatelessWidget {
  final String? imagePath;
  final RichText? text;
  final bool? haveButton;
  final Widget? button;
  const OnBoardingPageTemplate({
    Key? key,
    this.imagePath,
    this.text,
    this.button,
    this.haveButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(imagePath!),
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
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 32.0),
                  child: IconButton(
                    icon: IconTheme(
                      data: Theme.of(context)
                          .iconTheme
                          .copyWith(color: Colors.white),
                      child: const Icon(
                        Icons.close,
                      ),
                    ),
                    onPressed: () async {
                      await CustomSharedPreferences.saveUsuarioOnBoarding(true);
                      Modular.to.pushNamedAndRemoveUntil(
                          kRouteLogin, ModalRoute.withName('/'));
                    },
                  ),
                ),
              ),
              const Spacer(),
              if (!haveButton!)
                Padding(
                  padding: const EdgeInsets.fromLTRB(32, 0, 32, 72),
                  child: text,
                ),
              if (haveButton!)
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(32, 0, 32, 22),
                      child: text,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 64),
                      child: GestureDetector(
                        onTap: () async {
                          await CustomSharedPreferences.saveUsuarioOnBoarding(
                            true,
                          );
                          Modular.to.navigate(kRouteLogin);
                        },
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
                              //TODO: Ajuste Theme para TextStyles
                              S.of(context).textLogin,
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1!
                                  .copyWith(
                                    color: Colors.white,
                                  ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              else
                Container(),
            ],
          ),
        ),
      ],
    );
  }
}
