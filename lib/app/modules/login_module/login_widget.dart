import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/core/components/primary_button.dart';
import 'package:is_it_safe_app/core/components/my_text_form_field.dart';
import 'package:is_it_safe_app/core/components/show_field_button.dart';
import 'package:is_it_safe_app/core/data/service/config/base_response.dart';
import 'package:is_it_safe_app/core/utils/constants/routes.dart';
import 'package:is_it_safe_app/core/utils/helper/helpers.dart';
import 'package:is_it_safe_app/core/utils/helper/log.dart';
import 'package:is_it_safe_app/core/utils/helper/manage_dialogs.dart';
import 'package:is_it_safe_app/core/utils/style/colors/general_colors.dart';
import 'package:is_it_safe_app/core/utils/style/themes/text_styles.dart';
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
    Log.route(Modular.to.path);
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
                  //TODO Remove widget down below
                  TextButton(
                    onPressed: () => Modular.to
                        .pushReplacementNamed(kRouteMain + kRouteSearch),
                    child: const Text("Search"),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30.0),
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "${S.of(context).textPageTitleLogin}\n",
                            style: TextStyles.headline1(),
                          ),
                          TextSpan(
                            text: S.of(context).textPageSubtitleLogin,
                            style: TextStyles.headline2(),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 18.0),
                    child: MyTextFormField(
                      controller: controller.usernameController,
                      labelText: S.of(context).textUsername,
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
                  MyTextFormField(
                    controller: controller.passwordController,
                    labelText: S.of(context).textPassword,
                    suffixIcon: ShowFieldButton(
                      isDisplayed: _showPassword,
                      onTap: () => setState(() {
                        _showPassword = !_showPassword;
                      }),
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
                          style: TextStyles.button(
                            fontSize: 12,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                  ),
                  StreamBuilder<bool>(
                    stream: controller.loginButtonController.stream,
                    initialData: false,
                    builder: (context, snapshot) {
                      return PrimaryButton(
                        text: S.of(context).textLogin,
                        textColor: snapshot.data == true
                            ? kColorPrimaryLight
                            : kColorTextLabel,
                        color: snapshot.data == false
                            ? kColorStatusDisabled
                            : null,
                        onTap: () async {
                          _formKey.currentState!.validate();
                          await controller.doLogin().then((value) {
                            //TODO uncomment navigation to Home
                            //() => Modular.to.pushReplacementNamed(kRouteMain + kRouteHome);
                          });
                        },
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          S.of(context).textButtonDontHaveAccount,
                          style: TextStyles.button(fontSize: 12),
                        ),
                        TextButton(
                          onPressed: () => Modular.to.pushNamed(kRouteRegister),
                          child: Text(
                            S.of(context).textSignUp,
                            style: TextStyles.button(
                              color: kColorButtonPrimary,
                              fontSize: 12,
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
