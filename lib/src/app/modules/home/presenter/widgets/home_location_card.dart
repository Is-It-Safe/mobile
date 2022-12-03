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
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: SafeColors.generalColors.primary,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          children: [
            _mountLocationPicture(context),
            SizedBox(
              height: location.imagePath?.isNotEmpty == true ? 0.0 : 16.0,
            ),
            _mountBody(context),
            const SizedBox(height: 0),
            _textExpansionTile(context),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  Widget _mountLocationPicture(BuildContext context) {
    if (location.imagePath?.isNotEmpty == true) {
      return Container(
        margin: const EdgeInsets.all(16.0),
        height: 140,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Image.network(
          location.imagePath!,
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

  Widget _mountBody(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _mountGrade(),
        const SizedBox(width: 16),
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
      ],
    );
  }

  Widget _mountGrade() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(
          AssetConstants.icons.star,
          height: 35,
          width: 35,
        ),
        Text(
          location.averageGrade.toString(),
          style: TextStyles.headline3(),
        ),
      ],
    );
  }

  Widget _mountName(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.60,
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
      width: MediaQuery.of(context).size.width * 0.65,
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

  Widget _textExpansionTile(BuildContext context) {
    return ExpansionTile(
      trailing: const Icon(Icons.more_horiz),
      title: Row(
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
      ),
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('ID do Local: ${location.id}'),
        Text(
          'ID da review: ${location.reviewEntity?.id.toString()}',
        ),
        Text(
          'Texto da review: ${location.reviewEntity?.review}',
        ),
      ],
    );
  }
}
