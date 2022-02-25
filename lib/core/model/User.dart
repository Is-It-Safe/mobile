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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['photoUrl'] = this.photoUrl;
    data['name'] = this.name;
    data['birthDate'] = this.birthDate;
    data['nickname'] = this.nickname;
    data['email'] = this.email;
    data['password'] = this.password;
    data['pronoun'] = this.pronoun;
    data['gender_id'] = this.genderId;
    data['orientation_id'] = this.orientationId;
    return data;
  }
}
