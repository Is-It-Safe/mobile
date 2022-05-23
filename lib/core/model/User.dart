class User {
  String? photoUrl;
  String? name;
  String? birthDate;
  String? nickname;
  String? email;
  String? password;
  String? pronoun;
  int? genderId;
  int? orientationId;

  User(
      {this.photoUrl,
      this.name,
      this.birthDate,
      this.nickname,
      this.email,
      this.password,
      this.pronoun,
      this.genderId,
      this.orientationId});

  User.fromJson(Map<String, dynamic> json) {
    photoUrl = json['photoUrl'];
    name = json['name'];
    birthDate = json['birthDate'];
    nickname = json['nickname'];
    email = json['email'];
    password = json['password'];
    pronoun = json['pronoun'];
    genderId = json['gender_id'];
    orientationId = json['orientation_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['photoUrl'] = photoUrl;
    data['name'] = name;
    data['birthDate'] = birthDate;
    data['nickname'] = nickname;
    data['email'] = email;
    data['password'] = password;
    data['pronoun'] = pronoun;
    data['gender_id'] = genderId;
    data['orientation_id'] = orientationId;
    return data;
  }
}
