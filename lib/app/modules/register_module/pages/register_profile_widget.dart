import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/app/modules/register_module/components/register_avatar.dart';
import 'package:is_it_safe_app/app/modules/register_module/components/register_avatar_placeholder.dart';
import 'package:is_it_safe_app/app/modules/register_module/register_bloc.dart';
import 'package:is_it_safe_app/core/components/app_bar.dart';
import 'package:is_it_safe_app/core/components/my_text_form_field.dart';
import 'package:is_it_safe_app/core/components/primary_button.dart';
import 'package:is_it_safe_app/core/components/theme_switch.dart';
import 'package:is_it_safe_app/core/utils/constants/routes.dart';
import 'package:is_it_safe_app/core/utils/helper/helpers.dart';
import 'package:is_it_safe_app/core/utils/helper/log.dart';
import 'package:is_it_safe_app/core/utils/style/colors/general_colors.dart';
import 'package:is_it_safe_app/core/utils/style/themes/text_styles.dart';
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
    Log.route(Modular.to.path);
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
                children: [
                  StreamBuilder<String>(
                    stream: controller.profileAvatarController.stream,
                    builder: (context, snapshot) {
                      return snapshot.hasData == false
                          ? RegisterAvatarPlaceholder(
                              onTap: () => Modular.to.pushNamed(
                                '.$kRouteRegisterProfilePicture',
                              ),
                            )
                          : RegisterAvatar(
                              path: controller.selectedProfileAvatarPhoto,
                              onTap: () => Modular.to.pushNamed(
                                '.$kRouteRegisterProfilePicture',
                              ),
                            );
                    },
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Text(
                      S.of(context).textPageTitleProfileRegisterPage,
                      style: TextStyles.subtitle2(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Text(
                      S.of(context).textYourRepresentationHereInside,
                      style: TextStyles.helper(fontSize: 12),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: MyTextFormField(
                      controller: controller.birthdayController,
                      labelText: S.of(context).textDateOfBirth,
                      inputFormatters: [controller.birthdayInputMask],
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (!Helpers.validateDate(value)) {
                          return S.of(context).textErrorInvalidDate;
                        }
                        return null;
                      },
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
                    child: Row(
                      children: [
                        PrimaryButton(
                          color: Colors.transparent,
                          width: MediaQuery.of(context).size.width * 0.4,
                          text: S.of(context).textAdvance,
                          onTap: () async {},
                        ),
                        PrimaryButton(
                          text: S.of(context).textSignUp,
                          width: MediaQuery.of(context).size.width * 0.4,
                          textColor: kColorPrimaryLight,
                          onTap: () async {},
                        ),
                      ],
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
