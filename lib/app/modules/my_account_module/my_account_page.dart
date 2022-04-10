import 'package:flutter/material.dart';
import 'package:is_it_safe_app/app/modules/my_account_module/components/action_text_component.dart';
import 'package:is_it_safe_app/app/modules/my_account_module/components/banner_text_component.dart';
import 'package:is_it_safe_app/app/modules/my_account_module/components/info_text_component.dart';
import 'package:is_it_safe_app/core/components/app_bar.dart';
import 'package:is_it_safe_app/core/utils/style/colors/general_colors.dart';
import 'package:is_it_safe_app/core/utils/style/themes/text_styles.dart';
import '../../../generated/l10n.dart';
import './my_account_controller.dart';
/*
TODO: Transformar em um StatefulWidget
TODO: Não passar o controller por parametro, utilizar o ModularState
TODO: Os textos mockados devem ser alterados por variáveis
*/

class MyAccountPage extends StatelessWidget {
  final MyAccountBloc _controller;

  const MyAccountPage({
    Key? key,
    required MyAccountBloc controller,
  }) : _controller = controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
          context: context,
          title: S.of(context).textMyAccount,
          hasLeading: true),
      body: LayoutBuilder(
        builder: ((context, constraints) {
          return ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight,
              minWidth: constraints.maxWidth,
            ),
            child: IntrinsicHeight(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 35,
                    ),
                    //TODO: Colocar o componente de selecionar o avatar
                    const CircleAvatar(
                      foregroundColor: Colors.red,
                      radius: 50,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    //TODO: Texto mockado
                    Text(
                      "Leonardo Salazar (Ele/Dele)",
                      style: TextStyles.bodyText1(fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    //TODO: Texto mockado
                    Text(
                      "Homem Cis Heterosexual",
                      style: TextStyles.custom(
                        fontWeight: FontWeight.w400,
                        color: kColorSubtext,
                      ),
                    ),
                    const SizedBox(
                      height: 52,
                    ),
                    BannerText(
                      title: S.of(context).textPersonalInformation,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 40),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //TODO: Valores mockados
                            InfoTextComponent(
                              title: S.of(context).textName,
                              value: "Leonardo Salazar",
                            ),
                            InfoTextComponent(
                              title: S.of(context).textNickname,
                              value: "Salazar",
                            ),
                            InfoTextComponent(
                              title: S.of(context).textPronoun,
                              value: "Ele/Dele",
                            ),
                            InfoTextComponent(
                              title: S.of(context).textDateOfBirth,
                              value: "21/07/2000",
                            ),
                            InfoTextComponent(
                              title: S.of(context).textSexualOrientation,
                              value: "Heterosexual",
                            ),
                            InfoTextComponent(
                              title: S.of(context).textGender,
                              value: "Homem Cis",
                            ),
                            ActionTextComponent(
                              title: "Editar Perfil",
                              onPressed: () {},
                              isLastItem: true,
                            ),
                          ],
                        ),
                      ),
                    ),
                    BannerText(
                      title: S.of(context).textPersonalInformation,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 40, horizontal: 32),
                      child: Column(
                        children: [
                          ActionTextComponent(
                            title: S.of(context).textEmailAddress,
                            onPressed: () {},
                          ),
                          ActionTextComponent(
                            title: S.of(context).textPassword,
                            onPressed: () {},
                          ),
                          ActionTextComponent(
                            title: S.of(context).textDisableMyAccount,
                            onPressed: () {},
                          ),
                          ActionTextComponent(
                            title: S.of(context).textExit,
                            onPressed: () {},
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
