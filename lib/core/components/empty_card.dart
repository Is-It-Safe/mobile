import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:is_it_safe_app/core/utils/style/colors/general_colors.dart';

class EmptyCard extends StatelessWidget {
  const EmptyCard({Key? key, required this.imagePath, required this.text})
      : super(key: key);
  final String imagePath;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Column(
          //mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(imagePath),
            const SizedBox(
              height: 24,
            ),
            Text(
              text,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    color: kColorTextLabel,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
