import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/src/app/modules/location/presenter/bloc/location_bloc.dart';
import 'package:is_it_safe_app/src/app/modules/location/presenter/widgets/location_mout_textfield.dart';
import 'package:is_it_safe_app/src/app/modules/location/presenter/widgets/location_photo.dart';
import 'package:is_it_safe_app/src/components/config/safe_event.dart';
import 'package:is_it_safe_app/src/components/config/safe_layout.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_app_bar.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_button.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_loading.dart';
import 'package:is_it_safe_app/src/core/state/safe_builder.dart';
import 'package:is_it_safe_app/src/core/state/safe_state.dart';
import 'package:is_it_safe_app/src/domain/entity/location_entity.dart';

import '../../../../../../generated/l10n.dart';

class SaveLocationPage extends StatefulWidget {
  static const route = '/save_location';

  const SaveLocationPage({Key? key}) : super(key: key);

  @override
  State<SaveLocationPage> createState() => _SaveLocationPageState();
}

class _SaveLocationPageState extends SafeState<SaveLocationPage, LocationBloC> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    bloc.init();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: SafeAppBar(
        title: S.current.textAddLocationSubTitle,
      ),
      body: SafeBuilder<LocationEntity?>(
        stream: bloc.isSavingLocation,
        onLoading: () {
          return const SafeLoading();
        },
        onInitial: () {
          return SingleChildScrollView(
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
                    controller: bloc,
                  ),
                  ValueListenableBuilder<String?>(
                    valueListenable: bloc.imageNotifier,
                    builder: (context, value, _) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 48.0),
                        child: LocationPhotoComponent(
                          path: value,
                          onTap: () async {
                            bloc.imageNotifier.value =
                                await bloc.handleCameraTap();
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
                        if (_formKey.currentState?.validate() ?? false) {
                          await bloc.sendNewLocation();
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
        builder: (_) {
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
