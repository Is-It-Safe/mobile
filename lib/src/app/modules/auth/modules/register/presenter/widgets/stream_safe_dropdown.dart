import 'package:flutter/material.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_dropdown.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_text_form_field.dart';
import 'package:is_it_safe_app/src/core/state/safe_builder.dart';
import 'package:is_it_safe_app/src/core/state/safe_stream.dart';

class StreamSafeDropdown<T> extends StatefulWidget {
  final SafeStream<List<T>> items;
  final SafeStream<bool> isDropdownExpanded;
  final String title;
  final TextEditingController textController;
  const StreamSafeDropdown({
    Key? key,
    required this.items,
    required this.textController,
    required this.isDropdownExpanded,
    required this.title,
  }) : super(key: key);

  @override
  State<StreamSafeDropdown<T>> createState() => _StreamSafeDropdownState<T>();
}

class _StreamSafeDropdownState<T> extends State<StreamSafeDropdown<T>> {
  @override
  Widget build(BuildContext context) {
    return SafeBuilder2<List<T>, bool>(
      stream1: widget.items,
      stream2: widget.isDropdownExpanded,
      onLoading: () => const SafeTextFormField(
        dropdownType: DropdownType.loading,
      ),
      onError: (_) => const SafeTextFormField(
        dropdownType: DropdownType.error,
      ),
      builder: (items, isDropdownExpanded) {
        if (items.isNotEmpty) {
          return SafeDropDown(
            title: widget.title,
            controller: widget.textController,
            values: items,
            isExapanded: isDropdownExpanded,
          );
        }
        return const SafeTextFormField(
          dropdownType: DropdownType.loading,
        );
      },
    );
  }
}
