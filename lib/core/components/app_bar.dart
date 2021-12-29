import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/core/utils/style/colors/general_colors.dart';

AppBar appBar({
  required BuildContext context,
  required String title,
  required bool hasLeading,
}) {
  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0.0,
    automaticallyImplyLeading: hasLeading,
    title: Text(
      title,
      style: Theme.of(context)
          .textTheme
          .headline6!
          .copyWith(fontWeight: FontWeight.bold),
    ),
    leading: hasLeading
        ? IconButton(
            onPressed: () => Modular.to.pop(),
            icon: Icon(
              Icons.arrow_back_ios_new,
              size: Theme.of(context).iconTheme.size,
              color: kColorTextLight,
            ),
          )
        : null,
  );
}
