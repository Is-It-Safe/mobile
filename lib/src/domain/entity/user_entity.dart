import 'package:is_it_safe_app/src/core/constants/int_constants.dart';
import 'package:is_it_safe_app/src/core/constants/string_constants.dart';
import 'package:is_it_safe_app/src/domain/entity/review_entity.dart';
import 'package:is_it_safe_app/src/service/api/modules/profile/response/response_get_user.dart';
import 'package:is_it_safe_app/src/service/api/modules/profile/response/response_update_user.dart';

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
  int? genreId;
  int? sexualOrientationId;

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
    this.genreId,
    this.sexualOrientationId,
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

  factory UserEntity.toEntityUpdate(ResponseUpdateUser user) {
    return UserEntity(
      id: user.id!,
      name: user.name ?? StringConstants.empty,
      nickname: user.nickname ?? StringConstants.empty,
      profilePhoto: user.profilePhoto ?? StringConstants.empty,
      pronoun: user.pronoun ?? StringConstants.empty,
      genreId: user.genderId ?? IntConstants.empty,
      sexualOrientationId: user.sexualOrientationId ?? IntConstants.empty,
    );
  }

  UserEntity copyWith({
    int? id,
    String? profilePhoto,
    String? name,
    String? nickname,
    String? pronoun,
    String? gender,
    String? orientation,
    String? birthDate,
    List<ReviewEntity>? reviews,
    int? genreId,
    int? sexualOrientationId,
  }) {
    return UserEntity(
      id: id ?? this.id,
      profilePhoto: profilePhoto ?? this.profilePhoto,
      name: name ?? this.name,
      nickname: nickname ?? this.nickname,
      pronoun: pronoun ?? this.pronoun,
      gender: gender ?? this.gender,
      orientation: orientation ?? this.orientation,
      birthDate: birthDate ?? this.birthDate,
      reviews: reviews ?? this.reviews,
      genreId: genreId ?? this.genreId,
      sexualOrientationId: sexualOrientationId ?? this.sexualOrientationId,
    );
  }
}
