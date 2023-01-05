import 'package:flutter/material.dart';
import 'package:is_it_safe_app/src/components/style/text/text_styles.dart';
import 'package:is_it_safe_app/src/core/constants/assets_constants.dart';
import 'package:is_it_safe_app/src/domain/entity/location_entity.dart';

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

    return Row(
      children: [
        SearchLocationCardImageWidget(locationImagePath: location.imagePath),
        Container(
          height: size.width * 0.22,
          width: size.width * 0.50,
          padding: const EdgeInsets.only(left: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SearchLocationCardName(name: location.name),
              SearchLocationCardAddress(address: location.address),
            ],
          ),
        ),
      ],
    );
  }
}

class SearchLocationCardAddress extends StatelessWidget {
  final String address;
  const SearchLocationCardAddress({
    Key? key,
    required this.address,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      address,
      textAlign: TextAlign.left,
      softWrap: true,
      style: TextStyles.label(),
      overflow: TextOverflow.ellipsis,
      maxLines: 2,
    );
  }
}

class SearchLocationCardName extends StatelessWidget {
  final String name;
  const SearchLocationCardName({
    Key? key,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      name,
      textAlign: TextAlign.left,
      softWrap: true,
      style: TextStyles.bodyText1(),
      overflow: TextOverflow.ellipsis,
      maxLines: 2,
    );
  }
}

class SearchLocationCardImageWidget extends StatelessWidget {
  final String? locationImagePath;

  const SearchLocationCardImageWidget({
    Key? key,
    required this.locationImagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: Image.network(
        locationImagePath ?? PlaceHolderAssets.searchLocation,
        fit: BoxFit.fitHeight,
        width: size.width * 0.25,
        height: size.width * 0.22,
        errorBuilder: (context, object, stackTrace) {
          return Image.asset(
            PlaceHolderAssets.searchLocation,
            fit: BoxFit.fill,
          );
        },
      ),
    );
  }
}
