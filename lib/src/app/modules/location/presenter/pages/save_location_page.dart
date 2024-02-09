import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/generated/l10n.dart';
import 'package:is_it_safe_app/src/app/modules/location/presenter/bloc/save_location_bloc.dart';
import 'package:is_it_safe_app/src/components/style/text/text_styles.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_app_bar.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_button.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_text_form_field.dart';
import 'package:is_it_safe_app/src/core/enum/location_type_enum.dart';
import 'package:is_it_safe_app/src/core/state/safe_builder.dart';
import 'package:is_it_safe_app/src/core/state/safe_state.dart';
import 'package:is_it_safe_app/src/app/modules/location/domain/entities/location_entity.dart';

import '../../../../../core/state/safe_stream.dart';
import '../widgets/success_snack_bar.dart';

class SaveLocationPage extends StatefulWidget {
  static const route = '/save_location';

  final LocationEntity? location;

  const SaveLocationPage({Key? key, this.location}) : super(key: key);

  @override
  State<SaveLocationPage> createState() => _SaveLocationPageState();
}

class _SaveLocationPageState
    extends SafeState<SaveLocationPage, SaveLocationBloC> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  static const double alturaTextFormField = 32;
  static const double alturaTitleText = 12;
  String? errorMessage;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: SafeAppBar(
        title: S.current.textAddLocationSubTitle,
      ),
      body: SafeBuilder(
        stream: bloc.location,
        builder: (saveLocation) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 8.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          S.current.textAddLocationNameTextFieldTitle,
                          style: TextStyles.subtitle1(),
                        ),
                        const SizedBox(height: alturaTitleText),
                        SafeTextFormField(
                          controller: bloc.locationNameController,
                          labelText: S.current.textAddLocationExample,
                          textInputAction: TextInputAction.next,
                          validator: (value) => bloc.validateTextField(value),
                        ),
                        const SizedBox(height: alturaTextFormField),
                        Text(
                          S.current.textAddLocationCepFieldTitle,
                          style: TextStyles.subtitle1(),
                        ),
                        const SizedBox(height: alturaTitleText),
                        ValueListenableBuilder<String?>(
                            valueListenable: bloc.errorMessageNotifier,
                            builder: (context, errorMessage, _) {
                              return SafeTextFormField(
                                controller: bloc.locationCepController,
                                labelText: S.current.textAddLocationCepExample,
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.next,
                                onChanged: (value) async {
                                  if (value.length == 10) {
                                    final result =
                                        await bloc.getLocationByCep(value);
                                    bloc.errorMessageNotifier.value = result;
                                  } else {
                                    bloc.errorMessageNotifier.value = null;
                                  }
                                },
                                validator: (value) =>
                                    bloc.validateZipcode(value),
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  CepInputFormatter(),
                                ],
                              );
                            }),
                        const SizedBox(height: alturaTextFormField),
                        Text(
                          S.current.textAddLocationAddressFieldTitle,
                          style: TextStyles.subtitle1(),
                        ),
                        const SizedBox(height: alturaTitleText),
                        SafeTextFormField(
                          controller: bloc.locationAddressFieldController,
                          labelText: S.current.textAddLocationAddress,
                          textInputAction: TextInputAction.next,
                          validator: (value) => bloc.validateTextField(value),
                        ),
                        const SizedBox(height: alturaTextFormField),
                        Text(
                          S.current.textAddTypeLocationFieldTitle,
                          style: TextStyles.subtitle1(),
                        ),
                        const SizedBox(height: alturaTitleText),
                        SafeBuilder<LocationTypeEnum>(
                          stream: bloc.locationType,
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
                                bloc.locationType.data = LocationTypeEnum.values
                                    .firstWhere(
                                        (element) => element.name == value);
                              },
                            );
                          },
                        ),
                        const SizedBox(height: alturaTextFormField),
                      ],
                    ),
                  ),
                  //TODO app crasha quando abre o image picker
                  // ValueListenableBuilder<String?>(
                  //   valueListenable: bloc.imageNotifier,
                  //   builder: (context, value, _) {
                  //     return Padding(
                  //       padding: const EdgeInsets.only(bottom: 48.0),
                  //       child: LocationPhotoComponent(
                  //         path: value,
                  //         onTap: () async {
                  //           bloc.imageNotifier.value =
                  //               await bloc.handleCameraTap();
                  //         },
                  //       ),
                  //     );
                  //   },
                  // ),
                  const SizedBox(height: 48),
                  Center(
                    child: SafeButton(
                      title: S.current.textAddLocationConfirm,
                      hasBackground: true,
                      size: ButtonSize.large,
                      onTap: () async {
                        if (_formKey.currentState?.validate() ?? false) {
                          await bloc.sendNewLocation().whenComplete(() {
                            if (bloc.location.data != null) {
                              showDialog<void>(
                                context: context,

                                barrierDismissible: false,

                                builder: (BuildContext context) {
                                  return SuccessSnackBar(
                                    message: S.current.textSuccessSaveLocation,
                                  );
                                },
                              );
                            }
                          });
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 26),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
