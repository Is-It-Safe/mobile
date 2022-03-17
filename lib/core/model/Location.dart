class Location {
  List<Content>? content;
  Pageable? pageable;
  bool? last;
  int? totalPages;
  int? totalElements;
  bool? first;
  int? number;
  Sort? sort;
  int? numberOfElements;
  int? size;
  bool? empty;

  Location(
      {this.content,
      this.pageable,
      this.last,
      this.totalPages,
      this.totalElements,
      this.first,
      this.number,
      this.sort,
      this.numberOfElements,
      this.size,
      this.empty});

  Location.fromJson(Map<String, dynamic> json) {
    if (json['content'] != null) {
      content = <Content>[];
      json['content'].forEach((v) {
        content!.add(new Content.fromJson(v));
      });
    }
    pageable = json['pageable'] != null
        ? new Pageable.fromJson(json['pageable'])
        : null;
    last = json['last'];
    totalPages = json['totalPages'];
    totalElements = json['totalElements'];
    first = json['first'];
    number = json['number'];
    sort = json['sort'] != null ? new Sort.fromJson(json['sort']) : null;
    numberOfElements = json['numberOfElements'];
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
    data['first'] = this.first;
    data['number'] = this.number;
    if (this.sort != null) {
      data['sort'] = this.sort!.toJson();
    }
    data['numberOfElements'] = this.numberOfElements;
    data['size'] = this.size;
    data['empty'] = this.empty;
    return data;
  }
}

class Content {
  int? id;
  String? name;
  String? endereco;
  String? imgUrl;
  double? averageGrade;
  int? reviewsQnt;

  Content(
      {this.id,
      this.name,
      this.endereco,
      this.imgUrl,
      this.averageGrade,
      this.reviewsQnt});

  Content.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    endereco = json['endereco'];
    imgUrl = json['imgUrl'];
    averageGrade = json['averageGrade'];
    reviewsQnt = json['reviewsQnt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['endereco'] = this.endereco;
    data['imgUrl'] = this.imgUrl;
    data['averageGrade'] = this.averageGrade;
    data['reviewsQnt'] = this.reviewsQnt;
    return data;
  }
}

class Pageable {
  Sort? sort;
  int? pageNumber;
  int? pageSize;
  int? offset;
  bool? paged;
  bool? unpaged;

  Pageable(
      {this.sort,
      this.pageNumber,
      this.pageSize,
      this.offset,
      this.paged,
      this.unpaged});

  Pageable.fromJson(Map<String, dynamic> json) {
    sort = json['sort'] != null ? new Sort.fromJson(json['sort']) : null;
    pageNumber = json['pageNumber'];
    pageSize = json['pageSize'];
    offset = json['offset'];
    paged = json['paged'];
    unpaged = json['unpaged'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.sort != null) {
      data['sort'] = this.sort!.toJson();
    }
    data['pageNumber'] = this.pageNumber;
    data['pageSize'] = this.pageSize;
    data['offset'] = this.offset;
    data['paged'] = this.paged;
    data['unpaged'] = this.unpaged;
    return data;
  }
}

class Sort {
  bool? sorted;
  bool? unsorted;
  bool? empty;

  Sort({this.sorted, this.unsorted, this.empty});

  Sort.fromJson(Map<String, dynamic> json) {
    sorted = json['sorted'];
    unsorted = json['unsorted'];
    empty = json['empty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sorted'] = this.sorted;
    data['unsorted'] = this.unsorted;
    data['empty'] = this.empty;
    return data;
  }
}


/*class Location {
  late int id;
  late String name;
  late String endereco;
  String? imgUrl;
  int? averageGrade;
  int? reviewsQnt;

  Location(
      {required this.id,
      required this.name,
      required this.endereco,
      this.imgUrl,
      this.averageGrade,
      this.reviewsQnt});

  Location.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    endereco = json['endereco'];
    imgUrl = json['imgUrl'];
    averageGrade = json['averageGrade'];
    reviewsQnt = json['reviewsQnt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['endereco'] = endereco;
    data['imgUrl'] = imgUrl;
    data['averageGrade'] = averageGrade;
    data['reviewsQnt'] = reviewsQnt;
    return data;
  }
}*/
