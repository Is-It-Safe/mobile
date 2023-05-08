import 'package:flutter/material.dart';
import 'package:is_it_safe_app/src/components/style/text/text_styles.dart';
import 'package:is_it_safe_app/src/core/constants/assets_constants.dart';
import 'package:is_it_safe_app/src/app/modules/location/domain/entities/location_entity.dart';

class SearchLocationCard extends StatelessWidget {
  final LocationEntity location;
  final Function()? onTap;

  const SearchLocationCard({
    Key? key,
    required this.location,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: onTap as void Function(),
      child: Row(
        children: [
          _mountImage(size),
          _mountLocationDetails(size),
        ],
      ),
    );
  }

  Widget _mountImage(Size size) {
    return Container(
      width: size.width * 0.25,
      height: size.width * 0.22,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Image.network(
          location.imagePath ?? PlaceHolderAssets.searchLocation,
          fit: BoxFit.fitHeight,
          errorBuilder: (context, object, stackTrace) {
            return Image.asset(
              PlaceHolderAssets.searchLocation,
              fit: BoxFit.fill,
            );
          },
        ),
      ),
    );
  }

  Widget _mountLocationDetails(Size size) {
    return Container(
      height: size.width * 0.22,
      width: size.width * 0.64,
      padding: const EdgeInsets.only(left: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _mountLocationName(size),
          _mountLocationAddress(size),
        ],
      ),
    );
  }

  Widget _mountLocationAddress(Size size) {
    return Text(
      location.address,
      textAlign: TextAlign.left,
      softWrap: true,
      style: TextStyles.label(),
      overflow: TextOverflow.ellipsis,
      maxLines: 2,
    );
  }

  Widget _mountLocationName(Size size) {
    return Text(
      location.name,
      textAlign: TextAlign.left,
      softWrap: true,
      style: TextStyles.bodyText1(),
      overflow: TextOverflow.ellipsis,
      maxLines: 2,
    );
  }
}
