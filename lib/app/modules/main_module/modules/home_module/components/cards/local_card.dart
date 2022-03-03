import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:is_it_safe_app/core/model/location/location_info.dart';
import 'package:is_it_safe_app/core/utils/style/colors/general_colors.dart';

class LocalCard extends StatelessWidget {
  const LocalCard({Key? key, required this.locationInfo}) : super(key: key);

  final LocationInfo locationInfo;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Stack(
        overflow: Overflow.visible,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 130,
            decoration: BoxDecoration(
                color: kColorPrimaryLight,
                borderRadius: BorderRadius.circular(8.0)),
          ),
          Positioned(
            top: -15,
            left: 20,
            child: SvgPicture.asset(
              "images/app/home/Star.svg",
              height: 35,
              width: 35,
            ),
          ),
          Positioned(
            top: 25,
            left: 20,
            child: SizedBox(
              height: 35,
              width: 35,
              child: FittedBox(
                fit: BoxFit.contain,
                child: Text(
                  locationInfo.averageGrade.toString(),
                  style: Theme.of(context).textTheme.headline3!.copyWith(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: kColorTextLight,
                      ),
                  //textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          Positioned(
            left: 80,
            top: 20,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  locationInfo.name!,
                  style: Theme.of(context).textTheme.subtitle1!.copyWith(
                        fontWeight: FontWeight.w400,
                        fontSize: 18,
                      ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Container(
                  width: 250,
                  child: Text(
                    locationInfo.endereco!,
                    maxLines: 2,
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
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            color: kColorTextLight,
                          ),
                    ),
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
