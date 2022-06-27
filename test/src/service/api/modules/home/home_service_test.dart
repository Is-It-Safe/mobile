import 'package:is_it_safe_app/src/service/api/modules/home/home_service_interface.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../safe_test.dart';

void main() {
  HomeServiceTest().runTests();
}

class MockHomeService extends Mock implements IHomeService {}

class HomeServiceTest extends SafeTest {
  late MockHomeService _homeService;

  HomeServiceTest() {
    _homeService = MockHomeService();
  }

  @override
  void runTests() {
    safeGroup(
      description: 'HomeService',
      body: () {
        _getBestRatedLocations();
      },
    );
  }

  void _getBestRatedLocations() {}
}
