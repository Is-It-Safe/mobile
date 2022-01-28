import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:is_it_safe_app/core/utils/style/colors/general_colors.dart';

class LocalCardImage extends StatelessWidget {
  const LocalCardImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 270,
            decoration: BoxDecoration(
                color: kColorPrimaryLight,
                borderRadius: BorderRadius.circular(8.0)),
          ),
          Container(
            margin: const EdgeInsets.all(16.0),
            width: MediaQuery.of(context).size.width,
            height: 140,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0)),
            child: Image.asset(
              "images/app/home/demo_local.png",
              fit: BoxFit.fill,
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
                  '4.7',
                  style: Theme.of(context).textTheme.headline3!.copyWith(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      ),
                  //textAlign: TextAlign.center,
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
                  'Restaurante do Guga',
                  style: Theme.of(context).textTheme.subtitle1!.copyWith(
                        fontWeight: FontWeight.w400,
                        fontSize: 18,
                      ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  'Rua Martelo de Ouro, 1235, Pituba,\nSalvador, Bahia, Brazil',
                  maxLines: 2,
                ),
                const SizedBox(
                  height: 4,
                ),
                Row(
                  children: [
                    SvgPicture.asset("images/app/home/comment_tile.svg"),
                    const SizedBox(
                      width: 9,
                    ),
                    Text('36 reviews')
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
