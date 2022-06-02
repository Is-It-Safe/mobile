class RequestRegister {
  String? photoUrl;
  String? name;
  String? birthDate;
  String? nickname;
  String? email;
  String? password;
  String? pronoun;
  int? genderId;
  int? sexualOrientationId;

  RequestRegister(
      {this.photoUrl,
      this.name,
      this.birthDate,
      this.nickname,
      this.email,
      this.password,
      this.pronoun,
      this.genderId,
      this.sexualOrientationId});

  Map<String, dynamic> toJson(RequestRegister request) {
    return {
      'photo_url': request.photoUrl,
      'name': request.name,
      'birth_date': request.birthDate,
      'nickname': request.nickname,
      'email': request.email,
      'password': request.password,
      'pronoun': request.pronoun,
      'gender_id': request.genderId,
      'orientation_id': request.sexualOrientationId,
    };
  }
}
