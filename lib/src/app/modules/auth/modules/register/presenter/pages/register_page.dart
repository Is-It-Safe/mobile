import 'package:flutter/material.dart';
import 'package:is_it_safe_app/generated/l10n.dart';

import 'package:is_it_safe_app/src/app/modules/auth/modules/register/presenter/bloc/register_bloc.dart';
import 'package:is_it_safe_app/src/app/modules/auth/modules/register/presenter/vo/register_user_vo.dart';
import 'package:is_it_safe_app/src/app/modules/auth/modules/register/presenter/widgets/do_register_button_widget.dart';
import 'package:is_it_safe_app/src/app/modules/auth/modules/register/presenter/widgets/register_terms_and_conditions_widget.dart';
import 'package:is_it_safe_app/src/app/modules/auth/modules/register/presenter/widgets/register_user_field.dart';
import 'package:is_it_safe_app/src/app/modules/auth/modules/register/presenter/widgets/register_welcome_text_widget.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_text_form_field.dart';
import 'package:is_it_safe_app/src/core/state/safe_builder.dart';
import 'package:is_it_safe_app/src/core/state/safe_state.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_show_field_button.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_app_bar.dart';

class RegisterPage extends StatefulWidget {
  static const route = '/register/';

  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends SafeState<RegisterPage, RegisterBloc> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  late final RegisterUserVo registerUserVo;
  bool visible = false;


  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: SafeAppBar(title: S.current.textAppBarSignUp),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: SafeBuilder3<bool, bool, bool>(
            stream1: bloc.store.isRegisterButtonEnabled,
            stream2: bloc.store.isPasswordVisible,
            stream3: bloc.store.isConfirmPasswordVisible,
            builder: (
              isRegisterButtonEnabled,
              isPasswordVisible,
              isConfirmPasswordVisible,
            ) {
              return Form(
                key: _formKey,
                child: Column(
                  children: [
                    const RegisterWelcomeTextWidget(),
                    const SizedBox(height: 30),
                    ListView.separated(
                      padding: EdgeInsets.zero,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final registerTextFieldVO =
                            bloc.store.listRegisterTextFieldVO[index];

                        return RegisterTextFormField(
                          registerTextFieldVO: registerTextFieldVO,
                          onChanged: () {
                            registerTextFieldVO.validateUserData();
                            bloc.toggleRegisterButton(bloc);
                          },
                          onValidate: () {
                            registerTextFieldVO.validateUserData();

                          },
                          isPasswordVisible: isPasswordVisible,
                        );
                      },
                      separatorBuilder: (_, __) => const SizedBox(height: 20),
                      itemCount: bloc.store.listRegisterTextFieldVO.length,
                    ),
                    const SizedBox(height: 20),
                    SafeTextFormField(
                      controller: bloc.passwordController,
                      labelText: S.current.textPassword,
                      suffixIcon: SafeShowFieldButton(
                        value: isPasswordVisible,
                        onTap: () => bloc.togglePasswordVisibility(),
                      ),
                      obscureText: !isPasswordVisible,
                      onChanged: (value) => bloc.toggleRegisterButton(bloc),
                      validator: (value) => bloc.validatePassword(value),
                      bottomText: S.current.textPasswordSpecifications,
                    ),
                    const SizedBox(height: 20),
                    SafeTextFormField(
                      controller: bloc.confirmPasswordController,
                      labelText: S.current.textConfirmPassword,
                      suffixIcon: SafeShowFieldButton(
                        value: isConfirmPasswordVisible,
                        onTap: () => bloc.toggleConfirmPasswordVisibility(),
                      ),
                      obscureText: !isConfirmPasswordVisible,
                      onChanged: (value) {
                        bloc.toggleRegisterButton(bloc);
                      },
                      validator: (value) => bloc.validateConfirmPassword(value),
                    ),
                    RegisterTermsAndConditionsWidget(
                      isTermsAndConditionsChecked:
                          bloc.store.isTermsAndConditionsChecked,
                      navigateToTermsAndConditions: () =>
                          bloc.navigateToTermsAndConditions(),
                      onChanged: (_) {
                        bloc.toggleTermsAndConditions();
                        bloc.toggleRegisterButton(bloc);
                      },
                    ),
                    const SizedBox(height: 20),
                    SafeBuilder2<bool, bool>(
                      stream1: bloc.store.isUsernameAvailable,
                      stream2: bloc.store.isEmailAvailable,
                      builder: (isUsernameAvailable, isEmailAvailable) {
                        return DoRegisterButtonWidget(
                          formKey: _formKey,
                          isEnabledToRegister:
                              bloc.store.isRegisterButtonEnabled,
                          isAcceptedTerms:
                              bloc.store.isTermsAndConditionsChecked,
                          onTap: () async =>
                              await bloc.navigateToRegisterProfile(),
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
