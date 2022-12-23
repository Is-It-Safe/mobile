import 'package:flutter/material.dart';

import '../../../../../../components/config/safe_event.dart';
import '../../../../../../components/widgets/safe_dropdown.dart';
import '../../../../../../components/widgets/safe_text_form_field.dart';

class StreamSafeDropdown<T> extends StatelessWidget {
  final Stream<SafeEvent<List<T>>> stream;
  final TextEditingController textController;
  final bool isDropdownExpanded;
  final String title;
  const StreamSafeDropdown({
    Key? key,
    required this.stream,
    required this.textController,
    required this.isDropdownExpanded,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SafeEvent<List<T>>>(
      stream: stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          switch (snapshot.data!.status ?? Status.loading) {
            case Status.done:
              return SafeDropDown(
                title: title,
                controller: textController,
                values: snapshot.data!.data ?? [],
                isExapanded: isDropdownExpanded,
              );

            case Status.loading:
              return const SafeTextFormField(
                dropdownType: DropdownType.loading,
              );
            case Status.error:
              return const SafeTextFormField(
                dropdownType: DropdownType.error,
              );
          }
        }
        return const SafeTextFormField(
          dropdownType: DropdownType.loading,
        );
      },
    );
  }
}
