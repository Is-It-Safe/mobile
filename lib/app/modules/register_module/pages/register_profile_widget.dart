import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/app/modules/register_module/components/my_dropdown.dart';
import 'package:is_it_safe_app/app/modules/register_module/components/register_avatar.dart';
import 'package:is_it_safe_app/app/modules/register_module/components/register_avatar_placeholder.dart';
import 'package:is_it_safe_app/app/modules/register_module/constants/register_constants.dart';
import 'package:is_it_safe_app/app/modules/register_module/register_bloc.dart';
import 'package:is_it_safe_app/core/components/app_bar.dart';
import 'package:is_it_safe_app/core/components/my_text_form_field.dart';
import 'package:is_it_safe_app/core/components/primary_button.dart';
import 'package:is_it_safe_app/core/components/secondary_button.dart';
import 'package:is_it_safe_app/core/data/service/config/base_response.dart';
import 'package:is_it_safe_app/core/model/Gender.dart';
import 'package:is_it_safe_app/core/model/SexualOrientation.dart';
import 'package:is_it_safe_app/core/utils/constants/routes.dart';
import 'package:is_it_safe_app/core/utils/helper/helpers.dart';
import 'package:is_it_safe_app/core/utils/helper/log.dart';
import 'package:is_it_safe_app/core/utils/helper/manage_dialogs.dart';
import 'package:is_it_safe_app/core/utils/helper/native_loading.dart';
import 'package:is_it_safe_app/core/utils/style/colors/general_colors.dart';
import 'package:is_it_safe_app/core/utils/style/themes/text_styles.dart';
import 'package:is_it_safe_app/generated/l10n.dart';

class RegisterProfileWidget extends StatefulWidget {
  const RegisterProfileWidget({Key? key}) : super(key: key);

  @override
  _RegisterProfileWidgetState createState() => _RegisterProfileWidgetState();
}

class _RegisterProfileWidgetState
    extends ModularState<RegisterProfileWidget, RegisterBloc> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  var genderText = RegisterConstants.kGenderText;
  var orientationText = RegisterConstants.kOrientationText;

  var expandedOrientation = false;
  var expandedGender = false;
  @override
  void initState() {
    super.initState();
    Log.route(Modular.to.path);
    registrationListen();
    controller.getGenders();
    controller.getSexualOrientations();
  }

  registrationListen() {
    controller.registrationController.stream.listen((event) async {
      switch (event.status) {
        case Status.COMPLETED:
          Modular.to.pop();
          Modular.to.pushNamedAndRemoveUntil(kRouteLogin, (r) => false);
          break;
        case Status.LOADING:
          const NativeLoading(animating: true);
          break;
        case Status.ERROR:
          Modular.to.pop();
          ManagerDialogs.showErrorDialog(context, event.message!);
          break;
        default:
          break;
      }
    });
  }

  _onError(AsyncSnapshot snapshot) {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      ManagerDialogs.showErrorDialog(
        context,
        snapshot.data.message,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: appBar(
        context: context,
        hasLeading: false,
        title: S.of(context).textAppBarProfileRegisterPage,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: StreamBuilder<BaseResponse>(
                stream: controller.registrationController.stream,
                builder: (context, snapshot) {
                  return Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        StreamBuilder<String>(
                          stream: controller.profileAvatarController.stream,
                          builder: (context, snapshot) {
                            return snapshot.hasData == false
                                ? RegisterAvatarPlaceholder(
                                    onTap: () => Modular.to
                                        .pushNamed(
                                      '.$kRouteRegisterProfilePicture',
                                    )
                                        .then(
                                      (value) {
                                        if (value != null) {
                                          String newValue = value.toString();

                                          controller.setProfileAvatar(
                                            path: newValue,
                                          );
                                        }
                                      },
                                    ),
                                  )
                                : RegisterAvatar(
                                    path: controller.selectedProfileAvatarPhoto,
                                    onTap: () => Modular.to
                                        .pushNamed(
                                      '.$kRouteRegisterProfilePicture',
                                    )
                                        .then(
                                      (value) {
                                        if (value != null) {
                                          String newValue = value.toString();

                                          controller.setProfileAvatar(
                                            path: newValue,
                                          );
                                        }
                                      },
                                    ),
                                  );
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Text(
                            S.of(context).textPageTitleProfileRegisterPage,
                            style: TextStyles.subtitle2(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Text(
                            S.of(context).textYourRepresentationHereInside,
                            style: TextStyles.helper(fontSize: 12),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 30.0),
                          child: MyTextFormField(
                            controller: controller.birthdayController,
                            labelText: S.of(context).textDateOfBirth,
                            inputFormatters: [controller.birthdayInputMask],
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (!Helpers.validateDate(value)) {
                                return S.of(context).textErrorInvalidDate;
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 30.0),
                          child: StreamBuilder<BaseResponse<List<Gender>>>(
                            stream: controller.dropGendersController.stream,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                switch (snapshot.data?.status) {
                                  case Status.LOADING:
                                    return MyTextFormField(
                                      readOnly: true,
                                      labelText: S.of(context).textLoading,
                                    );
                                  case Status.ERROR:
                                    _onError(snapshot);
                                    return MyTextFormField(
                                      readOnly: true,
                                      labelText:
                                          S.of(context).textErrorDropdown,
                                    );
                                  default:
                                    return MyDropDown(
                                      controller: controller.genderController,
                                      values: snapshot.data!.data!,
                                      isExapanded: expandedGender,
                                      title: genderText,
                                    );
                                }
                              }

                              return MyTextFormField(
                                readOnly: true,
                                labelText: S.of(context).textLoading,
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 30.0),
                          child: StreamBuilder<
                              BaseResponse<List<SexualOrientation>>>(
                            stream: controller.dropOrientationController.stream,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                switch (snapshot.data?.status) {
                                  case Status.LOADING:
                                    return MyTextFormField(
                                      readOnly: true,
                                      labelText: S.of(context).textLoading,
                                    );
                                  case Status.ERROR:
                                    _onError(snapshot);
                                    return MyTextFormField(
                                      readOnly: true,
                                      labelText:
                                          S.of(context).textErrorDropdown,
                                    );
                                  default:
                                    return MyDropDown(
                                      controller: controller
                                          .sexualOrientationController,
                                      values: snapshot.data!.data!,
                                      isExapanded: expandedOrientation,
                                      title: orientationText,
                                    );
                                }
                              }

                              return MyTextFormField(
                                readOnly: true,
                                labelText: S.of(context).textLoading,
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 32),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SecondaryButton(
                                text: S.of(context).textAdvance,
                                borderColor: Colors.transparent,
                                onTap: () async {
                                  controller.registerUser();
                                },
                              ),
                              Expanded(
                                child: PrimaryButton(
                                  color: kColorStatusActive,
                                  text: S.of(context).textFinish,
                                  textColor: kColorBackgroundLight,
                                  onTap: () async {
                                    controller.registerUser();
                                  },
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                }),
          ),
        ),
      ),
    );
  }
}
