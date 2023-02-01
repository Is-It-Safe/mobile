import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/generated/l10n.dart';
import 'package:is_it_safe_app/src/app/modules/configuration/contact/presenter/bloc/contact_bloc.dart';
import 'package:is_it_safe_app/src/components/style/text/text_styles.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_app_bar.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_button.dart';

class ContactPage extends StatefulWidget {
  static const route = '/contact/';

  const ContactPage({
    Key? key,
  }) : super(key: key);

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final formKey = GlobalKey<FormState>();
  final textController = TextEditingController();
  final contactBloc = ContactBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SafeAppBar(
        title: S.current.textContact,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 35),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.25,
              child: Form(
                key: formKey,
                child: TextFormField(
                  controller: textController,
                  textCapitalization: TextCapitalization.sentences,
                  expands: true,
                  maxLines: null,
                  textAlignVertical: TextAlignVertical.top,
                  decoration: InputDecoration(
                    hintText: S.current.textContacHowToHelpYou,
                    hintStyle: TextStyles.label(),
                  ),
                  validator: (value) {
                    if (value?.trim().isEmpty ?? false) {
                      return S.current.textErrorEmptyField;
                    }
                    return null;
                  },
                ),
              ),
            ),
            const SizedBox(height: 40),
            SafeButton(
              title: S.current.textSend,
              onTap: () async {
                if (formKey.currentState?.validate() ?? false) {
                  contactBloc.launchEmail(
                    message: textController.text,
                  );
                  Modular.to.pop();
                }
                return;
              },
            ),
          ],
        ),
      ),
    );
  }
}
