import 'package:is_it_safe_app/src/service/api/modules/search/search_service_interface.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../safe_test.dart';

void main() {
  SearchServiceTest().runTests();
}

class MockSearchService extends Mock implements ISearchService {}

class SearchServiceTest extends SafeTest {
  late MockSearchService _searchService;

  SearchServiceTest() {
    _searchService = MockSearchService();
  }

  @override
  void runTests() {
    safeGroup(
      description: 'SearchService',
      body: () {
        _getLocationsByName();
      },
    );
  }

  void _getLocationsByName() {}
}
