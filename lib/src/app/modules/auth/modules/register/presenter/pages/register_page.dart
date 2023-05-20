import 'package:flutter/material.dart';
import 'package:is_it_safe_app/generated/l10n.dart';
import 'package:is_it_safe_app/src/app/modules/auth/modules/register/presenter/bloc/register_bloc.dart';
import 'package:is_it_safe_app/src/app/modules/auth/modules/register/presenter/widgets/do_register_button_widget.dart';
import 'package:is_it_safe_app/src/app/modules/auth/modules/register/presenter/widgets/register_terms_and_conditions_widget.dart';
import 'package:is_it_safe_app/src/app/modules/auth/modules/register/presenter/widgets/register_welcome_text_widget.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_show_field_button.dart';
import 'package:is_it_safe_app/src/core/constants/string_constants.dart';
import 'package:is_it_safe_app/src/core/enum/user_sign_in_enum.dart';
import 'package:is_it_safe_app/src/core/state/safe_builder.dart';
import 'package:is_it_safe_app/src/core/state/safe_state.dart';
import 'package:is_it_safe_app/src/core/util/user_sign_in_util.dart';
import 'package:is_it_safe_app/src/domain/entity/register_entity.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_app_bar.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_text_form_field.dart';

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
              stream3: bloc.store.isPasswordVisible,
              builder: (
                registerEntity,
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
                        itemBuilder: (context, index) => SafeTextFormField(
                          controller:
                              bloc.store.registerUserVoList[index].controller,
                          labelText: UserSignInUtil.getCorrectLabelForSignIn(
                            userSignInEnum: bloc
                                .store.registerUserVoList[index].userSignInEnum,
                          ),
                          bottomText:
                              UserSignInUtil.getCorrectBottomTextForSignIn(
                            userSignInEnum: bloc
                                .store.registerUserVoList[index].userSignInEnum,
                          ),
                          obscureText: bloc.store.registerUserVoList[index]
                                          .userSignInEnum ==
                                      UserSignInEnum.password ||
                                  bloc.store.registerUserVoList[index]
                                          .userSignInEnum ==
                                      UserSignInEnum.passwordConfirm
                              ? !isPasswordVisible
                              : false,
                          onChanged: (value) {
                            bloc.store.registerUserVoList[index]
                                .validateUserData(
                              currentPassword: bloc
                                          .store
                                          .registerUserVoList[index]
                                          .userSignInEnum ==
                                      UserSignInEnum.passwordConfirm
                                  ? bloc.getCurrentPassword()
                                  : StringConstants.empty,
                            );
                            bloc.toggleRegisterButton();
                          },
                          validator: (value) => bloc
                              .store.registerUserVoList[index]
                              .validateUserData(
                                  currentPassword: bloc
                                              .store
                                              .registerUserVoList[index]
                                              .userSignInEnum ==
                                          UserSignInEnum.passwordConfirm
                                      ? bloc.getCurrentPassword()
                                      : StringConstants.empty),
                          suffixIcon: Offstage(
                            offstage: !(bloc.store.registerUserVoList[index]
                                        .userSignInEnum ==
                                    UserSignInEnum.password ||
                                bloc.store.registerUserVoList[index]
                                        .userSignInEnum ==
                                    UserSignInEnum.passwordConfirm),
                            child: SafeShowFieldButton(
                              value: isPasswordVisible,
                              onTap: () => bloc.togglePasswordVisibility(),
                            ),
                          ),
                        ),
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 20),
                        itemCount: bloc.store.registerUserVoList.length,
                      ),
                      RegisterTermsAndConditionsWidget(
                        isTermsAndConditionsChecked:
                            bloc.store.isTermsAndConditionsChecked,
                        navigateToTermsAndConditions: () =>
                            bloc.navigateToTermsAndConditions(),
                        onChanged: (value) {
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
                            onTap: () async {
                              await bloc.navigateToRegisterProfile();
                            },
                          );
                        },
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
