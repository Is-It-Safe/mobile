import 'package:is_it_safe_app/core/model/location/location_info.dart';
import 'package:is_it_safe_app/core/model/location/sort.dart';

import 'pageable.dart';

class Location {
  List<LocationInfo>? content;
  Pageable? pageable;
  bool? last;
  int? totalPages;
  int? totalElements;
  Sort? sort;
  int? number;
  int? numberOfElements;
  bool? first;
  int? size;
  bool? empty;

  Location(
      {this.content,
      this.pageable,
      this.last,
      this.totalPages,
      this.totalElements,
      this.sort,
      this.number,
      this.numberOfElements,
      this.first,
      this.size,
      this.empty});

  Location.fromJson(Map<String, dynamic> json) {
    if (json['content'] != null) {
      content = <LocationInfo>[];
      json['content'].forEach((v) {
        content!.add(new LocationInfo.fromJson(v));
      });
    }
    pageable = json['pageable'] != null
        ? new Pageable.fromJson(json['pageable'])
        : null;
    last = json['last'];
    totalPages = json['totalPages'];
    totalElements = json['totalElements'];
    sort = json['sort'] != null ? new Sort.fromJson(json['sort']) : null;
    number = json['number'];
    numberOfElements = json['numberOfElements'];
    first = json['first'];
    size = json['size'];
    empty = json['empty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.content != null) {
      data['content'] = this.content!.map((v) => v.toJson()).toList();
    }
    if (this.pageable != null) {
      data['pageable'] = this.pageable!.toJson();
    }
    data['last'] = this.last;
    data['totalPages'] = this.totalPages;
    data['totalElements'] = this.totalElements;
    if (this.sort != null) {
      data['sort'] = this.sort!.toJson();
    }
    data['number'] = this.number;
    data['numberOfElements'] = this.numberOfElements;
    data['first'] = this.first;
    data['size'] = this.size;
    data['empty'] = this.empty;
    return data;
  }
}