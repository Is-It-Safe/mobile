import 'package:is_it_safe_app/src/core/constants/double_constants.dart';
import 'package:is_it_safe_app/src/core/constants/int_constants.dart';
import 'package:is_it_safe_app/src/core/constants/string_constants.dart';

class LocationEntity {
  final int id;
  final String name;
  final String address;
  final String? imagePath;
  final double? averageGrade;
  final String? averageImpressionStatus;
  final int? reviewsQnt;

  LocationEntity({
    required this.id,
    required this.name,
    required this.address,
    this.imagePath,
    this.averageGrade,
    this.averageImpressionStatus,
    this.reviewsQnt,
  });

  factory LocationEntity.toEntity(dynamic location) {
    return LocationEntity(
      id: location.id ?? IntConstants.empty,
      name: location.name ?? StringConstants.empty,
      address: location.endereco ?? StringConstants.empty,
      averageGrade: location.averageGrade ?? DoubleConstants.empty,
      reviewsQnt: location.reviewsQnt ?? IntConstants.empty,
      imagePath: location.imgUrl ?? StringConstants.empty,
      averageImpressionStatus:
          location.averageImpressionStatus ?? StringConstants.empty,
    );
  }
}
