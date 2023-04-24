class ResponseGender {
  int? id;
  String? title;

  ResponseGender({this.id, this.title});

  factory ResponseGender.fromJson(dynamic json) {
    return ResponseGender(
      id: json['id'],
      title: json['title'],
    );
  }
}
