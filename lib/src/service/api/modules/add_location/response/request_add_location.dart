class RequestAddLocation {
  String? name;
  String? cep;
  int? locationTypeId;
  String? imgUrl;

  RequestAddLocation({
    this.name,
    this.cep,
    this.locationTypeId,
    this.imgUrl,
  });

  RequestAddLocation.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    cep = json['cep'];
    locationTypeId = json['locationTypeId'];
    imgUrl = json['file'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['cep'] = cep;
    data['locationTypeId'] = locationTypeId;
    data['file'] = imgUrl;
    return data;
  }
}
