import 'package:is_it_safe_app/generated/l10n.dart';
import 'package:is_it_safe_app/src/core/constants/string_constants.dart';

enum LocationTypeEnum {
  pub,
  restaurant,
  publicLocation,
  nightClub,
}

extension LocationTypeEnumExtension on LocationTypeEnum {
  String get name {
    switch (this) {
      case LocationTypeEnum.pub:
        return S.current.textAddLocationTypePub;
      case LocationTypeEnum.restaurant:
        return S.current.textAddLocationTypeRestaurant;
      case LocationTypeEnum.publicLocation:
        return S.current.textAddLocationTypePublicLocation;
      case LocationTypeEnum.nightClub:
        return S.current.textAddLocationTypeNightClub;
      default:
        return StringConstants.empty;
    }
  }
}
