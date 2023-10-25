import 'package:flutter/material.dart';
import 'package:is_it_safe_app/generated/l10n.dart';
import 'package:is_it_safe_app/src/app/modules/auth/modules/login/presenter/bloc/login_bloc.dart';
import 'package:is_it_safe_app/src/app/modules/auth/modules/login/presenter/widgets/login_button_widget.dart';
import 'package:is_it_safe_app/src/app/modules/auth/modules/login/presenter/widgets/login_page_title_widget.dart';
import 'package:is_it_safe_app/src/app/modules/auth/modules/login/presenter/widgets/register_button_widget.dart';
import 'package:is_it_safe_app/src/core/state/safe_builder.dart';
import 'package:is_it_safe_app/src/core/state/safe_state.dart';
import 'package:is_it_safe_app/src/domain/entity/login_entity.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_show_field_button.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_text_form_field.dart';

import '../../../../../../../components/style/text/text_styles.dart';

class LoginPage extends StatefulWidget {
  static const route = '/login/';
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends SafeState<LoginPage, LoginBloc> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      key: _scaffoldKey,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: SafeBuilder2<LoginEntity?, bool>(
              stream1: bloc.loginEntityStream,
              stream2: bloc.isPassowordVisible,
              builder: (loginEntity, isPasswordVisible) {
                return Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const LoginPageTitleWidget(),
                      const SizedBox(height: 30),
                      SafeTextFormField(
                        controller: bloc.emailController,
                        labelText: S.current.textEmailAddress,
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value) => bloc.toogleLoginButton(),
                        validator: (value) => bloc.validateEmail(value),
                      ),
                      const SizedBox(height: 18),
                      SafeTextFormField(
                        controller: bloc.passwordController,
                        labelText: S.current.textPassword,
                        obscureText: !isPasswordVisible,
                        onChanged: (value) => bloc.toogleLoginButton(),
                        validator: (value) => bloc.validatePassword(value),
                        suffixIcon: SafeShowFieldButton(
                          value: isPasswordVisible,
                          onTap: () => bloc.tooglePasswordVisibility(),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () => bloc.forgotPassword(),
                          child: Text(
                            S.current.textButtonForgotPassword,
                            style: TextStyles.button(
                              textDecoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      LoginButtonWidget(
                        loginButtonStream: bloc.isLoginEnabled,
                        formKey: _formKey,
                        doLogin: () => bloc.doLogin(),
                      ),
                      const SizedBox(height: 12),
                      const RegisterButtonWidget(),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
