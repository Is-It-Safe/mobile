import 'dart:convert';
import 'package:is_it_safe_app/core/data/service/config/api_service.dart';

class ContactService {
  final APIService _service = APIService();

  Future<dynamic> postFeedback({required String feedback}) async {
    final _response = await _service.doRequest(
      RequestConfig(
        'contact',
        HttpMethod.post,
        body: jsonEncode({
          'feedback': feedback
        })
      ),
    );

    return _response;
  }
}