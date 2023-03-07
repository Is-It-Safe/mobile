import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/generated/l10n.dart';
import 'package:is_it_safe_app/src/app/modules/configuration/account/presenter/bloc/change_password_bloc.dart';
import 'package:is_it_safe_app/src/components/style/text/text_styles.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_app_bar.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_button.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_show_field_button.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_text_form_field.dart';

class ChangePasswordPage extends StatefulWidget {
  static String route = "/changePassword";
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final controller = Modular.get<ChangePasswordBloC>();

  @override
  void initState() {
    super.initState();
    controller.newPasswordText.addListener(() {
      controller.validateNewPassword;
      setState(() {});
    });
    controller.confirmNewPasswordText.addListener(() {
      controller.validateNewPassword;
      setState(() {});
    });
  }

  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SafeAppBar(
        title: S.current.textDrawerMyAccount,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                S.current.textChangePassword,
                style: TextStyles.headline2(),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  "${S.current.textConfirmCurrentPassword}\n",
                  style: TextStyles.subtitle1(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 46, bottom: 9.29),
                child: Text(
                  'Nova senha',
                  style: TextStyles.bodyText1(),
                ),
              ),
              SafeTextFormField(
                controller: controller.newPasswordText,
                obscuringCharacter: '*',
                obscureText: _showPassword,
                suffixIcon: SafeShowFieldButton(
                  value: _showPassword,
                  onTap: () => setState(() {
                    _showPassword = !_showPassword;
                  }),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 9.29),
                child: Text(
                  'Confirme sua nova senha',
                  style: TextStyles.bodyText1(),
                ),
              ),
              SafeTextFormField(
                controller: controller.confirmNewPasswordText,
                obscuringCharacter: '*',
                obscureText: _showPassword,
                suffixIcon: SafeShowFieldButton(
                  value: _showPassword,
                  onTap: () => setState(() {
                    _showPassword = !_showPassword;
                  }),
                ),
              ),
              const SizedBox(height: 60),
              SafeButton(
                  title: "Atualizar senha",
                  size: ButtonSize.large,
                  state: !controller.validateNewPassword
                      ? ButtonState.disabled
                      : null,
                  onTap: () async {
                    // TODO: Terminar implementação quando o endpoint estiver pronto
                    await controller.changePassword(password: 'password');
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
