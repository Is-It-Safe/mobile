class RequestUpdateUser {
  int? id;
  String? name;
  String? nickname;
  String? pronoun;
  int? genderId;
  int? sexualOrientationId;
  String? profilePhoto;

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
      'id': request.id,
      'name': request.name,
      'nickname': request.nickname,
      'pronoun': request.pronoun,
      'gender': request.genderId,
      'orientation': request.sexualOrientationId,
      'profilePhoto': request.profilePhoto,
    };
  }
}
