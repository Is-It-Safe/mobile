import 'package:flutter/material.dart';
import 'package:is_it_safe_app/generated/l10n.dart';
import 'package:is_it_safe_app/src/components/style/text/text_styles.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_app_bar.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_button.dart';
import 'package:is_it_safe_app/src/core/constants/string_constants.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactPage extends StatelessWidget {
  static const route = '/contact/';

  const ContactPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final textController = TextEditingController();
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
                  expands: true,
                  maxLines: null,
                  textAlignVertical: TextAlignVertical.top,
                  onChanged: (value) {},
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
              onTap: () => launchEmail(
                toEmail: 'devlucasandrade@gmail.com',
                // toEmail: 'contato@isitsafe.com.br',
                subject: '[Feedback-App] - @{nome do usuário}',
                message: textController.text,
              ),
            )
          ],
        ),
      ),
    );
  }

  Future launchEmail({
    required String toEmail,
    required String subject,
    required String message,
  }) async {
    final url = Uri.parse(
      'mailto:$toEmail?subject=$subject&body=$message',
    );
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Não foi possível enviar o e-mail';
    }
  }
}
