import 'package:flutter_modular/flutter_modular.dart';
import 'package:modular_test/modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:is_it_safe_app/app/modules/onBoarding/on_boarding_module.dart';

void main() {
  setUpAll(() {
    initModule(OnBoardingModule());
  });
}
