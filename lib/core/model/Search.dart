class SearchModel {
  late int id;
  late String name;
  late String endereco;
  String? imgUrl;

  SearchModel({
    required this.id,
    required this.name,
    required this.endereco,
    this.imgUrl,
  });

  SearchModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    endereco = json['endereco'];
    imgUrl = json['imgUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['endereco'] = endereco;
    data['imgUrl'] = imgUrl;
    return data;
  }
}
