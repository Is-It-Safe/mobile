import 'package:dio/dio.dart';

class RequestSaveLocation {
  String? name;
  String? cep;
  int? locationTypeId;
  String? imgUrl;
  String? address;

  RequestSaveLocation({
    this.name,
    this.cep,
    this.locationTypeId,
    this.imgUrl,
    this.address,
  });

  RequestSaveLocation.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    cep = json['cep'];
    locationTypeId = json['locationTypeId'];
    imgUrl = json['file'];
    address = json['address'];
  }

  FormData toFormData(RequestSaveLocation request) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['cep'] = cep;
    data['locationTypeId'] = locationTypeId;
    data['address'] = address;
    if (imgUrl != null) {
      data['file'] = MultipartFile.fromFileSync(imgUrl!);
    }
    return FormData.fromMap(data);
  }
}
