import 'dart:async';

import 'package:flutter_modular/flutter_modular.dart';

class RegisterBloc implements Disposable {
  late StreamController<bool> registerButtonController;

  RegisterBloc() {
    registerButtonController = StreamController.broadcast();
  }

  @override
  void dispose() {}
}
