import 'package:flutter_test/flutter_test.dart';
import 'package:meta/meta.dart';

enum SafeTestType {
  success,
  failure,
}

abstract class SafeTest {
  static const codeSuccess = 200;
  static const codeError = 404;

  @protected
  void registeListFallBack(List<dynamic> list) {
    setUpAll(() {
      for (final value in list) {
        registeListFallBack(value);
      }
    });
  }

  void runTests();

  @isTestGroup
  void safeGroup({
    required String description,
    required Function() body,
  }) {
    group(description, body);
  }

  @isTest
  void safeTest({
    required SafeTestType type,
    required String given,
    required String when,
    required String then,
    required Function() body,
  }) {
    assert(given.length > 10 && when.length > 10 && then.length > 10,
        'given, when, then devem possuir, ao menos, 10 characteres.');
    final description = '\n$given, \n$when, \n$then';
    test(description, body);
  }
}
