import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/generated/l10n.dart';
import 'package:is_it_safe_app/src/app/modules/location/add_location/presenter/bloc/add_locale_bloc.dart';
import 'package:is_it_safe_app/src/app/modules/location/add_location/presenter/widgets/locale_photo_component.dart';
import 'package:is_it_safe_app/src/components/config/safe_event.dart';
import 'package:is_it_safe_app/src/components/style/text/text_styles.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_app_bar.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_button.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_loading.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_text_form_field.dart';
import 'package:is_it_safe_app/src/core/enum/location_type_enum.dart';
import 'package:is_it_safe_app/src/core/util/parse_enum.dart';
import 'package:is_it_safe_app/src/core/util/validation_util.dart';

class AddLocalePage extends StatefulWidget {
  static String route = '/profile/';
  // static String route = '/add_locale_page/';

  const AddLocalePage({Key? key}) : super(key: key);

  @override
  State<AddLocalePage> createState() => _AddLocalePageState();
}

class _AddLocalePageState extends ModularState<AddLocalePage, AddLocaleBloc> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SafeAppBar(
        title: S.current.textAddLocaleTitle,
      ),
      body: StreamBuilder<SafeEvent<bool>>(
        stream: controller.isSavingLocation?.stream,
        builder: (context, snapshot) {
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: snapshot.connectionState != ConnectionState.waiting
                ? SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24.0,
                        vertical: 8.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 32.0),
                            child: Text(
                              S.current.textAddLocaleSubTitle,
                              style: TextStyles.headline3(),
                            ),
                          ),
                          MountTextField(
                            formKey: formKey,
                            controller: controller,
                          ),
                          ValueListenableBuilder<String?>(
                            valueListenable: controller.imageNotifier,
                            builder: (context, value, _) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 48.0),
                                child: LocalePhotoComponent(
                                  path: value,
                                  onTap: () async {
                                    controller.imageNotifier.value =
                                        await controller.handleCameraTap();
                                  },
                                ),
                              );
                            },
                          ),
                          Center(
                            child: SafeButton(
                              title: S.current.textAddLocaleConfirm,
                              hasBackground: true,
                              size: ButtonSize.large,
                              onTap: () => controller.sendNewLocation(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : const SafeLoading(),
          );
        },
      ),
    );
  }
}

// ignore: must_be_immutable
class MountTextField extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final AddLocaleBloc controller;

  const MountTextField({
    Key? key,
    required this.formKey,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: Text(
              S.current.textAddLocaleNameTextFieldTitle,
              style: TextStyles.subtitle1(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 32.0),
            child: SafeTextFormField(
              controller: controller.localeNameController,
              validator: (value) {
                if (ValidationUtil.name(value ?? '')) {
                  return null;
                }
                return S.current.textErrorEmptyField;
              },
              hintText: S.current.textAddLocaleExample,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: Text(
              S.current.textAddLocaleCepFieldTitle,
              style: TextStyles.subtitle1(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 32.0),
            child: SafeTextFormField(
              controller: controller.localeCepController,
              validator: (value) {
                if (ValidationUtil.name(value ?? '')) {
                  return null;
                }
                return S.current.textErrorEmptyField;
              },
              hintText: S.current.textAddLocaleCepExample,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: Text(
              S.current.textAddLocaleAddressFieldTitle,
              style: TextStyles.subtitle1(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 32.0),
            child: SafeTextFormField(
              controller: controller.localeAddressFieldController,
              validator: (value) {
                if (ValidationUtil.name(value ?? '')) {
                  return null;
                }
                return S.current.textErrorEmptyField;
              },
              hintText: S.current.textAddLocaleAddress,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: Text(
              S.current.textAddTypeLocaleFieldTitle,
              style: TextStyles.subtitle1(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 32.0),
            child: ValueListenableBuilder<String>(
              valueListenable: controller.locationTypeNotifier,
              builder: (context, value, _) {
                return DropdownButtonFormField<String>(
                  value: value,
                  items: LocationTypeEnum.values
                      .map(
                        (e) => DropdownMenuItem<String>(
                          child: Text(
                            ParseEnum.parseLocationTypeEnum(e),
                          ),
                          value: ParseEnum.parseLocationTypeEnum(e),
                        ),
                      )
                      .toList(),
                  onChanged: (value) =>
                      controller.locationTypeNotifier.value = value!,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
