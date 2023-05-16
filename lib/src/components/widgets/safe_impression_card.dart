import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:is_it_safe_app/src/components/style/colors/safe_colors.dart';
import 'package:is_it_safe_app/src/components/style/text/text_styles.dart';
import 'package:is_it_safe_app/src/core/enum/impression_status_enum.dart';

class SafeImpressionCard extends StatelessWidget {
  const SafeImpressionCard({Key? key, required this.type}) : super(key: key);
  final ImpressionStatusEnum type;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .16,
      width: MediaQuery.of(context).size.width * .9,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            SafeColors.materialcardColors.secondary,
            SafeColors.materialcardColors.primary,
          ],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            left: 250,
            top: 30,
            child: SvgPicture.asset(type.image),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 33, bottom: 32),
            child: Text(
              type.message,
              style: TextStyles.bodyText2(
                color: SafeColors.materialcardColors.text,
              ),
              overflow: TextOverflow.visible,
            ),
          ),
        ],
      ),
    );
  }
}
