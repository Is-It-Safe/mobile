import 'package:is_it_safe_app/src/core/constants/int_constants.dart';
import 'package:is_it_safe_app/src/core/constants/string_constants.dart';

class SexualOrientationEntity {
  int id;
  String title;

  SexualOrientationEntity({
    required this.id,
    required this.title,
  });

  factory SexualOrientationEntity.toEntity(dynamic sexualOrientation) {
    return SexualOrientationEntity(
      id: sexualOrientation.id ?? IntConstants.empty,
      title: sexualOrientation.title ?? StringConstants.empty,
    );
  }
}
