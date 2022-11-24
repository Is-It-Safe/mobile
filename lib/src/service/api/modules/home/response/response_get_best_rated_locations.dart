class ResponseGetBestRatedLocations {
  List<ResponseGetBestRatedLocationsLocation>? locations;
  ResponseGetBestRatedLocationsPageable? pageable;
  bool? last;
  int? totalPages;
  int? totalElements;
  ResponseGetBestRatedLocationsSort? sort;
  bool? first;
  int? number;
  int? numberOfElements;
  int? size;
  bool? empty;

  ResponseGetBestRatedLocations({
    this.locations,
    this.pageable,
    this.last,
    this.totalPages,
    this.totalElements,
    this.sort,
    this.first,
    this.number,
    this.numberOfElements,
    this.size,
    this.empty,
  });

  factory ResponseGetBestRatedLocations.fromJson(dynamic json) {
    final locations = (json['content'] as List)
        .map((e) => ResponseGetBestRatedLocationsLocation.fromJson(
            e as Map<String, dynamic>))
        .toList();

    return ResponseGetBestRatedLocations(
      locations: locations,
      pageable: json['pageable'] != null
          ? ResponseGetBestRatedLocationsPageable.fromJson(json['pageable'])
          : null,
      last: json['last'],
      totalPages: json['totalPages'],
      totalElements: json['totalElements'],
      sort: json['sort'] != null
          ? ResponseGetBestRatedLocationsSort.fromJson(json['sort'])
          : null,
      first: json['first'],
      number: json['number'],
      numberOfElements: json['numberOfElements'],
      size: json['size'],
      empty: json['empty'],
    );
  }
}

class ResponseGetBestRatedLocationsLocation {
  int? id;
  String? name;
  String? endereco;
  String? imgUrl;
  double? averageGrade;
  String? averageImpressionStatus;
  int? reviewsQnt;

  ResponseGetBestRatedLocationsLocation({
    this.id,
    this.name,
    this.endereco,
    this.imgUrl,
    this.averageGrade,
    this.averageImpressionStatus,
    this.reviewsQnt,
  });

  factory ResponseGetBestRatedLocationsLocation.fromJson(dynamic json) {
    return ResponseGetBestRatedLocationsLocation(
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

class ResponseGetBestRatedLocationsPageable {
  ResponseGetBestRatedLocationsSort? sort;
  int? pageSize;
  int? pageNumber;
  int? offset;
  bool? paged;
  bool? unpaged;

  ResponseGetBestRatedLocationsPageable({
    this.sort,
    this.pageSize,
    this.pageNumber,
    this.offset,
    this.paged,
    this.unpaged,
  });

  factory ResponseGetBestRatedLocationsPageable.fromJson(dynamic json) {
    return ResponseGetBestRatedLocationsPageable(
      sort: json['sort'] != null
          ? ResponseGetBestRatedLocationsSort.fromJson(json['sort'])
          : null,
      pageSize: json['pageSize'],
      pageNumber: json['pageNumber'],
      offset: json['offset'],
      paged: json['paged'],
      unpaged: json['unpaged'],
    );
  }
}

class ResponseGetBestRatedLocationsSort {
  bool? sorted;
  bool? unsorted;
  bool? empty;

  ResponseGetBestRatedLocationsSort({
    this.sorted,
    this.unsorted,
    this.empty,
  });

  factory ResponseGetBestRatedLocationsSort.fromJson(dynamic json) {
    return ResponseGetBestRatedLocationsSort(
      sorted: json['sorted'],
      unsorted: json['unsorted'],
      empty: json['empty'],
    );
  }
}
