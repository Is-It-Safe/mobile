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
}
