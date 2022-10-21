import 'package:flutter/material.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_snack_bar.dart';

import '../../../generated/l10n.dart';

class SafePlaceButton extends StatefulWidget {
  final Function()? buttonPlace;
  const SafePlaceButton({Key? key, this.buttonPlace}) : super(key: key);

  @override
  State<SafePlaceButton> createState() => _SafePlaceButtonState();
}

class _SafePlaceButtonState extends State<SafePlaceButton> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: widget.buttonPlace ??
          () {
            Navigator.pop(context);
            return SafeSnackBar(
              message: S.current.textFeatureAvailableSoon,
              icon: const Icon(Icons.info),
              type: SnackBarType.info,
            ).show(context);
          },
      icon: const Icon(Icons.info),
    );
  }
}
