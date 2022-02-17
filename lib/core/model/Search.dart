class SearchClass {
  late int id;
  late String name;
  late String endereco;
  String? imgUrl;

  SearchClass({
    required this.id,
    required this.name,
    required this.endereco,
    this.imgUrl,
  });

  SearchClass.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    endereco = json['endereco'];
    imgUrl = json['imgUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['endereco'] = this.endereco;
    data['imgUrl'] = this.imgUrl;
    return data;
  }
}
