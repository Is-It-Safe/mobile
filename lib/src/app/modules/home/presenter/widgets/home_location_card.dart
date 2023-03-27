import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:is_it_safe_app/generated/l10n.dart';

import 'package:is_it_safe_app/src/components/style/colors/safe_colors.dart';
import 'package:is_it_safe_app/src/components/style/text/text_styles.dart';
import 'package:is_it_safe_app/src/core/constants/assets_constants.dart';
import 'package:is_it_safe_app/src/core/constants/string_constants.dart';
import 'package:is_it_safe_app/src/domain/entity/location_entity.dart';

class HomeLocationCard extends StatelessWidget {
  final LocationEntity location;
  final Function()? onTap;

  const HomeLocationCard({
    Key? key,
    required this.location,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: onTap as void Function(),
      child: Container(
        width: size.width,
        decoration: BoxDecoration(
          color: SafeColors.generalColors.primary,
          borderRadius: BorderRadius.circular(8),
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Column(
              children: [
                _LocationPicture(location: location, size: size),
                SizedBox(
                  height: location.imagePath?.isNotEmpty == true ? 0 : 16,
                ),
                _LocationBody(location: location, size: size),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _LocationPicture extends StatelessWidget {
  final LocationEntity location;
  final Size size;
  const _LocationPicture({Key? key, required this.location, required this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (location.imagePath?.isNotEmpty == true) {
      return Container(
        margin: const EdgeInsets.all(16),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Image.network(
          location.imagePath!,
          height: size.height * .15,
          fit: BoxFit.fitWidth,
          errorBuilder: (context, object, stackTrace) {
            return Image.asset(
              AssetConstants.mock.locationImage,
              fit: BoxFit.fill,
            );
          },
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}

class _LocationBody extends StatelessWidget {
  final LocationEntity location;
  final Size size;
  const _LocationBody({Key? key, required this.location, required this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(width: size.width * .03),
        _LocationGrade(location: location),
        const Spacer(),
        Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _mountName(context),
            const SizedBox(width: 8),
            _moundAddress(context),
            const SizedBox(height: 8),
            _mountReviews(),
            const SizedBox(height: 8),
          ],
        ),
        SizedBox(width: size.width * .08),
      ],
    );
  }

  Widget _mountName(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * .6,
      child: Text(
        location.name,
        textAlign: TextAlign.start,
        overflow: TextOverflow.ellipsis,
        style: TextStyles.subtitle2(
          color: SafeColors.textColors.dark,
        ),
      ),
    );
  }

  Widget _moundAddress(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * .65,
      child: Text(
        location.address,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyles.label(),
      ),
    );
  }

  Widget _mountReviews() {
    return Row(
      children: [
        SvgPicture.asset(AssetConstants.icons.comment),
        const SizedBox(width: 10),
        Text(
          location.reviewsQnt.toString() +
              StringConstants.space +
              S.current.textReviews,
          style: TextStyles.helper(color: SafeColors.textColors.dark),
        ),
      ],
    );
  }
}

class _LocationGrade extends StatelessWidget {
  final LocationEntity location;

  const _LocationGrade({
    Key? key,
    required this.location,
  }) : super(key: key);

  String get grade {
    if (location.averageGrade == null) {
      return StringConstants.empty;
    } else {
      return location.averageGrade!.toStringAsFixed(1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(
          AssetConstants.icons.star,
          height: 35,
          width: 35,
        ),
        Text(
          grade,
          style: TextStyles.headline3(),
        ),
      ],
    );
  }
}
