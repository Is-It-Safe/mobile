class ResponseUpdateUser {
  int? id;
  String? name;
  String? nickname;
  String? pronoun;
  int? genderId;
  int? sexualOrientationId;
  String? profilePhoto;

  ResponseUpdateUser({
    this.id,
    this.name,
    this.nickname,
    this.pronoun,
    this.genderId,
    this.sexualOrientationId,
    this.profilePhoto,
  });

  factory ResponseUpdateUser.fromJson(dynamic json) {
    return ResponseUpdateUser(
      id: json['id'],
      name: json['name'],
      nickname: json['nickname'],
      pronoun: json['pronoun'],
      genderId: json['genderId'],
      sexualOrientationId: json['sexualOrientationId'],
      profilePhoto: json['profilePhoto'],
    );
  }
}
