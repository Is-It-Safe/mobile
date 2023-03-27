import 'package:flutter/material.dart';
import 'package:is_it_safe_app/generated/l10n.dart';
import 'package:is_it_safe_app/src/app/modules/auth/register/presenter/widgets/do_register_button_widget.dart';
import 'package:is_it_safe_app/src/app/modules/auth/register/presenter/widgets/register_terms_and_conditions_widget.dart';
import 'package:is_it_safe_app/src/app/modules/auth/register/presenter/widgets/register_welcome_text_widget.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_show_field_button.dart';
import 'package:is_it_safe_app/src/core/state/safe_builder.dart';
import 'package:is_it_safe_app/src/core/state/safe_state.dart';
import 'package:is_it_safe_app/src/domain/entity/register_entity.dart';
import 'package:is_it_safe_app/src/app/modules/auth/register/presenter/bloc/register_bloc.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_app_bar.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_text_form_field.dart';
import 'package:is_it_safe_app/src/core/constants/string_constants.dart';

class RegisterPage extends StatefulWidget {
  static const route = '/register/';
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends SafeState<RegisterPage, RegisterBloc> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: SafeAppBar(title: S.current.textAppBarSignUp),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: SafeBuilder3<RegisterEntity?, bool, bool>(
              stream1: bloc.store.registerEntity,
              stream2: bloc.store.isRegisterButtonEnabled,
              stream3: bloc.store.isPassowordVisible,
              builder: (registerEntity, isRegisterButtonEnabled,
                  isPassowordVisible) {
                return Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const RegisterWelcomeTextWidget(),
                      const SizedBox(height: 30),
                      SafeTextFormField(
                        controller: bloc.store.nameTextController,
                        labelText:
                            S.current.textName + StringConstants.asterisk,
                        bottomText: S.current.textSayYourNameThisInfoIsPrivate,
                        onChanged: (value) => bloc.toogleRegisterButton(),
                        validator: (value) => bloc.validateName(value),
                      ),
                      const SizedBox(height: 20),
                      SafeTextFormField(
                        controller: bloc.store.usernameTextController,
                        labelText:
                            S.current.textUsername + StringConstants.asterisk,
                        bottomText: S.current.textDontBeAfraidToBeCreative,
                        onChanged: (value) => bloc.toogleRegisterButton(),
                        validator: (value) => bloc.validateName(value),
                      ),
                      const SizedBox(height: 20),
                      SafeTextFormField(
                        controller: bloc.store.pronounTextController,
                        labelText: S.current.textPronouns,
                        bottomText: S.current.textHowDoYouPreferWeReferToYou,
                        onChanged: (value) => bloc.toogleRegisterButton(),
                      ),
                      const SizedBox(height: 20),
                      SafeTextFormField(
                        controller: bloc.store.emailTextController,
                        labelText: S.current.textEmailAddress +
                            StringConstants.asterisk,
                        bottomText: S.current
                            .textTellUsTheEmailAssociatedWithYourAccount,
                        onChanged: (value) => bloc.toogleRegisterButton(),
                        validator: (value) => bloc.validateEmail(value),
                      ),
                      const SizedBox(height: 20),
                      SafeTextFormField(
                        controller: bloc.store.passwordTextController,
                        obscureText: !isPassowordVisible,
                        labelText:
                            S.current.textPassword + StringConstants.asterisk,
                        bottomText: S.current.textPasswordSpecifications,
                        onChanged: (value) => bloc.toogleRegisterButton(),
                        validator: (value) => bloc.validatePassword(value),
                        suffixIcon: SafeShowFieldButton(
                          value: isPassowordVisible,
                          onTap: () => bloc.tooglePasswordVisibility(),
                        ),
                      ),
                      const SizedBox(height: 20),
                      SafeTextFormField(
                        controller: bloc.store.confirmPasswordTextController,
                        obscureText: !isPassowordVisible,
                        labelText: S.current.textPasswordConfirmation +
                            StringConstants.asterisk,
                        onChanged: (value) => bloc.toogleRegisterButton(),
                        validator: (value) => bloc.validatePassword(
                          value,
                          errorText: S.current.textErrorDifferentPasswords,
                        ),
                        suffixIcon: SafeShowFieldButton(
                          value: isPassowordVisible,
                          onTap: () => bloc.tooglePasswordVisibility(),
                        ),
                      ),
                      const SizedBox(height: 20),
                      RegisterTermsAndConditionsWidget(
                        isTermsAndConditionsChecked:
                            bloc.store.isTermsAndConditionsChecked,
                        navigateToTermsAndConditions: () =>
                            bloc.navigateToTermsAndConditions(),
                        onChanged: (_) {
                          bloc.toogleTermsAndConditions();
                          bloc.toogleRegisterButton();
                        },
                      ),
                      const SizedBox(height: 20),
                      DoRegisterButtonWidget(
                        formKey: _formKey,
                        isEnabledToRegister: bloc.store.isRegisterButtonEnabled,
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                );
              }),
        ),
      ),
    );
  }
}
