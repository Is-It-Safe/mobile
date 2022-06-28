class ResponseGetUser {
  int? id;
  String? profilePhoto;
  String? name;
  String? nickname;
  String? pronoun;
  String? gender;
  String? orientation;
  String? birthDate;
  List<ResponseGetUserReview>? reviews;

  ResponseGetUser({
    this.id,
    this.profilePhoto,
    this.name,
    this.nickname,
    this.pronoun,
    this.gender,
    this.orientation,
    this.birthDate,
    this.reviews,
  });

  factory ResponseGetUser.fromJson(dynamic json) {
    final reviews = (json['reviews'] as List)
        .map((e) => ResponseGetUserReview.fromJson(e as Map<String, dynamic>))
        .toList();

    return ResponseGetUser(
      id: json['id'],
      profilePhoto: json['profilePhoto'],
      name: json['fullName'],
      nickname: json['nickname'],
      pronoun: json['pronoun'],
      gender: json['gender'],
      orientation: json['orientation'],
      birthDate: json['birthDate'],
      reviews: reviews,
    );
  }
}

class ResponseGetUserReview {
  int? id;
  String? review;
  String? impressionStatus;
  double? myGrade;

  int? locationId;
  String? locationName;
  String? locationAddress;

  ResponseGetUserReview({
    this.id,
    this.review,
    this.impressionStatus,
    this.myGrade,
    this.locationId,
    this.locationName,
    this.locationAddress,
  });

  factory ResponseGetUserReview.fromJson(dynamic json) {
    return ResponseGetUserReview(
      id: json['review_id'],
      review: json['review'],
      impressionStatus: json['impressionStatus'],
      myGrade: json['myGrade'],
      locationId: json['locationId'],
      locationName: json['locationName'],
      locationAddress: json['locationAddress'],
    );
  }
}
