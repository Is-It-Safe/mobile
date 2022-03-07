import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:is_it_safe_app/core/model/location/location_info.dart';
import 'package:is_it_safe_app/core/utils/style/colors/general_colors.dart';

import '../../../../../../../core/utils/style/themes/text_styles.dart';

class LocalCard extends StatelessWidget {
  const LocalCard({Key? key, required this.locationInfo}) : super(key: key);
  final LocationInfo locationInfo;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: kColorPrimaryLight,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            locationInfo.imgUrl!.isNotEmpty
                ? Container(
                    margin: const EdgeInsets.all(16.0),
                    width: MediaQuery.of(context).size.width,
                    height: 140,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(8.0)),
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
                  )
                : const SizedBox.shrink(),
            Padding(
              padding: EdgeInsets.only(
                  left: 16.0,
                  top: locationInfo.imgUrl!.isNotEmpty ? 0.0 : 16.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        "images/app/home/Star.svg",
                        height: 35,
                        width: 35,
                      ),
                      Text(
                        locationInfo.averageGrade.toString(),
                        style: TextStyles.headline3(),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.60,
                        child: Text(
                          locationInfo.name,
                          textAlign: TextAlign.start,
                          style: TextStyles.subtitle1(
                            color: kColorTextLabel,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.60,
                        child: Text(
                          locationInfo.endereco,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyles.custom(
                            fontSize: 12,
                            color: kColorTextLabel,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          SvgPicture.asset("images/app/home/comment_tile.svg"),
                          const SizedBox(
                            width: 9,
                          ),
                          Text(
                            locationInfo.reviewsQnt.toString() + '  reviews',
                            style: TextStyles.helper(
                              color: kColorTextLight,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
