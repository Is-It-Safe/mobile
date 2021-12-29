import 'package:flutter/material.dart';
import 'package:is_it_safe_app/core/utils/helper/helpers.dart';
import 'package:is_it_safe_app/core/utils/style/colors/dark_theme_colors.dart';
import 'package:is_it_safe_app/core/utils/style/colors/general_colors.dart';
import 'package:is_it_safe_app/core/utils/style/colors/light_theme_colors.dart';

class MainTextField extends StatefulWidget {
  final EdgeInsetsGeometry padding;
  final TextEditingController controller;
  final Function(String) onChanged;
  final Function()? onEditingComplete;
  final String? hintText;
  final FormFieldValidator<String> validator;
  final String? labelText;
  bool changeLabelColor;
  bool? isObscure;
  Widget? suffixIcon;

  MainTextField(
      {Key? key,
      required this.padding,
      required this.controller,
      required this.onChanged,
      this.onEditingComplete,
      this.hintText,
      required this.validator,
      this.labelText,
      required this.changeLabelColor,
      this.isObscure,
      this.suffixIcon})
      : super(key: key);

  @override
  _MainTextFieldState createState() => _MainTextFieldState();
}

class _MainTextFieldState extends State<MainTextField> {
  late FocusNode _myFocusNode;

  @override
  void initState() {
    _myFocusNode = FocusNode();
    _myFocusNode.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _myFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding,
      child: TextFormField(
        focusNode: widget.changeLabelColor ? _myFocusNode : null,
        controller: widget.controller,
        obscureText: widget.isObscure ?? false,
        decoration: InputDecoration(
          hintText: widget.hintText,
          labelText: widget.labelText,
          labelStyle: Theme.of(context).textTheme.subtitle1?.copyWith(
                color: _myFocusNode.hasFocus
                    ? Helpers.getColorFromTheme(
                        context: context,
                        darkModeColor: inputFocusedColor,
                        lightModeColor: inputFocusedColor,
                      )
                    : Helpers.getColorFromTheme(
                        context: context,
                        darkModeColor: primaryTextColorDark,
                        lightModeColor: greyTextColorLight,
                      ),
              ),
          suffixIcon: widget.suffixIcon,
        ),
        onChanged: widget.onChanged,
        validator: widget.validator,
        onEditingComplete: widget.onEditingComplete,
      ),
    );
  }
}
