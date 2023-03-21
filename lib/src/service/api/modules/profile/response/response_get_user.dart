class ResponseGetUser {
  int? id;
  String? profilePhoto;
  String? name;
  String? email;
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
    this.email,
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
      email: json['email'],
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
  String? message;
  int? locationId;
  String? locationName;
  String? locationAddress;
  String? author;
  String? createdAt;

  ResponseGetUserReview({
    this.id,
    this.review,
    this.impressionStatus,
    this.myGrade,
    this.locationId,
    this.locationName,
    this.locationAddress,
    this.message,
    this.author,
    this.createdAt,
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
      message: json['message'],
      author: json['author'],
      createdAt: json['createdAt'],
    );
  }
}
