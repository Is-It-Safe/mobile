class ResponseAddLocation {
  String? name;
  String? cep;
  int? locationTypeId;
  String? imgUrl;

  ResponseAddLocation({
    this.name,
    this.cep,
    this.locationTypeId,
    this.imgUrl,
  });

  ResponseAddLocation.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    cep = json['cep'];
    locationTypeId = json['locationTypeId'];
    imgUrl = json['imgUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['cep'] = cep;
    data['locationTypeId'] = locationTypeId;
    data['imgUrl'] = imgUrl;
    return data;
  }
}
