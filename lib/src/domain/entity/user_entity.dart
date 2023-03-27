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
      name: user.name ?? StringConstants.hyphen,
      nickname: user.nickname ?? StringConstants.hyphen,
      profilePhoto: user.profilePhoto ?? StringConstants.hyphen,
      pronoun: user.pronoun ?? StringConstants.hyphen,
      gender: user.gender ?? StringConstants.hyphen,
      orientation: user.orientation ?? StringConstants.hyphen,
      birthDate: user.birthDate ?? StringConstants.hyphen,
      reviews: user.reviews
              ?.map((e) => ReviewEntity.fromProfileReview(e))
              .toList() ??
          [],
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

  factory UserEntity.empty() {
    return UserEntity(
      id: IntConstants.empty,
      name: StringConstants.hyphen,
      nickname: StringConstants.hyphen,
      birthDate: StringConstants.hyphen,
      gender: StringConstants.hyphen,
      orientation: StringConstants.hyphen,
      pronoun: StringConstants.hyphen,
    );
  }

  UserEntity copyWith({
    String? profilePhoto,
    String? name,
    String? nickname,
    String? pronoun,
    String? gender,
    String? orientation,
    String? birthDate,
    int? genreId,
    int? sexualOrientationId,
    List<ReviewEntity>? reviews,
  }) {
    return UserEntity(
      id: id,
      profilePhoto: this.profilePhoto ?? profilePhoto,
      name: this.name ?? name,
      nickname: this.nickname ?? nickname,
      pronoun: this.pronoun ?? pronoun,
      gender: this.gender ?? gender,
      birthDate: this.birthDate ?? birthDate,
      orientation: this.orientation ?? orientation,
      genreId: this.genreId ?? genreId,
      sexualOrientationId: this.sexualOrientationId ?? sexualOrientationId,
      reviews: this.reviews ?? reviews,
    );
  }
}
