import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/generated/l10n.dart';
import 'package:is_it_safe_app/src/app/modules/location/presenter/bloc/location_bloc.dart';
import 'package:is_it_safe_app/src/app/modules/location/presenter/widgets/location_photo.dart';
import 'package:is_it_safe_app/src/components/config/safe_event.dart';
import 'package:is_it_safe_app/src/components/config/safe_layout.dart';
import 'package:is_it_safe_app/src/components/style/text/text_styles.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_app_bar.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_button.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_text_form_field.dart';
import 'package:is_it_safe_app/src/core/enum/location_type_enum.dart';
import 'package:is_it_safe_app/src/core/util/parse_enum.dart';
import 'package:is_it_safe_app/src/domain/entity/location_entity.dart';

class SaveLocationPage extends StatefulWidget {
  static const route = '/save_location/';

  const SaveLocationPage({Key? key}) : super(key: key);

  @override
  State<SaveLocationPage> createState() => _SaveLocationPageState();
}

class _SaveLocationPageState
    extends ModularState<SaveLocationPage, SaveLocationBloc> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SafeAppBar(
        title: S.current.textAddLocationSubTitle,
      ),
      body: StreamBuilder<SafeEvent<LocationEntity>>(
        stream: controller.isSavingLocation.stream,
        initialData: SafeEvent.initial(),
        builder: (context, snapshot) {
          return SafeLayout(
            snapshot: snapshot,
            context: context,
            onCompleted: const SizedBox.shrink(),
            onInitial: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 8.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MountTextField(
                      formKey: _formKey,
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
                        title: S.current.textAddLocationConfirm,
                        hasBackground: true,
                        size: ButtonSize.large,
                        onTap: () async {
                          await controller.sendNewLocation();
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ).build;
        },
      ),
    );
  }
}

class MountTextField extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final SaveLocationBloc controller;

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
              S.current.textAddLocationNameTextFieldTitle,
              style: TextStyles.subtitle1(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 32.0),
            child: SafeTextFormField(
              controller: controller.locationNameController,
              validator: (value) => controller.validateTextField(value),
              labelText: S.current.textAddLocationExample,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: Text(
              S.current.textAddLocationCepFieldTitle,
              style: TextStyles.subtitle1(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 32.0),
            child: SafeTextFormField(
              controller: controller.locationCepController,
              validator: (value) => controller.validateTextField(value),
              labelText: S.current.textAddLocationCepExample,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: Text(
              S.current.textAddLocationAddressFieldTitle,
              style: TextStyles.subtitle1(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 32.0),
            child: SafeTextFormField(
              controller: controller.locationAddressFieldController,
              validator: (value) => controller.validateTextField(value),
              labelText: S.current.textAddLocationAddress,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: Text(
              S.current.textAddTypeLocationFieldTitle,
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
                          value: ParseEnum.parseLocationTypeEnum(e),
                          child: Text(
                            ParseEnum.parseLocationTypeEnum(e),
                          ),
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
