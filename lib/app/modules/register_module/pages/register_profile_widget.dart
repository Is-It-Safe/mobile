import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/app/modules/register_module/register_bloc.dart';
import 'package:is_it_safe_app/core/components/app_bar.dart';
import 'package:is_it_safe_app/core/components/main_button.dart';
import 'package:is_it_safe_app/core/components/main_text_field.dart';
import 'package:is_it_safe_app/core/components/theme_switch.dart';
import 'package:is_it_safe_app/core/utils/constants/routes.dart';
import 'package:is_it_safe_app/core/utils/helper/helpers.dart';
import 'package:is_it_safe_app/core/utils/style/colors/dark_theme_colors.dart';
import 'package:is_it_safe_app/core/utils/style/colors/general_colors.dart';
import 'package:is_it_safe_app/core/utils/style/colors/light_theme_colors.dart';
import 'package:is_it_safe_app/generated/l10n.dart';

import 'dart:developer' as dev;

class RegisterProfileWidget extends StatefulWidget {
  const RegisterProfileWidget({Key? key}) : super(key: key);

  @override
  _RegisterProfileWidgetState createState() => _RegisterProfileWidgetState();
}

class _RegisterProfileWidgetState
    extends ModularState<RegisterProfileWidget, RegisterBloc> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    dev.log(Modular.to.path, name: "PATH");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: appBar(
        context: context,
        hasLeading: false,
        title: S.of(context).textAppBarProfileRegisterPage,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  const ThemeSwitch(),
                  RegisterAvatarPlaceholder(
                    //TODO Rota para selecionar avatar
                    onTap: () =>
                        Modular.to.pushNamed(kRouteRegisterProfilePicture),
                  ),
                  // RegisterAvatar(
                  //   path: 'images/app/profile_pictures/profile_pic_1.png',
                  //   onTap: () {
                  //     //TODO Rota para selecionar avatar
                  //   },
                  // ),

                  ///Choose picture text
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Text(
                      S.of(context).textPageTitleProfileRegisterPage,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: TextFormField(
                      inputFormatters: [controller.birthdayInputMask],
                      controller: controller.birthdayController,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (!Helpers.validateDate(value)) {
                          return S.of(context).textErrorInvalidDate;
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: S.of(context).textDateOfBirth,
                      ),
                    ),
                  ),

                  //TODO Implement gender dropdown component
                  Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: TextFormField(),
                  ),
                  //TODO Implement sexual orientation dropdown component
                  Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: TextFormField(),
                  ),

                  /// Register button
                  Padding(
                    padding: const EdgeInsets.only(top: 32.0),
                    child: MainButton(
                      color: Theme.of(context).primaryColor,
                      text: S.of(context).textSignUp,
                      onTap: () async {},
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class RegisterAvatar extends StatelessWidget {
  final Function()? onTap;
  final String path;
  const RegisterAvatar({
    Key? key,
    this.onTap,
    required this.path,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 120,
        width: 120,
        decoration: BoxDecoration(
          color: Helpers.getColorFromTheme(
            context: context,
            darkModeColor: avatarBackgroundColorDark,
            lightModeColor: avatarBackgroundColorLight,
          ),
          shape: BoxShape.circle,
          image: DecorationImage(
            fit: BoxFit.cover,
            alignment: Alignment.topCenter,
            image: AssetImage(path),
          ),
        ),
      ),
    );
  }
}

class RegisterAvatarPlaceholder extends StatelessWidget {
  final Function()? onTap;
  const RegisterAvatarPlaceholder({
    Key? key,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              Helpers.getImageFromTheme(
                context: context,
                darkModeImagePath:
                    'images/app/profile_pictures/placeholder/placeholder_avatar_dark.png',
                lightModeImagePath:
                    'images/app/profile_pictures/placeholder/placeholder_avatar_light.png',
              ),
            ),
          ),
        ),
      ),
    );
  }
}
