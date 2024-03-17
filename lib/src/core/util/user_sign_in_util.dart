import 'package:is_it_safe_app/generated/l10n.dart';
import 'package:is_it_safe_app/src/core/constants/string_constants.dart';
import 'package:is_it_safe_app/src/core/enum/user_sign_in_enum.dart';

class UserSignInUtil {
  static int? getCorrectMaxLengthForSignIn({
    required UserSignInEnum userSignInEnum,
  }) {
    switch (userSignInEnum) {
      case UserSignInEnum.user:
        return 50;
      case UserSignInEnum.nickName:
        return 15;
      case UserSignInEnum.pronouns:
        return null;
      case UserSignInEnum.email:
        return null;
    }
  }

  static String getCorrectLabelForSignIn({
    required UserSignInEnum userSignInEnum,
  }) {
    switch (userSignInEnum) {
      case UserSignInEnum.user:
        return S.current.textName + StringConstants.asterisk;
      case UserSignInEnum.nickName:
        return S.current.textUsername + StringConstants.asterisk;
      case UserSignInEnum.pronouns:
        return S.current.textPronouns;
      case UserSignInEnum.email:
        return S.current.textEmailAddress + StringConstants.asterisk;
    }
  }

  static String getCorrectBottomTextForSignIn({
    required UserSignInEnum userSignInEnum,
  }) {
    switch (userSignInEnum) {
      case UserSignInEnum.user:
        return S.current.textSayYourNameThisInfoIsPrivate;
      case UserSignInEnum.nickName:
        return S.current.textDontBeAfraidToBeCreative;
      case UserSignInEnum.pronouns:
        return S.current.textHowDoYouPreferWeReferToYou;
      case UserSignInEnum.email:
        return S.current.textTellUsTheEmailAssociatedWithYourAccount;
      default:
        return StringConstants.empty;
    }
  }
}
