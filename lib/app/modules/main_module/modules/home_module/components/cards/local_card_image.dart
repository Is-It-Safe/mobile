import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:is_it_safe_app/core/model/location/location_info.dart';
import 'package:is_it_safe_app/core/utils/style/colors/general_colors.dart';
import 'package:is_it_safe_app/core/utils/style/themes/text_styles.dart';

class LocalCardImage extends StatelessWidget {
  const LocalCardImage({Key? key, required this.locationInfo})
      : super(key: key);
  final LocationInfo locationInfo;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      //TODO Ajustar componente
      child: Stack(
        children: [
          locationInfo.imgUrl != null
              ? Container(
                  width: MediaQuery.of(context).size.width,
                  height: 270,
                  decoration: BoxDecoration(
                      color: kColorPrimaryLight,
                      borderRadius: BorderRadius.circular(8.0)),
                )
              : const SizedBox.shrink(),
          Container(
            margin: const EdgeInsets.all(16.0),
            width: MediaQuery.of(context).size.width,
            height: 140,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0)),
            child: Image.network(
              locationInfo.imgUrl!,
              fit: BoxFit.fill,
              errorBuilder: (context, o, s) {
                return Image.asset(
                  'images/app/home/demo_local.png',
                  fit: BoxFit.fill,
                );
              },
            ),
          ),
          Positioned(
            top: 135,
            left: 20,
            child: SvgPicture.asset(
              "images/app/home/Star.svg",
              height: 35,
              width: 35,
            ),
          ),
          Positioned(
            top: 175,
            left: 20,
            child: SizedBox(
              height: 35,
              width: 35,
              child: FittedBox(
                fit: BoxFit.contain,
                child: Text(
                  locationInfo.averageGrade.toString(),
                  style: TextStyles.headline3(),
                ),
              ),
            ),
          ),
          Positioned(
            top: 165,
            left: 80,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  locationInfo.name,
                  //TODO Ajustar TextStyle
                  style: Theme.of(context).textTheme.subtitle1!.copyWith(
                        fontWeight: FontWeight.w400,
                        fontSize: 18,
                      ),
                ),
                const SizedBox(
                  height: 4,
                ),
                SizedBox(
                  width: 250,
                  child: Text(
                    locationInfo.endereco,
                    maxLines: 2,
                    //TODO Ajustar TextStyle
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          color: kColorTextLabel,
                        ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    SvgPicture.asset("images/app/home/comment_tile.svg"),
                    const SizedBox(
                      width: 9,
                    ),
                    Text(
                      locationInfo.reviewsQnt.toString() + ' reviews',
                      //TODO Ajustar TextStyle
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            color: kColorTextLight,
                          ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
