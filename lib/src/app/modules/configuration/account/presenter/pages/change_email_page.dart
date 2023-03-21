import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/generated/l10n.dart';
import 'package:is_it_safe_app/src/app/modules/configuration/account/presenter/bloc/account_bloc.dart';
import 'package:is_it_safe_app/src/app/modules/configuration/account/presenter/bloc/change_email_bloc.dart';
import 'package:is_it_safe_app/src/components/config/safe_event.dart';
import 'package:is_it_safe_app/src/components/style/text/text_styles.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_app_bar.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_button.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_dialogs.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_loading.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_text_form_field.dart';
import 'package:is_it_safe_app/src/domain/entity/user_entity.dart';

class ChangeEmailPage extends StatefulWidget {
  final AccountBloc accountBloc;
  static String route = "/changeEmail";
  const ChangeEmailPage({
    Key? key,
    required this.accountBloc,
  }) : super(key: key);

  @override
  State<ChangeEmailPage> createState() => _ChangeEmailPageState();
}

class _ChangeEmailPageState extends State<ChangeEmailPage> {
  final controller = Modular.get<ChangeEmailBloc>();

  @override
  void initState() {
    widget.accountBloc.getUser();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SafeAppBar(
        title: S.current.textConfiguration,
      ),
      body: StreamBuilder<SafeEvent<UserEntity?>>(
          stream: widget.accountBloc.userController.stream,
          builder: (context, snapshot) {
            final user = snapshot.data?.data;

            switch (snapshot.data?.status) {
              case Status.loading:
                return const SafeLoading();
              case Status.initial:
                return const SafeLoading();
              case Status.error:
                showDialog(
                  context: context,
                  builder: (context) => SafeDialog(
                    message:
                        snapshot.data?.message ?? S.current.textErrorDropdown,
                    primaryBtn: SafeButton(
                      title: S.current.textOk,
                    ),
                    type: SafeDialogType.error,
                  ),
                );
                break;
              case Status.done:
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 85),
                      Text(
                        S.current.textChangeEmail,
                        style: TextStyles.headline2(),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text.rich(
                          TextSpan(
                            text:
                                "${S.current.textYourCurrentEmailIs} ${user?.email}\n",
                            style: TextStyles.subtitle1(), // default text style
                            children: <TextSpan>[
                              TextSpan(
                                text: S.current.textWhatWillBeYourEmailAddress,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 69),
                      SafeTextFormField(
                        controller: controller.emailAddressText,
                        labelText: S.current.textEmailAddress,
                      ),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            child: SafeButton(
                              size: ButtonSize.small,
                              title: S.current.textCancel,
                              hasBackground: false,
                              onTap: () => Modular.to.pop(),
                            ),
                          ),
                          SizedBox(
                            child: SafeButton(
                              title: S.current
                                  .textAdvance, // TODO: Criar String internacionalizada para 'Alterar' ao invés de usar 'Avançar' neste botão
                              state: !controller.emailValidated
                                  ? ButtonState.disabled
                                  : null,
                              onTap: () async {},
                              hasBorder: true,
                              hasBackground: false,
                              size: ButtonSize.small,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                );
              default:
                return const SafeLoading();
            }
            return const SizedBox.shrink();
          }),
    );
  }
}
