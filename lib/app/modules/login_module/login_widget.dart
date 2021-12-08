import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/core/components/main_button.dart';
import 'package:is_it_safe_app/core/components/theme_switch.dart';
import 'package:is_it_safe_app/core/data/service/config/base_response.dart';
import 'package:is_it_safe_app/core/utils/config/custom_shared_preferences.dart';
import 'package:is_it_safe_app/core/utils/constants/routes.dart';
import 'package:is_it_safe_app/core/utils/helper/helpers.dart';
import 'package:is_it_safe_app/core/utils/helper/manage_dialogs.dart';
import 'package:is_it_safe_app/core/utils/style/colors/dark_theme_colors.dart';
import 'package:is_it_safe_app/core/utils/style/colors/general_colors.dart';
import 'package:is_it_safe_app/core/utils/style/colors/light_theme_colors.dart';
import 'package:is_it_safe_app/generated/l10n.dart';

import 'login_bloc.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({Key? key}) : super(key: key);

  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends ModularState<LoginWidget, LoginBloc> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  bool _showPassword = true;

  @override
  void initState() {
    super.initState();
    _loginStream();
  }

  _loginStream() async {
    controller.loginController.stream.listen((event) async {
      switch (event.status) {
        case Status.COMPLETED:
          Modular.to.pushNamedAndRemoveUntil(kRouteHome, (p0) => false);
          break;
        case Status.LOADING:
          ManagerDialogs.showLoadingDialog(context);
          break;
        case Status.ERROR:
          Modular.to.pop();
          ManagerDialogs.showErrorDialog(context, event.message!);
          break;
        default:
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ///Text
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "${S.of(context).textPageTitleLogin}\n",
                            style: Theme.of(context)
                                .textTheme
                                .headline4!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: S.of(context).textPageSubtitleLogin,
                            style: Theme.of(context).textTheme.headline5,
                          ),
                        ],
                      ),
                    ),
                  ),

                  ///Username Field
                  Padding(
                    padding: const EdgeInsets.only(bottom: 18.0),
                    child: TextFormField(
                      controller: controller.usernameController,
                      decoration: InputDecoration(
                        hintText: S.of(context).textUsername,
                      ),
                      onChanged: (value) => controller.enableLoginButton(),
                      validator: (value) {
                        if (value == null
                            ? false
                            : !Helpers.validateName(value)) {
                          return S.of(context).textErrorLoginUsername;
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),

                  ///Password Field
                  TextFormField(
                    controller: controller.passwordController,
                    decoration: InputDecoration(
                      hintText: S.of(context).textPassword,
                      suffixIcon: GestureDetector(
                        onTap: () => setState(() {
                          _showPassword = !_showPassword;
                        }),
                        child: IconTheme(
                          data: Theme.of(context)
                              .iconTheme
                              .copyWith(color: scaffoldBackgroundColorDark),
                          child: Icon(
                            _showPassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                        ),
                      ),
                    ),
                    obscureText: _showPassword,
                    onChanged: (value) => controller.enableLoginButton(),
                    validator: (value) {
                      if (value == null
                          ? false
                          : !Helpers.validatePassword(value)) {
                        return S.of(context).textErrorLoginPassword;
                      } else {
                        return null;
                      }
                    },
                  ),

                  ///Forgot the password button
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          //TODO add navigation to ForgotPassword
                        },
                        child: Text(
                          S.of(context).textButtonForgotPassword,
                          style:
                              Theme.of(context).textTheme.subtitle2!.copyWith(
                                    decoration: TextDecoration.underline,
                                  ),
                        ),
                      ),
                    ),
                  ),

                  ///Login button
                  StreamBuilder<bool>(
                    stream: controller.loginButtonController.stream,
                    initialData: false,
                    builder: (context, snapshot) {
                      return MainButton(
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            await controller.doLogin();
                          }
                        },
                        text: S.of(context).textLogin,
                        color: snapshot.data == false
                            ? Theme.of(context).disabledColor
                            : null,
                      );
                    },
                  ),

                  ///Don't have an account button
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          S.of(context).textButtonDontHaveAccount,
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                        TextButton(
                          onPressed: () {
                            //TODO add navigation to Register
                          },
                          child: Text(
                            S.of(context).textSignUp,
                            style: TextStyle(
                              color: Helpers.getColorFromTheme(
                                context: context,
                                darkModeColor:
                                    Theme.of(context).colorScheme.secondary,
                                lightModeColor: Theme.of(context).primaryColor,
                              ),
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
