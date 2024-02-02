import 'package:flutter/material.dart';
import 'package:is_it_safe_app/src/components/style/colors/safe_colors.dart';
import 'package:is_it_safe_app/src/components/style/text/text_styles.dart';

// ignore: must_be_immutable
class SafeDropDown extends StatefulWidget {
  final List<dynamic> values;
  TextEditingController controller;
  bool isExpanded;
  String title;

  SafeDropDown({
    Key? key,
    required this.values,
    required this.isExpanded,
    required this.title,
    required this.controller,
  }) : super(key: key);

  @override
  State<SafeDropDown> createState() => _SafeDropDownState();
}

class _SafeDropDownState extends State<SafeDropDown> {
  @override
  void initState() {
    if (int.tryParse(widget.controller.text) != null) {
      dynamic foundValue = widget.values.firstWhere(
        (element) => element.id == int.parse(widget.controller.text),
      );
      widget.title = foundValue.title;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: widget.isExpanded
              ? SafeColors.statusColors.active
              : SafeColors.textColors.dark,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(4.0)),
      ),
      child: ExpansionPanelList(
        expandedHeaderPadding: const EdgeInsets.all(0),
        elevation: 0,
        expansionCallback: (int index, bool isExpanded) {
          setState(() {
            widget.isExpanded = isExpanded;
          });
        },
        children: [
          ExpansionPanel(
            canTapOnHeader: true,
            isExpanded: widget.isExpanded,
            backgroundColor: SafeColors.generalColors.background,
            headerBuilder: (BuildContext context, bool isExpanded) {
              return ListTile(
                title: Text(
                  widget.title,
                  style: widget.isExpanded
                      ? TextStyles.label(
                          color: SafeColors.statusColors.active,
                        )
                      : TextStyles.label(),
                ),
              );
            },
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: widget.values.map((object) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10.0, left: 24.0),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        widget.title = object.title;
                        widget.controller.text = object.id.toString();
                        widget.isExpanded = !widget.isExpanded;
                      });
                    },
                    child: Text(
                      object.title,
                      textAlign: TextAlign.start,
                      style: TextStyles.label(),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
