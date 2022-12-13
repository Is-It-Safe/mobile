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

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'nickname': nickname,
      'pronoun': pronoun,
      'gender_id': genderId,
      'orientation_id': sexualOrientationId,
      'photoUrl': profilePhoto,
    };
  }
}
