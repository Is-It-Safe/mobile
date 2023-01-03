import 'package:is_it_safe_app/src/core/constants/int_constants.dart';
import 'package:is_it_safe_app/src/core/constants/string_constants.dart';

class GenderEntity {
  int id;
  String title;

  GenderEntity({
    required this.id,
    required this.title,
  });

  factory GenderEntity.toEntity(dynamic gender) {
    return GenderEntity(
      id: gender.id ?? IntConstants.empty,
      title: gender.title ?? StringConstants.empty,
    );
  }
}
