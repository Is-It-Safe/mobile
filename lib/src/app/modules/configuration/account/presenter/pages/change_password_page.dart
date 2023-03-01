import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/generated/l10n.dart';
import 'package:is_it_safe_app/src/app/modules/configuration/account/presenter/bloc/change_password_bloc.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_app_bar.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_button.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_text_form_field.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final controller = Modular.get<ChangePasswordBloC>();

  Timer? debounce;

  @override
  void initState() {
    super.initState();
    controller.confirmPasswordText.addListener(() {
      debounce = Timer(const Duration(milliseconds: 700), () async {
        await controller.confirmPassword(
            password: controller.confirmPasswordText.text);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SafeAppBar(
        title: S.current.textConfiguration,
      ),
      body: Column(
        children: [
          const Text("Confirme sua senha"),
          const Text("Insira sua senha novamente para continuar."),
          const Text("Confirme sua senha atual"),
          const SafeTextFormField(),
          Row(
            children: [
              const SafeButton(title: "Cancelar"),
              SafeButton(
                  title: "Avançar",
                  state: controller.validated ? ButtonState.disabled : null,
                  onTap: () async {
                    await controller.confirmPassword(
                        password: controller.confirmPasswordText.text);
                  }),
            ],
          ),
        ],
      ),
    );
  }
}
