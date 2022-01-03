import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/app/modules/register_module/register_bloc.dart';
import 'package:is_it_safe_app/core/components/app_bar.dart';
import 'package:is_it_safe_app/core/components/main_button.dart';
import 'package:is_it_safe_app/core/components/main_text_field.dart';
import 'package:is_it_safe_app/core/components/text_button.dart';
import 'package:is_it_safe_app/core/components/theme_switch.dart';
import 'package:is_it_safe_app/core/model/Gender.dart';
import 'package:is_it_safe_app/core/model/SexualOrientation.dart';
import 'package:is_it_safe_app/core/utils/constants/routes.dart';
import 'package:is_it_safe_app/core/utils/helper/helpers.dart';
import 'package:is_it_safe_app/core/utils/helper/manage_dialogs.dart';
import 'package:is_it_safe_app/core/utils/style/colors/dark_theme_colors.dart';
import 'package:is_it_safe_app/core/utils/style/colors/general_colors.dart';
import 'package:is_it_safe_app/core/utils/style/colors/light_theme_colors.dart';
import 'package:is_it_safe_app/generated/l10n.dart';

import 'dart:developer' as dev;

class RegisterProfileWidget extends StatefulWidget {
  const RegisterProfileWidget({Key? key}) : super(key: key);

  @override
  _RegisterProfileWidgetState createState() => _RegisterProfileWidgetState();
}

class _RegisterProfileWidgetState
    extends ModularState<RegisterProfileWidget, RegisterBloc> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  var genderText = 'Gênero';
  var orientationText = 'Orientação Sexual';

  var expandedOrientation = false;
  var expandedGender = false;
  @override
  void initState() {
    super.initState();
    dev.log(Modular.to.path, name: "PATH");
    controller.getGenders();
    controller.getSexualOrientations();
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
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const ThemeSwitch(),

                  ///Choose Avatar
                  StreamBuilder<String>(
                    stream: controller.profileAvatarController.stream,
                    builder: (context, snapshot) {
                      return snapshot.hasData == false
                          ? RegisterAvatarPlaceholder(
                              onTap: () => Modular.to.pushNamed(
                                '.$kRouteRegisterProfilePicture',
                              ),
                            )
                          : RegisterAvatar(
                              path: controller.selectedProfileAvatarPhoto,
                              onTap: () => Modular.to.pushNamed(
                                '.$kRouteRegisterProfilePicture',
                              ),
                            );
                    },
                  ),

                  ///Choose picture text
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Text(
                      S.of(context).textPageTitleProfileRegisterPage,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                  Text(
                      S.of(context).textPageSubtitleProfileRegisterPage,
                      style: Theme.of(context)
                                .textTheme
                                .subtitle2!
                                .copyWith(fontSize: 12),
                    ),

                  ///TextFormField Birthday
                  Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: TextFormField(
                      inputFormatters: [controller.birthdayInputMask],
                      controller: controller.birthdayController,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (!Helpers.validateDate(value)) {
                          return S.of(context).textErrorInvalidDate;
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: S.of(context).textDateOfBirth,
                      ),
                    ),
                  ),

                  //Dropdown Genders
                  Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: StreamBuilder<List<Gender>>(
                      stream: controller.dropGendersController.stream,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: expandedGender ? primaryColor : primaryTextColorLight),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(4.0),
                              ),
                            ),
                            child: ExpansionPanelList(
                              expandedHeaderPadding: const EdgeInsets.all(0),
                              elevation: 0,
                              expansionCallback: (int index, bool isExpanded) {
                                setState(() {
                                  expandedGender = !isExpanded;
                                });
                              },
                              children: [
                                ExpansionPanel(
                                    canTapOnHeader: true,
                                    isExpanded: expandedGender,
                                    headerBuilder: (BuildContext context,
                                        bool isExpanded) {
                                      return ListTile(
                                        title: Text(
                                          genderText,
                                          style: expandedGender ? Theme.of(context)
                                              .textTheme
                                              .subtitle1!
                                              .copyWith(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                              ) : Theme.of(context)
                                              .textTheme
                                              .subtitle1!
                                              ,
                                        ),
                                      );
                                    },
                                    body: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      mainAxisSize: MainAxisSize.min,
                                      children: snapshot.data!.map((gender) {
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 8.0, left: 24.0),
                                          child: InkWell(
                                            onTap: () {
                                              setState(() {
                                                genderText = gender.title;
                                                expandedGender =
                                                    !expandedGender;
                                              });
                                            },
                                            child: Text(
                                              gender.title,
                                              textAlign: TextAlign.start,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle1,
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                    )),
                              ],
                            ),
                          );
                        }
                        //return ManagerDialogs.showLoadingDialog(context)
                        //TODO: Ajustar para loading do ManagerDialogs
                        return Align(
                          alignment: Alignment.center,
                          child: CircularProgressIndicator(
                              backgroundColor: Theme.of(context).primaryColor),
                        );
                      },
                    ),
                  ),
                  
                  ///Dropdown Orientation

                  Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: StreamBuilder<List<SexualOrientation>>(
                      stream: controller.dropOrientationController.stream,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: expandedOrientation ? primaryColor : primaryTextColorLight),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(4.0),
                              ),
                            ),
                            child: ExpansionPanelList(
                              expandedHeaderPadding: const EdgeInsets.all(0),
                              elevation: 0,
                              expansionCallback: (int index, bool isExpanded) {
                                setState(() {
                                  expandedOrientation = !isExpanded;
                                });
                              },
                              children: [
                                ExpansionPanel(
                                    canTapOnHeader: true,
                                    isExpanded: expandedOrientation,
                                    headerBuilder: (BuildContext context,
                                        bool isExpanded) {
                                      return ListTile(
                                        title: Text(
                                          orientationText,
                                          style: expandedOrientation ? Theme.of(context)
                                              .textTheme
                                              .subtitle1!
                                              .copyWith(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                              ) : Theme.of(context)
                                              .textTheme
                                              .subtitle1,
                                        ),
                                      );
                                    },
                                    body: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      mainAxisSize: MainAxisSize.min,
                                      children:
                                          snapshot.data!.map((orientation) {
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 8.0, left: 24.0),
                                          child: InkWell(
                                            onTap: () {
                                              setState(() {
                                                orientationText =
                                                    orientation.title;
                                                expandedOrientation =
                                                    !expandedOrientation;
                                              });
                                            },
                                            child: Text(
                                              orientation.title,
                                              textAlign: TextAlign.start,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle1,
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                    )),
                              ],
                            ),
                          );
                        }
                        //return ManagerDialogs.showLoadingDialog(context)
                        //TODO: Ajustar para loading do ManagerDialogs
                        return Align(
                          alignment: Alignment.center,
                          child: CircularProgressIndicator(
                              backgroundColor: Theme.of(context).primaryColor),
                        );
                      },
                    ),
                  ),

                  ///Text Forget Any
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: RichText(
                        textAlign: TextAlign.start,
                        text: TextSpan(children: [
                          TextSpan(
                            text: S.of(context).textForgetAny,
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2!
                                .copyWith(fontSize: 12),
                          ),
                          TextSpan(
                            text: S.of(context).textLetMeKnow,
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2!
                                .copyWith(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 12),
                          ),
                        ]),
                      ),
                    ),
                  ),

                  /// Register button
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 32.0),
                          child: TextButtonCustom(
                            text: S.of(context).textSkipForNow,
                            onTap: () async {
                              
                            },
                          ),
                        )
                      ),
                      ///Skip Button
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 32.0),
                          child: MainButton(
                            color: Theme.of(context).primaryColor,
                            text: S.of(context).textSignUp,
                            onTap: () async {
                              controller.registerUser(genderId: 1, orientationId: 2);
                            },
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class RegisterAvatar extends StatelessWidget {
  final Function()? onTap;
  final String path;
  const RegisterAvatar({
    Key? key,
    this.onTap,
    required this.path,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 120,
        width: 120,
        decoration: BoxDecoration(
          color: Helpers.getColorFromTheme(
            context: context,
            darkModeColor: avatarBackgroundColorDark,
            lightModeColor: avatarBackgroundColorLight,
          ),
          shape: BoxShape.circle,
          image: DecorationImage(
            fit: BoxFit.cover,
            alignment: Alignment.topCenter,
            image: AssetImage(path),
          ),
        ),
      ),
    );
  }
}

class RegisterAvatarPlaceholder extends StatelessWidget {
  final Function()? onTap;
  const RegisterAvatarPlaceholder({
    Key? key,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              Helpers.getImageFromTheme(
                context: context,
                darkModeImagePath:
                    'images/app/profile_pictures/placeholder/placeholder_avatar_dark.png',
                lightModeImagePath:
                    'images/app/profile_pictures/placeholder/placeholder_avatar_light.png',
              ),
            ),
          ),
        ),
      ),
    );
  }
}
