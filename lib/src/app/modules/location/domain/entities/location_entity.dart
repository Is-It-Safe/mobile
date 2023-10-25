import 'package:brasil_fields/brasil_fields.dart';
import 'package:is_it_safe_app/src/app/modules/home/domain/models/response/response_get_best_rated_places.dart';
import 'package:is_it_safe_app/src/app/modules/location/domain/entities/response/response_get_location_by_id.dart';
import 'package:is_it_safe_app/src/app/modules/location/domain/entities/response/response_location_by_cep.dart';
import 'package:is_it_safe_app/src/app/modules/location/domain/entities/response/response_location_review.dart';
import 'package:is_it_safe_app/src/app/modules/location/domain/entities/response/response_save_location.dart';
import 'package:is_it_safe_app/src/app/modules/profile/domain/models/response/response_get_user.dart';
import 'package:is_it_safe_app/src/core/constants/double_constants.dart';
import 'package:is_it_safe_app/src/core/constants/int_constants.dart';
import 'package:is_it_safe_app/src/core/constants/string_constants.dart';

class LocationEntity {
  final int? id;
  final String name;
  final String address;
  final String? imagePath;
  final double? averageGrade;
  final String? averageImpressionStatus;
  final int? reviewsQnt;
  final List<ResponseLocationReview>? reviews;
  final List<ReviewChart>? reviewChart;
  final String? cep;

  LocationEntity({
    this.id,
    required this.name,
    required this.address,
    this.imagePath,
    this.averageGrade,
    this.averageImpressionStatus,
    this.reviewsQnt,
    this.reviews,
    this.reviewChart,
    this.cep,
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
      reviews: location.reviews ?? [],
      reviewChart: location.reviewChart ?? [],
    );
  }

  factory LocationEntity.fromGetBestRatedPlaces(
      ResponseGetRatedPlaces location) {
    return LocationEntity(
      id: location.id ?? IntConstants.empty,
      name: location.name ?? StringConstants.empty,
      address: location.address ?? StringConstants.empty,
      averageGrade: location.averageGrade ?? DoubleConstants.empty,
      reviewsQnt: location.reviewsQnt ?? IntConstants.empty,
      imagePath: location.imgUrl ?? StringConstants.empty,
      averageImpressionStatus:
      location.averageImpressionStatus ?? StringConstants.empty,
    );
  }

  factory LocationEntity.fromResponseSaveLocation(
      ResponseSaveLocation location) {
    return LocationEntity(
      id: location.id ?? IntConstants.empty,
      name: location.name ?? StringConstants.empty,
      address: location.endereco ?? StringConstants.empty,
      averageGrade: location.averageGrade ?? DoubleConstants.empty,
      reviewsQnt: location.reviewsQnt ?? IntConstants.empty,
      imagePath: location.imgUrl ?? StringConstants.empty,
      averageImpressionStatus:
      location.averageImpressionStatus ?? StringConstants.empty,
      reviews: location.reviews ?? [],
    );
  }

  factory LocationEntity.fromResponseGetLocationByCep(
      ResponseLocationByCep zipCode) {
    return LocationEntity(
      name: UtilBrasilFields.removeCaracteres(zipCode.cep ?? StringConstants.empty),
      address: zipCode.bairro ?? StringConstants.empty,
    );
  }

  factory LocationEntity.fromResponseGetUserReview(
      ResponseGetUserReview review) {
    return LocationEntity(
      id: review.id ?? 0,
      name: review.locationName ?? StringConstants.empty,
      address: review.locationAddress ?? StringConstants.empty,
    );
  }

  factory LocationEntity.fromResponseSearchLocationByName(dynamic location) {
    return LocationEntity(
      id: location.id ?? IntConstants.empty,
      name: location.name ?? StringConstants.empty,
      address: location.endereco ?? StringConstants.empty,
      averageGrade: location.averageGrade ?? DoubleConstants.empty,
      reviewsQnt: location.reviewsQnt ?? IntConstants.empty,
      imagePath: location.imgUrl ?? StringConstants.empty,
      averageImpressionStatus:
      location.averageImpressionStatus ?? StringConstants.empty,
      reviews: location.reviews ?? [],
    );
  }
}