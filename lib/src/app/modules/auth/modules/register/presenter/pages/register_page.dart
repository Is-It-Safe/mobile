import 'package:flutter/material.dart';
import 'package:is_it_safe_app/generated/l10n.dart';

import 'package:is_it_safe_app/src/app/modules/auth/modules/register/presenter/bloc/register_bloc.dart';
import 'package:is_it_safe_app/src/app/modules/auth/modules/register/presenter/widgets/do_register_button_widget.dart';
import 'package:is_it_safe_app/src/app/modules/auth/modules/register/presenter/widgets/register_terms_and_conditions_widget.dart';
import 'package:is_it_safe_app/src/app/modules/auth/modules/register/presenter/widgets/register_user_field.dart';
import 'package:is_it_safe_app/src/app/modules/auth/modules/register/presenter/widgets/register_welcome_text_widget.dart';
import 'package:is_it_safe_app/src/core/constants/string_constants.dart';
import 'package:is_it_safe_app/src/core/state/safe_builder.dart';
import 'package:is_it_safe_app/src/core/state/safe_state.dart';
import 'package:is_it_safe_app/src/core/util/user_sign_in_util.dart';
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

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: SafeAppBar(title: S.current.textAppBarSignUp),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: SafeBuilder2<bool, bool>(
            stream1: bloc.store.isRegisterButtonEnabled,
            stream2: bloc.store.isPasswordVisible,
            builder: (
              isRegisterButtonEnabled,
              isPasswordVisible,
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
                            registerTextFieldVO.validateUserData(
                              currentPassword: UserSignInUtil.isPasswordConfirm(
                                userSignInEnum:
                                    registerTextFieldVO.userSignInEnum,
                              )
                                  ? bloc.getCurrentPassword()
                                  : StringConstants.empty,
                            );
                            bloc.toggleRegisterButton();
                          },
                          onValidate: () {
                            registerTextFieldVO.validateUserData(
                              currentPassword: UserSignInUtil.isPasswordConfirm(
                                userSignInEnum:
                                    registerTextFieldVO.userSignInEnum,
                              )
                                  ? bloc.getCurrentPassword()
                                  : StringConstants.empty,
                            );
                          },
                          suffixIcon: Visibility(
                            visible: UserSignInUtil.isObscureFormField(
                              userSignInEnum:
                                  registerTextFieldVO.userSignInEnum,
                            ),
                            child: SafeShowFieldButton(
                              value: isPasswordVisible,
                              onTap: () => bloc.togglePasswordVisibility(),
                            ),
                          ),
                          isPasswordVisible: isPasswordVisible,
                        );
                      },
                      separatorBuilder: (_, __) => const SizedBox(height: 20),
                      itemCount: bloc.store.listRegisterTextFieldVO.length,
                    ),
                    RegisterTermsAndConditionsWidget(
                      isTermsAndConditionsChecked:
                          bloc.store.isTermsAndConditionsChecked,
                      navigateToTermsAndConditions: () =>
                          bloc.navigateToTermsAndConditions(),
                      onChanged: (_) {
                        bloc.toggleTermsAndConditions();
                        bloc.toggleRegisterButton();
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
