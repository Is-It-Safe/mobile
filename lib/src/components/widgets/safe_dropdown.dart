import 'package:flutter/material.dart';
import 'package:is_it_safe_app/src/components/style/colors/safe_colors.dart';
import 'package:is_it_safe_app/src/components/style/text/text_styles.dart';

class SafeDropDown extends StatefulWidget {
  final List<dynamic> values;
  TextEditingController controller;
  bool isExapanded;
  String title;

  SafeDropDown({
    Key? key,
    required this.values,
    required this.isExapanded,
    required this.title,
    required this.controller,
  }) : super(key: key);

  @override
  State<SafeDropDown> createState() => _SafeDropDownState();
}

class _SafeDropDownState extends State<SafeDropDown> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: widget.isExapanded
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
            widget.isExapanded = !isExpanded;
          });
        },
        children: [
          ExpansionPanel(
            canTapOnHeader: true,
            isExpanded: widget.isExapanded,
            backgroundColor: SafeColors.generalColors.background,
            headerBuilder: (BuildContext context, bool isExpanded) {
              return ListTile(
                title: Text(
                  widget.title,
                  style: widget.isExapanded
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
                        widget.isExapanded = !widget.isExapanded;
                      });
                      debugPrint("${widget.controller.text} - ${widget.title}");
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
