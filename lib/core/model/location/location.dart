import 'package:is_it_safe_app/core/model/location/location_info.dart';
import 'package:is_it_safe_app/core/model/location/sort.dart';

import 'pageable.dart';

class Locations {
  List<Location>? content;
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

  Locations(
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

  Locations.fromJson(Map<String, dynamic> json) {
    if (json['content'] != null) {
      content = <Location>[];
      json['content'].forEach((v) {
        content!.add(Location.fromJson(v));
      });
    }
    pageable =
        json['pageable'] != null ? Pageable.fromJson(json['pageable']) : null;
    last = json['last'];
    totalPages = json['totalPages'];
    totalElements = json['totalElements'];
    sort = json['sort'] != null ? Sort.fromJson(json['sort']) : null;
    number = json['number'];
    numberOfElements = json['numberOfElements'];
    first = json['first'];
    size = json['size'];
    empty = json['empty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (content != null) {
      data['content'] = content!.map((v) => v.toJson()).toList();
    }
    if (pageable != null) {
      data['pageable'] = pageable!.toJson();
    }
    data['last'] = last;
    data['totalPages'] = totalPages;
    data['totalElements'] = totalElements;
    if (sort != null) {
      data['sort'] = sort!.toJson();
    }
    data['number'] = number;
    data['numberOfElements'] = numberOfElements;
    data['first'] = first;
    data['size'] = size;
    data['empty'] = empty;
    return data;
  }
}
