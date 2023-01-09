class RequestUpdateUser {
  final int? id;
  final String? name;
  final String? nickname;
  final String? pronoun;
  final int? genderId;
  final int? sexualOrientationId;
  final String? profilePhoto;

  RequestUpdateUser({
    this.id,
    this.name,
    this.nickname,
    this.pronoun,
    this.genderId,
    this.sexualOrientationId,
    this.profilePhoto,
  });

  Map<String, dynamic> toJson(RequestUpdateUser request) {
    return {
      'name': request.name,
      'nickname': request.nickname,
      'pronoun': request.pronoun,
      'gender_id': request.genderId,
      'orientation_id': request.sexualOrientationId,
      'photoUrl': request.profilePhoto,
    };
  }
}
