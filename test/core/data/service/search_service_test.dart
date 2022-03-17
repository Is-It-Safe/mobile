import 'package:flutter_test/flutter_test.dart';
import 'package:is_it_safe_app/core/data/service/search_service.dart';

void main() {
  test('Testando se não retorna vázio após realizar a busca por Restaurante na API', () async {
    final service = SearchService();
    final result = await service.getLocation("Restaurante");
    expect(result, isNotEmpty);
  });
}
