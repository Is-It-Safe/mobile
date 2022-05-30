import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/generated/l10n.dart';
import 'package:is_it_safe_app/src/app/modules/auth/register/presenter/bloc/register_bloc.dart';
import 'package:is_it_safe_app/src/components/style/colors/safe_colors.dart';
import 'package:is_it_safe_app/src/components/style/text/text_styles.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_app_bar.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_button.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_check_box.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_show_field_button.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_text_form_field.dart';
import 'package:is_it_safe_app/src/core/constants/string_constants.dart';
import 'package:is_it_safe_app/src/core/util/log_util.dart';

class RegisterPage extends StatefulWidget {
  static const route = '/register/';
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ModularState<RegisterPage, RegisterBloc> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  bool _showPassword = true;

  @override
  void initState() {
    super.initState();
    LogUtil().route(Modular.to.path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: SafeAppBar(
        title: S.of(context).textAppBarSignUp,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _mountWelcomeText(context),
                const SizedBox(height: 30),
                _mountNameField(context),
                const SizedBox(height: 20),
                _mountUsernameField(context),
                const SizedBox(height: 20),
                _mountPronounField(context),
                const SizedBox(height: 20),
                _mountEmailField(context),
                const SizedBox(height: 20),
                _mountPasswordField(context),
                const SizedBox(height: 20),
                _mountConfirmPasswordField(context),
                const SizedBox(height: 20),
                _mountTermsAndConditions(context),
                const SizedBox(height: 20),
                _mountRegisterButton(),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  StreamBuilder<bool> _mountRegisterButton() {
    return StreamBuilder<bool>(
        stream: controller.registerButtonController.stream,
        initialData: false,
        builder: (context, snapshot) {
          return SafeButton(
              title: S.of(context).textRegister,
              state: snapshot.data == true
                  ? ButtonState.rest
                  : ButtonState.disabled,
              onTap: () {
                _formKey.currentState?.validate();
                if (snapshot.data == true) {
                  //TODO Add navigation to second register page
                }
              });
        });
  }

  Row _mountTermsAndConditions(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SafeCheckBox(
          value: controller.isTermsAndConditionsChecked,
          onChanged: (value) => setState(() {
            controller.toogleTermsAndConditions();
            controller.toogleRegisterButton();
          }),
        ),
        RichText(
          overflow: TextOverflow.fade,
          text: TextSpan(
            children: [
              TextSpan(
                text: S.of(context).textIReadAndAcceptThe,
                style: TextStyles.helper(),
              ),
              TextSpan(
                  text: S.of(context).textTermsAndConditions +
                      StringConstants.asterisk,
                  style: TextStyles.helper(
                    color: SafeColors.statusColors.active,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      //TODO Add navigation to terms and conditions
                    }),
            ],
          ),
        ),
      ],
    );
  }

  SafeTextFormField _mountConfirmPasswordField(BuildContext context) {
    return SafeTextFormField(
      controller: controller.confirmPasswordController,
      obscureText: _showPassword,
      labelText:
          S.of(context).textPasswordConfirmation + StringConstants.asterisk,
      onChanged: (value) => controller.toogleRegisterButton(),
      validator: (value) => controller.validatePassword(
        context,
        value: value,
        errorText: S.of(context).textErrorDifferentPasswords,
      ),
      suffixIcon: SafeShowFieldButton(
        value: _showPassword,
        onTap: () => setState(() {
          _showPassword = !_showPassword;
        }),
      ),
    );
  }

  SafeTextFormField _mountPasswordField(BuildContext context) {
    return SafeTextFormField(
      controller: controller.passwordController,
      obscureText: _showPassword,
      labelText: S.of(context).textPassword + StringConstants.asterisk,
      bottomText: S.of(context).textTellUsTheEmailAssociatedWithYourAccount,
      onChanged: (value) => controller.toogleRegisterButton(),
      validator: (value) => controller.validatePassword(
        context,
        value: value,
      ),
      suffixIcon: SafeShowFieldButton(
        value: _showPassword,
        onTap: () => setState(() {
          _showPassword = !_showPassword;
        }),
      ),
    );
  }

  SafeTextFormField _mountEmailField(BuildContext context) {
    return SafeTextFormField(
      controller: controller.emailController,
      labelText: S.of(context).textEmailAddress + StringConstants.asterisk,
      bottomText: S.of(context).textTellUsTheEmailAssociatedWithYourAccount,
      onChanged: (value) => controller.toogleRegisterButton(),
      validator: (value) => controller.validateEmail(
        context,
        value: value,
      ),
    );
  }

  SafeTextFormField _mountPronounField(BuildContext context) {
    return SafeTextFormField(
      controller: controller.pronounController,
      labelText: S.of(context).textPronouns,
      bottomText: S.of(context).textHowDoYouPreferWeReferToYou,
      onChanged: (value) => controller.toogleRegisterButton(),
    );
  }

  SafeTextFormField _mountUsernameField(BuildContext context) {
    return SafeTextFormField(
      controller: controller.usernameController,
      labelText: S.of(context).textUsername + StringConstants.asterisk,
      bottomText: S.of(context).textDontBeAfraidToBeCreative,
      onChanged: (value) => controller.toogleRegisterButton(),
      validator: (value) => controller.validateTextField(
        context,
        value: value,
      ),
    );
  }

  SafeTextFormField _mountNameField(BuildContext context) {
    return SafeTextFormField(
      controller: controller.nameController,
      labelText: S.of(context).textName + StringConstants.asterisk,
      bottomText: S.of(context).textSayYourNameThisInfoIsPrivate,
      onChanged: (value) => controller.toogleRegisterButton(),
      validator: (value) => controller.validateTextField(
        context,
        value: value,
      ),
    );
  }

  RichText _mountWelcomeText(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: S.of(context).textWelcome + StringConstants.breakLine,
            style: TextStyles.headline1(),
          ),
          TextSpan(
            text: S.of(context).textMeetingYouWillBeAPleasure,
            style: TextStyles.headline2(),
          ),
        ],
      ),
    );
  }
}
