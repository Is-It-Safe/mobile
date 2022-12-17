import 'package:dio/dio.dart';

class RequestAddLocation {
  String? name;
  String? cep;
  int? locationTypeId;
  String? file;

  RequestAddLocation({
    this.name,
    this.cep,
    this.locationTypeId,
    this.file,
  });

  RequestAddLocation.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    cep = json['cep'];
    locationTypeId = json['locationTypeId'];
    file = json['file'];
  }

  FormData toFormData(RequestAddLocation request) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['cep'] = cep;
    data['locationTypeId'] = locationTypeId;
    if (file != null) {
      data['file'] = MultipartFile.fromFileSync(file!);
    } else {
      data['file'] = null;
    }
    return FormData.fromMap(data);
  }
}
