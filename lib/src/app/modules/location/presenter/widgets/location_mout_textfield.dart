import 'package:flutter/material.dart';
import 'package:is_it_safe_app/generated/l10n.dart';
import 'package:is_it_safe_app/src/app/modules/location/presenter/bloc/save_location_bloc.dart';
import 'package:is_it_safe_app/src/components/style/text/text_styles.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_text_form_field.dart';
import 'package:is_it_safe_app/src/core/enum/location_type_enum.dart';
import 'package:is_it_safe_app/src/app/modules/location/domain/usecases/save_location_use_case.dart';
import 'package:is_it_safe_app/src/core/state/safe_builder.dart';

class MountTextField extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final SaveLocationBloC controller;
  final SaveLocationUseCase? locationUseCase;

  const MountTextField({
    Key? key,
    required this.formKey,
    required this.controller,
    this.locationUseCase,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double alturaTextFormField = 32;
    const double alturaTitleText = 12;
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            S.current.textAddLocationNameTextFieldTitle,
            style: TextStyles.subtitle1(),
          ),
          const SizedBox(height: alturaTitleText),
          SafeTextFormField(
            controller: controller.locationNameController,
            labelText: S.current.textAddLocationExample,
            textInputAction: TextInputAction.next,
            textCapitalization: TextCapitalization.words,
            validator: (value) => controller.validateTextField(value),
            onChanged: (value) =>
                controller.locationNameController.text = value,
          ),
          const SizedBox(height: alturaTextFormField),
          Text(
            S.current.textAddLocationCepFieldTitle,
            style: TextStyles.subtitle1(),
          ),
          const SizedBox(height: alturaTitleText),
          SafeTextFormField(
            controller: controller.locationCepController,
            labelText: S.current.textAddLocationCepExample,
            keyboardType: TextInputType.number,
            maxLength: 8,
            textInputAction: TextInputAction.next,
            validator: (value) => controller.validateTextField(value),
            onChanged: (value) => controller.locationCepController.text = value,
          ),
          const SizedBox(height: alturaTextFormField),
          Text(
            S.current.textAddLocationAddressFieldTitle,
            style: TextStyles.subtitle1(),
          ),
          const SizedBox(height: alturaTitleText),
          SafeTextFormField(
            controller: controller.locationAddressFieldController,
            labelText: S.current.textAddLocationAddress,
            textInputAction: TextInputAction.next,
            textCapitalization: TextCapitalization.sentences,
            validator: (value) => controller.validateTextField(value),
          ),
          const SizedBox(height: alturaTextFormField),
          Text(
            S.current.textAddTypeLocationFieldTitle,
            style: TextStyles.subtitle1(),
          ),
          const SizedBox(height: alturaTitleText),
          SafeBuilder<LocationTypeEnum>(
            stream: controller.locationType,
            builder: (locationType) {
              return DropdownButtonFormField<String>(
                value: locationType.name,
                items: LocationTypeEnum.values
                    .map((e) => DropdownMenuItem<String>(
                          value: e.name,
                          child: Text(e.name),
                        ))
                    .toList(),
                onChanged: (value) {
                  controller.locationType.data = LocationTypeEnum.values
                      .firstWhere((element) => element.name == value);
                },
              );
            },
          ),
          const SizedBox(height: alturaTextFormField),
        ],
      ),
    );
  }
}
