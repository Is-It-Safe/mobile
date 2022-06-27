import 'package:flutter/material.dart';
import 'package:is_it_safe_app/app/modules/my_account_module/components/action_text_component.dart';
import 'package:is_it_safe_app/app/modules/my_account_module/components/info_text_component.dart';
import 'package:is_it_safe_app/generated/l10n.dart';
import 'package:is_it_safe_app/src/components/style/text/text_styles.dart';
import 'package:is_it_safe_app/src/core/util/log_util.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'my_account_bloc.dart';

class MyAccountPage extends StatefulWidget {
  const MyAccountPage({
    Key? key,
  });

  @override
  State<MyAccountPage> createState() => _MyAccountPageState();
}

class _MyAccountPageState extends ModularState<MyAccountPage, MyAccountBloc> {
  @override
  void initState() {
    super.initState();
    LogUtil().route(Modular.to.path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: appBar(
      //     context: context,
      //     title: '', //S.of(context).textMyAccount,
      //     hasLeading: true),
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
                    const CircleAvatar(
                      foregroundColor: Colors.red,
                      radius: 50,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      controller.sexualOrientation ?? "",
                      style: TextStyles.bodyText1(),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      controller.gender ?? "",
                      style: TextStyles.bodyText1(),
                    ),
                    const SizedBox(
                      height: 52,
                    ),
                    // BannerText(
                    //   title: S.of(context).textPersonalInformation,
                    // ),
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
                              value: controller.name ?? "",
                            ),
                            // InfoTextComponent(
                            //   title: S.of(context).textNickname,
                            //   value: controller.nickname ?? "",
                            // ),
                            // InfoTextComponent(
                            //   title: S.of(context).textPronoun,
                            //   value: controller.pronoun ?? "",
                            // ),
                            InfoTextComponent(
                              title: S.of(context).textDateOfBirth,
                              value: controller.dateOfBirth ?? "",
                            ),
                            InfoTextComponent(
                              title: S.of(context).textSexualOrientation,
                              value: controller.sexualOrientation ?? "",
                            ),
                            InfoTextComponent(
                              title: S.of(context).textGender,
                              value: controller.gender ?? "",
                            ),
                            // ActionTextComponent(
                            //   title: S.of(context).textEditProfile,
                            //   onPressed: () {},
                            //   isLastItem: true,
                            // ),
                          ],
                        ),
                      ),
                    ),
                    // BannerText(
                    //   title: S.of(context).textPersonalInformation,
                    // ),
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
                          // ActionTextComponent(
                          //   title: S.of(context).textDisableMyAccount,
                          //   onPressed: () {},
                          // ),
                          // ActionTextComponent(
                          //   title: S.of(context).textExit,
                          //   onPressed: () {},
                          // ),
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
