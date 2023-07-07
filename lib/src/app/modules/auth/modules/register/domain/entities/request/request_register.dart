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
      'photoUrl': photoUrl,
      'name': name,
      'birthDate': birthDate,
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
      photoUrl: map['photoUrl'],
      name: map['name'],
      birthDate: map['birthDate'],
      nickname: map['nickname'],
      email: map['email'],
      password: map['password'],
      pronoun: map['pronoun'],
      genderId: int.tryParse(map['gender_id']),
      sexualOrientationId: int.tryParse(map['orientation_id']),
    );
  }

  String toJson() => json.encode(toMap());

  factory RequestRegister.fromJson(String source) =>
      RequestRegister.fromMap(json.decode(source));
}
