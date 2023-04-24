class ResponseSexualOrientation {
  int? id;
  String? title;

  ResponseSexualOrientation({this.id, this.title});

  factory ResponseSexualOrientation.fromJson(dynamic json) {
    return ResponseSexualOrientation(
      id: json['id'],
      title: json['title'],
    );
  }
}
