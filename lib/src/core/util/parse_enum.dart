import 'package:is_it_safe_app/generated/l10n.dart';
import 'package:is_it_safe_app/src/core/enum/location_type_enum.dart';

class ParseEnum {
  static String parseLocationTypeEnum(LocationTypeEnum location) {
    switch (location) {
      case LocationTypeEnum.pub:
        return S.current.textAddLocaleTypePub;
      case LocationTypeEnum.restaurant:
        return S.current.textAddLocaleTypeRestaurant;
      case LocationTypeEnum.publicLocation:
        return S.current.textAddLocaleTypePublicLocation;
      case LocationTypeEnum.nightClub:
        return S.current.textAddLocaleTypeNightClub;
      default:
        return '';
    }
  }
}
