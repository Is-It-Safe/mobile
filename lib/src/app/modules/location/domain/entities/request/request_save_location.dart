import 'package:dio/dio.dart';

class RequestSaveLocation {
  String? name;
  String? cep;
  int? locationTypeId;
  String? imgUrl;
  

  RequestSaveLocation({
    this.name,
    this.cep,
    this.locationTypeId,
    this.imgUrl,
  });

  RequestSaveLocation.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    cep = json['cep'];
    locationTypeId = json['locationTypeId'];
    imgUrl = json['file'];
  }

  FormData toFormData(RequestSaveLocation request) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['cep'] = cep;
    data['locationTypeId'] = locationTypeId;
    if (imgUrl != null) {
      data['file'] = MultipartFile.fromFileSync(imgUrl!);
    }
    return FormData.fromMap(data);
  }
}
