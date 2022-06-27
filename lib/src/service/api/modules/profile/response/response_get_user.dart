class ResponseGetUser {
  int? id;
  String? profilePhoto;
  String? nickname;
  String? pronoun;
  String? gender;
  String? orientation;
  List<ResponseGetUserReview>? reviews;

  ResponseGetUser({
    this.id,
    this.profilePhoto,
    this.nickname,
    this.pronoun,
    this.gender,
    this.orientation,
    this.reviews,
  });

  factory ResponseGetUser.fromJson(dynamic json) {
    final reviews = (json['reviews'] as List)
        .map((e) => ResponseGetUserReview.fromJson(e as Map<String, dynamic>))
        .toList();

    return ResponseGetUser(
      id: json['id'],
      profilePhoto: json['profilePhoto'],
      nickname: json['nickname'],
      pronoun: json['pronoun'],
      gender: json['gender'],
      orientation: json['orientation'],
      reviews: reviews,
    );
  }
}

class ResponseGetUserReview {
  int? id;
  String? review;
  String? impressionStatus;
  double? myGrade;

  ResponseGetUserReview({
    this.id,
    this.review,
    this.impressionStatus,
    this.myGrade,
  });

  factory ResponseGetUserReview.fromJson(dynamic json) {
    return ResponseGetUserReview(
      id: json['id'],
      review: json['review'],
      impressionStatus: json['impressionStatus'],
      myGrade: json['myGrade'],
    );
  }
}
