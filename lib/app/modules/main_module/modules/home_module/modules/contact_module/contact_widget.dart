import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/app/modules/main_module/modules/home_module/modules/contact_module/contact_bloc.dart';

import 'package:is_it_safe_app/core/components/all.dart';
import 'package:is_it_safe_app/core/data/service/config/base_response.dart';
import 'package:is_it_safe_app/core/utils/constants/routes.dart';
import 'package:is_it_safe_app/core/utils/helper/manage_dialogs.dart';
import 'package:is_it_safe_app/core/utils/helper/native_loading.dart';
import 'package:is_it_safe_app/core/utils/style/all.dart';
import 'package:is_it_safe_app/generated/l10n.dart';

class ContactWidget extends StatefulWidget {
  const ContactWidget({Key? key}) : super(key: key);

  @override
  _ContactWidgetState createState() => _ContactWidgetState();
}

class _ContactWidgetState extends ModularState<ContactWidget, ContactBloc> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    sendFeedbackControllerListen();
  }

  sendFeedbackControllerListen() async {
    controller.sendFeedbackController.stream.listen((event) async {
      switch (event.status) {
        case Status.COMPLETED:
          ManagerDialogs.showSuccessFeedbackDialog(
            context,
            title: S.of(context).textMessageSended.toUpperCase(),
            message: S.of(context).textThanksForTheFeedback,
            onPressed: () => Modular.to.pushReplacementNamed('.$kRouteHome'),
          );
          break;
        case Status.LOADING:
          const NativeLoading(animating: true);
          break;
        case Status.ERROR:
          //TODO ADICIONAR UM POP AQUI
          ManagerDialogs.showErrorDialog(context, event.message!);
          break;
        default:
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: appBar(
          context: context,
          title: S.of(context).textAppBarContato,
          hasLeading: true,
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
                        maxLines: 7,
                        labelText: '',
                        hintText: S.of(context).textTellUsHowWeCanHelp,
                        controller: controller.message,
                        keyboardType: TextInputType.text,
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return S.of(context).textErrorEmptyField;
                          }
                          return null;
                        }),
                  ),
                  const SizedBox(height: 32),
                  PrimaryButton(
                      text: S.of(context).textEnviar,
                      textColor: kColorStatusDisabled,
                      color: kMaterialColorButtonPrimary,
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          controller
                              .sendFeedback(controller.message.toString());
                        }
                      }),
                ],
              ),
            ),
          ),
        ),
      );
}
