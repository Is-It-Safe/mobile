import 'dart:convert';

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

  Map<String, dynamic> toMap() {
    return {
      'photo_url': photoUrl,
      'name': name,
      'birth_date': birthDate,
      'nickname': nickname,
      'email': email,
      'password': password,
      'pronoun': pronoun,
      'gender_id': genderId,
      'orientation_id': sexualOrientationId,
    };
  }

  factory RequestRegister.fromMap(Map<String, dynamic> map) {
    return RequestRegister(
      photoUrl: map['photo_url'],
      name: map['name'],
      birthDate: map['birth_date'],
      nickname: map['nickname'],
      email: map['email'],
      password: map['password'],
      pronoun: map['pronoun'],
      genderId: map['gender_id']?.toInt(),
      sexualOrientationId: map['orientation_id']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory RequestRegister.fromJson(String source) =>
      RequestRegister.fromMap(json.decode(source));
}
