class AssetConstants {
  static PlaceHolderAssets placeholder = PlaceHolderAssets();
  static _MockAssets mock = _MockAssets();
  static _IconsAssets icons = _IconsAssets();
  static _EmptyAssets empty = _EmptyAssets();
  static _GeneralAssets general = _GeneralAssets();
  static _EmoticonAssets emoticon = _EmoticonAssets();
}

class _EmptyAssets {
  String home = 'images/modules/core/empty/empty_home.svg';
  String search = 'images/modules/core/empty/empty_search.svg';
  String profile = 'images/modules/core/empty/empty_review.svg';
}

class _EmoticonAssets {
  String angry = 'images/modules/core/review/review_0.svg';
  String sad = 'images/modules/core/review/review_1.svg';
  String neutral = 'images/modules/core/review/review_2.svg';
  String happy = 'images/modules/core/review/review_3.svg';
  String excited = 'images/modules/core/review/review_4.svg';
}

class _IconsAssets {
  String arrowBack = 'images/modules/core/icons/arrow_back_icon.svg';
  String arrowFoward = 'images/modules/core/icons/arrow_foward_icon.svg';
  String drawer = 'images/modules/core/icons/drawer_icon.svg';
  String edit = 'images/modules/core/icons/edit_icon.svg';
  String star = 'images/modules/core/icons/star_icon.svg';
  String comment = 'images/modules/core/icons/review_icon.svg';
  String homeOutlined = 'images/modules/core/icons/home_active_icon.svg';
  String home = 'images/modules/core/icons/home_icon.svg';
  String reviewOutlined = 'images/modules/core/icons/review_active_icon.svg';
  String review = 'images/modules/core/icons/review_clean_icon.svg';
  String searchOutlined = 'images/modules/core/icons/search_active_icon.svg';
  String search = 'images/modules/core/icons/search_icon.svg';
  String account = 'images/modules/core/icons/account_icon.svg';
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
