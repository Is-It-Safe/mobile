import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:is_it_safe_app/src/components/style/colors/safe_colors.dart';
import 'package:is_it_safe_app/src/components/style/text/text_styles.dart';
import 'package:is_it_safe_app/src/core/constants/assets_constants.dart';

class ImpressionItem {
  final int id;
  final String title;
  final String image;
  final List<String> impressions;

  ImpressionItem({
    required this.title,
    required this.image,
    required this.id,
    required this.impressions,
  });
}

class SafeImpressionCarroussel extends StatelessWidget {
  final PageController pageController;
  final List<ImpressionItem> data;
  final int currentPage;
  final Function(int value) onImpressionChanged;
  static const _kDuration = Duration(milliseconds: 200);
  static const _kCurve = Curves.ease;

  const SafeImpressionCarroussel({
    Key? key,
    required this.onImpressionChanged,
    required this.pageController,
    required this.data,
    this.currentPage = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SizedBox(
      width: size.width,
      height: size.height * 0.38,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Visibility(
            visible: currentPage != 0,
            child: Material(
              child: InkWell(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: SvgPicture.asset((AssetConstants.icons.arrowBack)),
                ),
                onTap: () => pageController.previousPage(
                  duration: _kDuration,
                  curve: _kCurve,
                ),
              ),
            ),
          ),
          Expanded(
            child: PageView.builder(
              itemCount: data.length,
              controller: pageController,
              onPageChanged: (value) => onImpressionChanged(value),
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ImpressionCard(impression: data[index]),
              ),
            ),
          ),
          Visibility(
            visible: currentPage != 2,
            child: Material(
              child: InkWell(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: SvgPicture.asset((AssetConstants.icons.arrowFoward)),
                ),
                onTap: () => pageController.nextPage(
                  duration: _kDuration,
                  curve: _kCurve,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ImpressionCard extends StatelessWidget {
  final ImpressionItem impression;
  const ImpressionCard({
    Key? key,
    required this.impression,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        color: SafeColors.generalColors.secondary,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Container(
            height: size.height * 0.3,
            width: double.infinity,
            margin: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: SafeColors.generalColors.background,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: size.height * 0.13,
                    child: SvgPicture.asset(
                      impression.image,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    impression.title,
                    style: TextStyles.subtitle1(),
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 12,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                impression.impressions.length,
                (index) => Text(
                  impression.impressions[index],
                  style: TextStyles.bodyText2(
                    color: SafeColors.textColors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
