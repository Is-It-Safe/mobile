import 'package:flutter/material.dart';
import 'package:is_it_safe_app/generated/l10n.dart';
import 'package:is_it_safe_app/src/app/modules/configuration/contact/presenter/bloc/contact_bloc.dart';
import 'package:is_it_safe_app/src/components/style/text/text_styles.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_app_bar.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_button.dart';
import 'package:is_it_safe_app/src/core/state/safe_builder.dart';
import 'package:is_it_safe_app/src/core/state/safe_state.dart';

class ContactPage extends StatefulWidget {
  static const route = '/contact/';

  const ContactPage({Key? key}) : super(key: key);

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends SafeState<ContactPage, ContactBloc> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: SafeAppBar(
        title: S.current.textContact,
      ),
      body: SingleChildScrollView(
        child: SafeBuilder<bool>(
          stream: bloc.isMessageSent,
          builder: (isMessageSent) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.25,
                    child: Form(
                      key: _formKey,
                      child: TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: bloc.messageController,
                        textCapitalization: TextCapitalization.sentences,
                        expands: true,
                        maxLines: null,
                        textAlignVertical: TextAlignVertical.top,
                        decoration: InputDecoration(
                          hintText: S.current.textContacHowToHelpYou,
                          hintStyle: TextStyles.label(),
                        ),
                        validator: (value) => bloc.validateText(value),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  SafeButton(
                    title: S.current.textSend,
                    state: ButtonState.rest,
                    onTap: () async {
                      if (_formKey.currentState?.validate() ?? false) {
                        FocusManager.instance.primaryFocus?.unfocus();
                        bloc.launchEmail(message: bloc.messageController.text);
                      }
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
