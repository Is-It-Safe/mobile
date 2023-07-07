import 'package:is_it_safe_app/generated/l10n.dart';
import 'package:is_it_safe_app/src/core/constants/assets_constants.dart';
import 'package:is_it_safe_app/src/core/constants/string_constants.dart';

enum ImpressionStatusEnum { safe, warning, danger }

extension ImpressionStatusEnumExtension on ImpressionStatusEnum {
  String get name {
    switch (this) {
      case ImpressionStatusEnum.safe:
        return StringConstants.safe;
      case ImpressionStatusEnum.warning:
        return StringConstants.warning;
      case ImpressionStatusEnum.danger:
        return StringConstants.danger;
      default:
        return StringConstants.empty;
    }
  }

  String get text {
    switch (this) {
      case ImpressionStatusEnum.safe:
        return S.current.textSafeForLGBT;
      case ImpressionStatusEnum.warning:
        return S.current.textSomeProblemsHappend;
      case ImpressionStatusEnum.danger:
        return S.current.textDontRecomendThisPlace;
      default:
        return StringConstants.empty;
    }
  }

  String get message {
    switch (this) {
      case ImpressionStatusEnum.safe:
        return S.current.textMostPeopleSafePlace;

      case ImpressionStatusEnum.warning:
        return S.current.textMostPeopleAlertPlace;

      case ImpressionStatusEnum.danger:
        return S.current.textMostPeopleDangerPlace;
    }
  }

  String get image {
    switch (this) {
      case ImpressionStatusEnum.safe:
        return AssetConstants.impression.safe;
      case ImpressionStatusEnum.warning:
        return AssetConstants.impression.warning;
      case ImpressionStatusEnum.danger:
        return AssetConstants.impression.danger;
      default:
        return AssetConstants.impression.safe;
    }
  }
}

class ImpressionStatusEnumUtil {
  static ImpressionStatusEnum fromString(String value) {
    switch (value) {
      case StringConstants.safe:
        return ImpressionStatusEnum.safe;
      case StringConstants.warning:
        return ImpressionStatusEnum.warning;
      case StringConstants.danger:
        return ImpressionStatusEnum.danger;
      default:
        return ImpressionStatusEnum.warning;
    }
  }
}
