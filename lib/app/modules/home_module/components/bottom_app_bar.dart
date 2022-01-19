import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:is_it_safe_app/core/utils/style/colors/light_theme_colors.dart';
import 'package:is_it_safe_app/generated/l10n.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: whiteBackgroundColor,
      child: SizedBox(
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            InkWell(
              onTap: () {
                //TODO: implementar rota
              },
              child: SizedBox(
                height: 75,
                width: 75,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 28,
                      child: SvgPicture.asset(
                        "images/app/home/icons_bottombar/picked_home.svg",
                        height: 24,
                        width: 25.27,
                      ),
                    ),
                    Text(
                      S.of(context).textBottomBar1,
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1!
                          .copyWith(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                //TODO: implementar rota
              },
              child: SizedBox(
                height: 75,
                width: 75,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 28,
                      child: SvgPicture.asset(
                        "images/app/home/icons_bottombar/standard_search.svg",
                        height: 24,
                        width: 25.27,
                      ),
                    ),
                    Text("data")
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                //TODO: implementar rota
              },
              child: SizedBox(
                height: 75,
                width: 75,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 28,
                      child: SvgPicture.asset(
                        "images/app/home/icons_bottombar/standard_reviews.svg",
                        height: 24,
                        width: 25.27,
                      ),
                    ),
                    Text("data")
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
