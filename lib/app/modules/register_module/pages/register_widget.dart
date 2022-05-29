import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/app/modules/register_module/register_bloc.dart';
import 'package:is_it_safe_app/core/components/app_bar.dart';
import 'package:is_it_safe_app/core/components/my_text_form_field.dart';
import 'package:is_it_safe_app/core/components/primary_button.dart';
import 'package:is_it_safe_app/core/components/show_field_button.dart';
import 'package:is_it_safe_app/core/utils/constants/routes.dart';
import 'package:is_it_safe_app/core/utils/style/colors/general_colors.dart';
import 'package:is_it_safe_app/src/app/components/style/text_styles.dart';
import 'package:is_it_safe_app/src/core/util/log_util.dart';
import 'package:is_it_safe_app/src/core/util/validation_util.dart';
import 'package:is_it_safe_app/src/l10n/l10n.dart';

class RegisterWidget extends StatefulWidget {
  const RegisterWidget({Key? key}) : super(key: key);

  @override
  _RegisterWidgetState createState() => _RegisterWidgetState();
}

class _RegisterWidgetState extends ModularState<RegisterWidget, RegisterBloc> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();
    LogUtil().route(Modular.to.path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: appBar(
        context: context,
        hasLeading: true,
        title: S.of(context).textAppBarSignUp,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '${S.of(context).textWelcome}\n',
                          style: TextStyles.headline1(),
                        ),
                        TextSpan(
                          text: S.of(context).textMeetingYouWillBeAPleasure,
                          style: TextStyles.headline2(),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  MyTextFormField(
                    controller: controller.nameController,
                    labelText: "${S.of(context).textName}*",
                    bottomText: S.of(context).textSayYourNameThisInfoIsPrivate,
                    onChanged: (value) => controller.enableRegisterButton(),
                    validator: (value) {
                      if (value == null) {
                        return S.of(context).textErrorEmptyField;
                      }
                      if (!ValidationUtil.name(value)) {
                        return S.of(context).textErrorEmptyField;
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(height: 30),
                  MyTextFormField(
                    controller: controller.userNameController,
                    labelText: "${S.of(context).textUsername}*",
                    bottomText: S.of(context).textDontBeAfraidToBeCreative,
                    validator: (value) {
                      if (value == null) {
                        return S.of(context).textErrorEmptyField;
                      }
                      if (!ValidationUtil.name(value)) {
                        return S.of(context).textErrorEmptyField;
                      } else {
                        return null;
                      }
                    },
                    onChanged: (value) {
                      controller.enableRegisterButton();
                    },
                  ),
                  const SizedBox(height: 30),
                  MyTextFormField(
                    controller: controller.pronoumsController,
                    labelText: S.of(context).textPronouns,
                    hintText: S.of(context).textExamplePronouns,
                    bottomText: S.of(context).textHowDoYouPreferWeReferToYou,
                    onChanged: (value) => controller.enableRegisterButton(),
                    validator: (value) {
                      return null;
                    },
                  ),
                  const SizedBox(height: 30),
                  MyTextFormField(
                    controller: controller.emailController,
                    labelText: "${S.of(context).textEmailAddress}*",
                    bottomText: S
                        .of(context)
                        .textTellUsTheEmailAssociatedWithYourAccount,
                    onChanged: (value) {
                      controller.enableRegisterButton();
                    },
                    validator: (value) {
                      if (value == null) {
                        return S.of(context).textErrorEmail;
                      }
                      if (!ValidationUtil.email(value)) {
                        return S.of(context).textErrorEmail;
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(height: 30),
                  MyTextFormField(
                    controller: controller.passwordController,
                    labelText: "${S.of(context).textPassword}*",
                    obscureText: _obscurePassword,
                    suffixIcon: ShowFieldButton(
                      isDisplayed: _obscurePassword,
                      onTap: () => setState(() {
                        _obscurePassword = !_obscurePassword;
                      }),
                    ),
                    onChanged: (value) => controller.enableRegisterButton(),
                    validator: (value) {
                      if (value == null) {
                        return S.of(context).textErrorLoginPassword;
                      }
                      if (!ValidationUtil.passoword(value)) {
                        return S.of(context).textErrorLoginPassword;
                      } else {
                        return null;
                      }
                    },
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: S.of(context).textWeCareAboutYourSafety,
                              style: TextStyles.helper(fontSize: 12),
                            ),
                            TextSpan(
                              text:
                                  '\n${S.of(context).textAtLeast8Characteres}',
                              style: TextStyles.helper(fontSize: 12),
                            ),
                            TextSpan(
                              text: '\n${S.of(context).textLettersAndNumbers}',
                              style: TextStyles.helper(fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  MyTextFormField(
                    controller: controller.confirmPasswordController,
                    labelText: "${S.of(context).textPasswordConfirmation}*",
                    validator: (value) {
                      if (value == null) {
                        return S.of(context).textErrorDifferentPasswords;
                      }
                      if (!ValidationUtil.passoword(value) ||
                          controller.passwordController.text !=
                              controller.confirmPasswordController.text) {
                        return S.of(context).textErrorDifferentPasswords;
                      } else {
                        return null;
                      }
                    },
                    onChanged: (value) {
                      controller.enableRegisterButton();
                    },
                    obscureText: _obscurePassword,
                    suffixIcon: ShowFieldButton(
                      isDisplayed: _obscurePassword,
                      onTap: () => setState(() {
                        _obscurePassword = !_obscurePassword;
                      }),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Row(
                      children: [
                        Checkbox(
                          value: controller.termsAndConditionsCheckbox,
                          activeColor: SafeColors.buttonColors.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          side: const BorderSide(
                            color: SafeColors.buttonColors.primary,
                            width: 1,
                          ),
                          onChanged: (value) => setState(() {
                            controller.termsAndConditionsCheckbox =
                                !controller.termsAndConditionsCheckbox;
                            controller.enableRegisterButton();
                          }),
                        ),
                        Expanded(
                          child: RichText(
                            overflow: TextOverflow.fade,
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: S.of(context).textIReadAndAcceptThe,
                                  style: TextStyles.helper(fontSize: 12),
                                ),
                                TextSpan(
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      //TODO Navegação para termos de uso e condições
                                    },
                                  text: S.of(context).textTermsAndConditions +
                                      "*",
                                  style: TextStyles.helper(
                                    fontSize: 12,
                                    color: SafeColors.statusColors.active,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 24, bottom: 16),
                    child: StreamBuilder<bool>(
                        stream: controller.registerButtonController.stream,
                        initialData: false,
                        builder: (context, snapshot) {
                          return PrimaryButton(
                              text: S.of(context).textRegister,
                              textColor: snapshot.data == true
                                  ? SafeColors.generalColors.primary
                                  : SafeColors.textColors.label,
                              color: snapshot.data == false
                                  ? SafeColors.statusColors.disabled
                                  : null,
                              onTap: () {
                                _formKey.currentState?.validate();
                                if (snapshot.data == true) {
                                  Modular.to
                                      .pushNamed('.$kRouteRegisterProfile');
                                }
                              });
                        }),
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
