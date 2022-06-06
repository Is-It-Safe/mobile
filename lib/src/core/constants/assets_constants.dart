class AssetConstants {
  static PlaceHolderAssets placeholder = PlaceHolderAssets();
  static _MockAssets mock = _MockAssets();
  static _IconsAssets icons = _IconsAssets();
  static _EmptyAssets empty = _EmptyAssets();
  static _GeneralAssets general = _GeneralAssets();
}

class _EmptyAssets {
  String home = 'images/modules/core/empty/empty_home.svg';
}

class _IconsAssets {
  String arrowBack = 'images/modules/core/icons/arrow_back_icon.svg';
  String drawer = 'images/modules/core/icons/drawer_icon.svg';
  String edit = 'images/modules/core/icons/edit_icon.svg';
  String star = 'images/modules/core/icons/star_icon.svg';
  String review = 'images/modules/core/icons/review_icon.svg';
}

class _MockAssets {
  String locationImage = 'images/modules/home/mock_place.png';
}

class _GeneralAssets {
  String logo = 'images/modules/auth/splash_logo.png';
  String onBoarding1 = 'images/modules/auth/on_boarding_1.png';
  String onBoarding2 = 'images/modules/auth/on_boarding_2.png';
  String onBoarding3 = 'images/modules/auth/on_boarding_3.png';
  String profilePictures = 'images/modules/auth/profile_pictures/profile_pic_';
}

//TODO tentar deixar classe privada
class PlaceHolderAssets {
  static const String profileAvatar =
      'images/modules/auth/profile_pictures/placeholder/placeholder_avatar.png';
  static const String searchLocation =
      'images/modules/core/placeholder/search_placeholder.png';
}
