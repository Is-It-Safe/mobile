import 'package:flutter_test/flutter_test.dart';
import 'package:is_it_safe_app/core/data/service/register/register_contract.dart';
import 'package:is_it_safe_app/core/data/service/search/search_contract.dart';
import 'package:is_it_safe_app/core/data/service/search/search_service.dart';
import 'package:mockito/annotations.dart';

import 'search_service_test.mocks.dart';

@GenerateMocks([RegisterContract],
    customMocks: [MockSpec<SearchContract>(returnNullOnMissingStub: true)])
void main() {
  group('search', () {
    const String fakeSearchTarget = 'Vila laura';
    late MockSearchContract searchContract;

    setUp(() {
      searchContract = MockSearchContract();
    });

    test(
        'Testando se não retorna vázio após realizar a busca por Restaurante na API',
        () async {
      final service = SearchService();
      final result = await service.getLocation("Restaurante");
      expect(result, isNotEmpty);
    });
  });
}
