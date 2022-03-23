import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:is_it_safe_app/core/data/service/config/base_response.dart';
import 'package:is_it_safe_app/core/data/service/contact_service.dart';

class ContactBloc implements Disposable {
  final ContactService _service = ContactService();
  late StreamController<BaseResponse<bool>> sendFeedbackController;
  final FocusNode focusNode = FocusNode();
  TextEditingController message = TextEditingController();

  ContactBloc() {
    sendFeedbackController = StreamController.broadcast();
  }

  Future<dynamic> sendFeedback(String message) async {
    try {
      sendFeedbackController.sink.add(BaseResponse.loading());
      var response = await _service.postFeedback(feedback: message);
      sendFeedbackController.sink.add(BaseResponse.completed(data: response));
    } catch (e) {
      sendFeedbackController.sink.add(BaseResponse.error(e.toString()));
    }
  }

  @override
  void dispose() {
    sendFeedbackController.close();
  }
}