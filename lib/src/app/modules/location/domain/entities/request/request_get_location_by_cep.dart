import 'package:dio/dio.dart';

class RequestGetLocationByCep {
  String? cep;

  RequestGetLocationByCep({
    this.cep,
  });

  RequestGetLocationByCep.fromJson(Map<String, dynamic> json) {
    cep = json['cep'];
  }

  FormData toFormData(RequestGetLocationByCep request) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cep'] = cep;
    return FormData.fromMap(data);
  }
}