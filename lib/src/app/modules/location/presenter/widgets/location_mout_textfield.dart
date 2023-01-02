import 'package:flutter/material.dart';
import 'package:is_it_safe_app/generated/l10n.dart';
import 'package:is_it_safe_app/src/app/modules/location/presenter/bloc/location_bloc.dart';
import 'package:is_it_safe_app/src/components/style/text/text_styles.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_text_form_field.dart';
import 'package:is_it_safe_app/src/core/enum/location_type_enum.dart';
import 'package:is_it_safe_app/src/core/util/parse_enum.dart';

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
    const double alturaTextForm = 32;
    const double alturaText = 12;
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: alturaText),
            child: Text(
              S.current.textAddLocationNameTextFieldTitle,
              style: TextStyles.subtitle1(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: alturaTextForm),
            child: SafeTextFormField(
              controller: controller.locationNameController,
              labelText: S.current.textAddLocationExample,
              textInputAction: TextInputAction.next,
              validator: (value) => controller.validateTextField(value),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: alturaText),
            child: Text(
              S.current.textAddLocationCepFieldTitle,
              style: TextStyles.subtitle1(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: alturaTextForm),
            child: SafeTextFormField(
              controller: controller.locationCepController,
              labelText: S.current.textAddLocationCepExample,
              keyboardType: TextInputType.number,
              maxLength: 8,
              textInputAction: TextInputAction.next,
              validator: (value) => controller.validateTextField(value),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: alturaText),
            child: Text(
              S.current.textAddLocationAddressFieldTitle,
              style: TextStyles.subtitle1(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: alturaTextForm),
            child: SafeTextFormField(
              controller: controller.locationAddressFieldController,
              labelText: S.current.textAddLocationAddress,
              textInputAction: TextInputAction.next,
              validator: (value) => controller.validateTextField(value),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: alturaText),
            child: Text(
              S.current.textAddTypeLocationFieldTitle,
              style: TextStyles.subtitle1(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: alturaTextForm),
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
