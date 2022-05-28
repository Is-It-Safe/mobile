import 'package:flutter_modular/flutter_modular.dart';

abstract class SafeBloC implements Disposable {
  Future<void> init();
  @override
  Future<void> dispose();
}
