import 'package:flutter/material.dart';

class RegisterWidgetWidget extends StatelessWidget {
  final String title;
  const RegisterWidgetWidget({Key? key, this.title = "RegisterWidgetWidget"}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(child: Text(title));
  }
}