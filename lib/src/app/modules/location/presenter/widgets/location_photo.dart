import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:is_it_safe_app/src/components/style/colors/safe_colors.dart';
import 'package:is_it_safe_app/generated/l10n.dart';
import 'package:is_it_safe_app/src/components/style/text/text_styles.dart';

class LocalePhotoComponent extends StatefulWidget {
  final Function onTap;
  final String? path;

  const LocalePhotoComponent({Key? key, required this.onTap, this.path})
      : super(key: key);

  @override
  State<LocalePhotoComponent> createState() => _LocalePhotoComponentState();
}

class _LocalePhotoComponentState extends State<LocalePhotoComponent> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: Text(
            S.current.textAddLocationPhotoFieldTitle,
            style: TextStyles.subtitle1(),
          ),
        ),
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: widget.path == null ? 85 : 300,
          child: DottedBorder(
            color: SafeColors.textColors.dark,
            borderType: BorderType.RRect,
            radius: const Radius.circular(6.0),
            dashPattern: const [
              3,
              3,
            ],
            child: Center(
              child: GestureDetector(
                onTap: () => widget.onTap(),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child: widget.path == null
                      ? const Icon(
                          Icons.add_photo_alternate,
                          color: Colors.grey,
                          size: 40,
                        )
                      : Image.file(
                          File(
                            widget.path!,
                          ),
                          fit: BoxFit.contain,
                        ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
