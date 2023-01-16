import 'package:is_it_safe_app/generated/l10n.dart';
import 'package:is_it_safe_app/src/core/constants/string_constants.dart';
import 'package:is_it_safe_app/src/core/enum/location_type_enum.dart';

class ParseEnum {
  static String parseLocationTypeEnum(LocationTypeEnum location) {
    switch (location) {
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
