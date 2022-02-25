import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:is_it_safe_app/core/components/all.dart';
import 'package:is_it_safe_app/core/utils/style/all.dart';
import 'package:is_it_safe_app/app/modules/main_module/modules/contact_module/contact_bloc.dart';

class ContactWidget extends StatefulWidget {
  const ContactWidget({ Key? key }) : super(key: key);

  @override
  _ContactWidgetState createState() => _ContactWidgetState();
}

class _ContactWidgetState extends ModularState<ContactWidget, ContactBloc> {
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
              reportTextField,
              const SizedBox(height: 32),
              PrimaryButton(
                text: 'Enviar',
                textColor: kColorStatusDisabled,
                onTap: () => controller.message.text.isNotEmpty ? controller.sendReport() : emptyReport()
              ),
            ],
          ),
        ),
      ),
    ),
  );

  Widget get reportTextField => TextField(
    controller: controller.message,
    autofocus: true,
    keyboardType: TextInputType.text,
    maxLines: null,
    minLines: 8,
    decoration: InputDecoration(
      hintText: 'Nos conte como podemos te ajudar',
      labelStyle: TextStyles.bodyText2(color: kColorTextLabel)
    ),
  );

  emptyReport() => const Dialog();
}