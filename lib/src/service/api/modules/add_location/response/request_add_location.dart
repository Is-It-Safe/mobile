import 'package:dio/dio.dart';

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

  FormData toFormData() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['cep'] = cep;
    data['locationTypeId'] = locationTypeId;
    if (imgUrl != null) {
      data['file'] = MultipartFile.fromFileSync(imgUrl!);
    } else {
      data['file'] = null;
    }
    return FormData.fromMap(data);
  }
}
