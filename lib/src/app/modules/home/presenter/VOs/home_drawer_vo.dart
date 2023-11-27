
import 'package:is_it_safe_app/src/core/constants/string_constants.dart';

class HomeDrawerVO {
  String userName;
  String userImage;
  Function()? onCloseDrawer;

  HomeDrawerVO({
    required this.userName,
    required this.userImage,
    this.onCloseDrawer,
  });

  HomeDrawerVO copyWith({
    String? userName,
    String? userImage,
    Function()? onCloseDrawer,
  }) {
    return HomeDrawerVO(
      userName: userName ?? this.userName,
      userImage: userImage ?? this.userImage,
      onCloseDrawer: onCloseDrawer ?? this.onCloseDrawer,
    );
  }

  static HomeDrawerVO get empty => HomeDrawerVO(
        userName: StringConstants.empty,
        userImage: StringConstants.empty,
        onCloseDrawer: () {},
      );
}
