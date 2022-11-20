class ResponseGetLocationsByName {
  List<ResponseGetLocationsByNameLocation>? locations;
  ResponseGetLocationsByNamePageable? pageable;
  bool? last;
  int? totalPages;
  int? totalElements;
  ResponseGetLocationsByNameSort? sort;
  bool? first;
  int? size;
  int? number;
  int? numberOfElements;
  bool? empty;

  ResponseGetLocationsByName({
    this.locations,
    this.pageable,
    this.last,
    this.totalPages,
    this.totalElements,
    this.sort,
    this.first,
    this.size,
    this.number,
    this.numberOfElements,
    this.empty,
  });

  factory ResponseGetLocationsByName.fromJson(dynamic json) {
    final locations = json['content'] != null
        ? (json['content'] as List)
            .map((e) => ResponseGetLocationsByNameLocation.fromJson(
                e as Map<String, dynamic>))
            .toList()
        : null;
    return ResponseGetLocationsByName(
      locations: locations,
      pageable: json['pageable'] != null
          ? ResponseGetLocationsByNamePageable.fromJson(json['pageable'])
          : null,
      last: json['last'],
      totalPages: json['totalPages'],
      totalElements: json['totalElements'],
      sort: json['sort'] != null
          ? ResponseGetLocationsByNameSort.fromJson(json['sort'])
          : null,
      first: json['first'],
      size: json['size'],
      number: json['number'],
      numberOfElements: json['numberOfElements'],
      empty: json['empty'],
    );
  }
}

class ResponseGetLocationsByNameLocation {
  int? id;
  String? name;
  String? endereco;
  String? imgUrl;
  double? averageGrade;
  String? averageImpressionStatus;
  int? reviewsQnt;

  ResponseGetLocationsByNameLocation({
    this.id,
    this.name,
    this.endereco,
    this.imgUrl,
    this.averageGrade,
    this.averageImpressionStatus,
    this.reviewsQnt,
  });

  factory ResponseGetLocationsByNameLocation.fromJson(dynamic json) {
    return ResponseGetLocationsByNameLocation(
      id: json['id'],
      name: json['name'],
      endereco: json['endereco'],
      imgUrl: json['imgUrl'],
      averageGrade: json['averageGrade'],
      averageImpressionStatus: json['averageImpressionStatus'],
      reviewsQnt: json['reviewsQnt'],
    );
  }
}

class ResponseGetLocationsByNamePageable {
  ResponseGetLocationsByNameSort? sort;
  int? pageSize;
  int? pageNumber;
  int? offset;
  bool? paged;
  bool? unpaged;

  ResponseGetLocationsByNamePageable({
    this.sort,
    this.pageSize,
    this.pageNumber,
    this.offset,
    this.paged,
    this.unpaged,
  });

  factory ResponseGetLocationsByNamePageable.fromJson(dynamic json) {
    return ResponseGetLocationsByNamePageable(
      sort: json['sort'] != null
          ? ResponseGetLocationsByNameSort.fromJson(json['sort'])
          : null,
      pageSize: json['pageSize'],
      pageNumber: json['pageNumber'],
      offset: json['offset'],
      paged: json['paged'],
      unpaged: json['unpaged'],
    );
  }
}

class ResponseGetLocationsByNameSort {
  bool? sorted;
  bool? unsorted;
  bool? empty;

  ResponseGetLocationsByNameSort({this.sorted, this.unsorted, this.empty});

  factory ResponseGetLocationsByNameSort.fromJson(dynamic json) {
    return ResponseGetLocationsByNameSort(
      sorted: json['sorted'],
      unsorted: json['unsorted'],
      empty: json['empty'],
    );
  }
}
