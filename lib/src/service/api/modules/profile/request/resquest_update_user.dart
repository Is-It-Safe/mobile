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
