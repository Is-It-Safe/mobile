import 'package:flutter_modular/flutter_modular.dart';

abstract class SafeBloC implements Disposable {
  @override
  Future<void> dispose();

  Future<void> init();
}
