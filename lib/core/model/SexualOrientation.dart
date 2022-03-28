class SexualOrientation {
  late int id;
  late String title;

  SexualOrientation({required this.id, required this.title});

  SexualOrientation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['title'] = title;
    return data;
  }
}
