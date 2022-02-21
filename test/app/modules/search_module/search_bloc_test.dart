import 'package:flutter_test/flutter_test.dart';
import 'package:is_it_safe_app/app/modules/main_module/modules/search_module/search_bloc.dart';
import 'package:is_it_safe_app/core/data/service/search_service.dart';

main() {
  final repository = Search();

  final controller = SearchController();

  test('Deve preencher as variavies', () async {
    await controller.start();
    expect(controller.searchs.isNotEmpty, true);
  });
}
