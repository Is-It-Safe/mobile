import 'dart:async';

import 'package:flutter/material.dart';
import 'package:is_it_safe_app/generated/l10n.dart';
import 'package:is_it_safe_app/src/components/config/safe_event.dart';
import 'package:is_it_safe_app/src/components/style/text/text_styles.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_dropdown.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_loading.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_text_form_field.dart';
import 'package:is_it_safe_app/src/domain/entity/gender_entity.dart';

class GenderEditAcount extends StatelessWidget {
  final StreamController<SafeEvent<List<GenderEntity>>> controller;
  final TextEditingController genderController;
  final bool isGenderDropdownExpanded;
  const GenderEditAcount(
      {Key? key,
      required this.controller,
      required this.genderController,
      required this.isGenderDropdownExpanded})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SafeEvent<List<GenderEntity>>>(
        stream: controller.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            switch (snapshot.data?.status ?? Status.loading) {
              case Status.done:
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        S.current.textGender,
                        style: TextStyles.subtitle1(),
                      ),
                    ),
                    const SizedBox(height: 8),
                    SafeDropDown(
                      title: S.current.textGender,
                      controller: genderController,
                      values: snapshot.data?.data ?? [],
                      isExapanded: isGenderDropdownExpanded,
                    )
                  ],
                );

              case Status.loading:
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        S.current.textGender,
                        style: TextStyles.subtitle1(),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const SafeTextFormField(
                      dropdownType: DropdownType.loading,
                    )
                  ],
                );

              case Status.error:
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        S.current.textGender,
                        style: TextStyles.subtitle1(),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const SafeTextFormField(
                      dropdownType: DropdownType.error,
                    )
                  ],
                );
            }
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  S.current.textGender,
                  style: TextStyles.subtitle1(),
                ),
              ),
              const SizedBox(height: 8),
              const SafeLoading(),
            ],
          );
        });
  }
}
