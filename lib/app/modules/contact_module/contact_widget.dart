import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:is_it_safe_app/app/modules/contact_module/contact_bloc.dart';
import 'package:is_it_safe_app/core/components/all.dart';
import 'package:is_it_safe_app/core/utils/constants/routes.dart';
import 'package:is_it_safe_app/core/utils/helper/manage_dialogs.dart';
import 'package:is_it_safe_app/core/utils/style/all.dart';

class ContactWidget extends StatefulWidget {
  const ContactWidget({ Key? key }) : super(key: key);

  @override
  _ContactWidgetState createState() => _ContactWidgetState();
}

class _ContactWidgetState extends ModularState<ContactWidget, ContactBloc> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: appBar(
      context: context,
      title: 'Contato',
      hasLeading: true
    ),
    body: SafeArea(
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 36),
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: MyTextFormField(
                  minLines: 7,
                  labelText: '',
                  hintText: 'Nos conte como podemos te ajudar',
                  controller: controller.message,
                  keyboardType: TextInputType.text,
                  validator: (text) {
                    if (text == null || text.isEmpty) return 'Ops! O campo deve ser preenchido';
                  }
                ),
              ),
              const SizedBox(height: 32),
              PrimaryButton(
                text: 'Enviar',
                textColor: kColorStatusDisabled,
                color: kMaterialColorButtonPrimary,
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    controller.sendFeedback(controller.message.toString());
                    ManagerDialogs.showSuccessFeedbackDialog(
                      context,
                      title: 'MENSAGEM ENVIADA!',
                      message: 'Obrigada por nos dar sua opinião',
                      onPressed: () => Modular.to.pushReplacementNamed('.$kRouteHome')
                    );
                  }
                }
              ),
            ],
          ),
        ),
      ),
    ),
  );
}