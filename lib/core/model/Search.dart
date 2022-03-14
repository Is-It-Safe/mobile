//TODO Nomear melhor a classe, o retorno do endpoint não é esse...
//TODO Essa classe me parece muito com o objeto de Location
//TODO Estruturar melhor a classe e implementar os métodos toJson e fromJson
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
