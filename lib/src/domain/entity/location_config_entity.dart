import 'package:is_it_safe_app/src/domain/entity/location_entity.dart';
import 'package:is_it_safe_app/src/domain/entity/location_pageable_entity.dart';
import 'package:is_it_safe_app/src/domain/entity/location_sort_entity.dart';

class LocationConfigEntity {
  List<LocationEntity>? content;
  LocationPageableEntity? pageable;
  bool? last;
  int? totalPages;
  int? totalElements;
  bool? first;
  int? number;
  LocationSortEntity? sort;
  int? numberOfElements;
  int? size;
  bool? empty;

  LocationConfigEntity({
    this.content,
    this.pageable,
    this.last,
    this.totalPages,
    this.totalElements,
    this.first,
    this.number,
    this.sort,
    this.numberOfElements,
    this.size,
    this.empty,
  });
}
