import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/generated/l10n.dart';
import 'package:is_it_safe_app/src/domain/entity/login_entity.dart';
import 'package:is_it_safe_app/src/app/modules/auth/register/presenter/pages/register_page.dart';
import 'package:is_it_safe_app/src/app/modules/home/presenter/pages/home_page.dart';
import 'package:is_it_safe_app/src/app/modules/navigation/presenter/pages/navigation_page.dart';
import 'package:is_it_safe_app/src/components/style/colors/safe_colors.dart';
import 'package:is_it_safe_app/src/components/style/text/text_styles.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_button.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_dialogs.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_loading.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_show_field_button.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_text_form_field.dart';
import 'package:is_it_safe_app/src/app/modules/auth/login/presenter/bloc/login_bloc.dart';
import 'package:is_it_safe_app/src/core/constants/string_constants.dart';
import 'package:is_it_safe_app/src/core/util/log_util.dart';
import 'package:is_it_safe_app/src/components/config/safe_event.dart';

class LoginPage extends StatefulWidget {
  static const route = '/login/';
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ModularState<LoginPage, LoginBloc> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  bool _showPassword = true;

  @override
  void initState() {
    super.initState();
    LogUtil().route(Modular.to.path);
    _doLoginListen();
  }

  _doLoginListen() {
    controller.doLoginController.stream.listen((event) async {
      switch (event.status) {
        case Status.done:
          navigateToHome();
          break;
        case Status.loading:
          const SafeLoading();
          break;
        case Status.error:
          Modular.to.pop();
          SafeDialogs.error(message: event.message);
          break;
        default:
          break;
      }
    });
  }

  void navigateToHome() {
    Modular.to.pushNamedAndRemoveUntil(
      NavigationPage.route + HomePage.route,
      (r) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: StreamBuilder<SafeEvent<LoginEntity>>(
                stream: controller.doLoginController.stream,
                builder: (context, snapshot) {
                  if (snapshot.data?.status == Status.loading) {
                    return const SafeLoading();
                  } else if (snapshot.data?.status == Status.error) {
                    Modular.to.pop();
                    return SafeDialogs.error(message: snapshot.data?.message);
                  }

                  return Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _mountTitle(),
                        const SizedBox(height: 30),
                        _mountEmailField(),
                        const SizedBox(height: 18),
                        _mountPasswordField(),
                        //TODO comentar até funcionalidade for implementada
                        //_mountForgotPasswordButton(context),
                        const SizedBox(height: 30),
                        _mountLoginButton(),
                        const SizedBox(height: 12),
                        _mountRegisterButton(),
                      ],
                    ),
                  );
                }),
          ),
        ),
      ),
    );
  }

  Widget _mountRegisterButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          S.current.textButtonDontHaveAccount,
          style: TextStyles.button(),
        ),
        TextButton(
          onPressed: () {
            Modular.to.pushNamed(RegisterPage.route);
          },
          child: Text(
            S.current.textSignUp,
            style: TextStyles.button(
              color: SafeColors.buttonColors.primary,
              textDecoration: TextDecoration.underline,
            ),
          ),
        )
      ],
    );
  }

  StreamBuilder<bool> _mountLoginButton() {
    return StreamBuilder<bool>(
      stream: controller.loginButtonController.stream,
      initialData: false,
      builder: (context, snapshot) {
        return SafeButton(
          title: S.current.textLogin,
          state:
              snapshot.data == true ? ButtonState.rest : ButtonState.disabled,
          onTap: () async {
            _formKey.currentState?.validate();
            if (snapshot.data == true) {
              await controller.doLogin();
            }
          },
        );
      },
    );
  }

  Widget _mountForgotPasswordButton() {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {},
        child: Text(
          S.current.textButtonForgotPassword,
          style: TextStyles.button(
            textDecoration: TextDecoration.underline,
          ),
        ),
      ),
    );
  }

  Widget _mountPasswordField() {
    return SafeTextFormField(
      controller: controller.passwordController,
      labelText: S.current.textPassword,
      obscureText: _showPassword,
      onChanged: (value) => controller.toogleLoginButton(),
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

  Widget _mountEmailField() {
    return SafeTextFormField(
      controller: controller.emailController,
      labelText: S.current.textEmailAddress,
      keyboardType: TextInputType.emailAddress,
      onChanged: (value) => controller.toogleLoginButton(),
      validator: (value) => controller.validateEmail(
        context,
        value: value,
      ),
    );
  }

  Widget _mountTitle() {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: S.current.textPageTitleLogin + StringConstants.breakLine,
            style: TextStyles.headline1(),
          ),
          TextSpan(
            text: S.current.textPageSubtitleLogin,
            style: TextStyles.headline2(),
          ),
        ],
      ),
    );
  }
}
