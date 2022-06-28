import 'package:is_it_safe_app/src/core/constants/string_constants.dart';
import 'package:is_it_safe_app/src/domain/entity/review_entity.dart';
import 'package:is_it_safe_app/src/service/api/modules/profile/response/response_get_user.dart';

class UserEntity {
  int id;
  String? profilePhoto;
  String? name;
  String? nickname;
  String? pronoun;
  String? gender;
  String? orientation;
  String? birthDate;
  List<ReviewEntity>? reviews;

  UserEntity({
    required this.id,
    this.profilePhoto,
    this.name,
    this.nickname,
    this.pronoun,
    this.gender,
    this.orientation,
    this.birthDate,
    this.reviews,
  });

  factory UserEntity.toEntity(ResponseGetUser user) {
    return UserEntity(
      id: user.id!,
      name: user.name ?? StringConstants.empty,
      nickname: user.nickname ?? StringConstants.empty,
      profilePhoto: user.profilePhoto ?? StringConstants.empty,
      pronoun: user.pronoun ?? StringConstants.empty,
      gender: user.gender ?? StringConstants.empty,
      orientation: user.orientation ?? StringConstants.empty,
      birthDate: user.birthDate ?? StringConstants.empty,
      reviews:
          user.reviews?.map((e) => ReviewEntity.toEntity(e)).toList() ?? [],
    );
  }
}
