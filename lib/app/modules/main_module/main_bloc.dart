import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class MainBloc implements Disposable {
  final pageViewController = PageController();

  @override
  void dispose() {
    pageViewController.dispose();
  }
}
