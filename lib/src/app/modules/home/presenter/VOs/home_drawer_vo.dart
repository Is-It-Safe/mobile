import 'package:is_it_safe_app/src/core/constants/string_constants.dart';

class HomeDrawerVO {
  String userName;
  String userImage;

  HomeDrawerVO({
    required this.userName,
    required this.userImage,
  });

  HomeDrawerVO copyWith({
    String? userName,
    String? userImage,
  }) {
    return HomeDrawerVO(
      userName: userName ?? this.userName,
      userImage: userImage ?? this.userImage,
    );
  }

  static HomeDrawerVO get empty => HomeDrawerVO(
        userName: StringConstants.empty,
        userImage: StringConstants.empty,
      );
}
