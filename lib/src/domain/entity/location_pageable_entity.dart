import 'package:is_it_safe_app/src/domain/entity/location_sort_entity.dart';

class LocationPageableEntity {
  LocationSortEntity? sort;
  int? pageNumber;
  int? pageSize;
  int? offset;
  bool? paged;
  bool? unpaged;

  LocationPageableEntity({
    this.sort,
    this.pageNumber,
    this.pageSize,
    this.offset,
    this.paged,
    this.unpaged,
  });
}
