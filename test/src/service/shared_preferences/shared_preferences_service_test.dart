import 'package:flutter_test/flutter_test.dart';
import 'package:is_it_safe_app/src/service/shared_preferences/shared_preferences_service_interface.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesServiceMock extends Mock
    implements ISharedPreferencesService {}

main() {
  setUpAll(() {
    SharedPreferences.setMockInitialValues({
      'test-bool': false,
      'test-string': "is-it-safe",
      'test-int': 1,
      'test-double': 3.3,
      'test-stringed-list': [],
    });
  });

  test(
      'Testa se a operação de atualizar e resgatar valores `bool` está funcionando.',
      () async {
    final prefs = await SharedPreferences.getInstance();

    expect(prefs.getBool('test-bool'), false); // Valor antigo

    expect(await prefs.setBool('test-bool', true), true);

    expect(prefs.getBool('test-bool'), true); // Valor novo
  });
  test(
      'Testa se a operação de atualizar e resgatar valores `String` está funcionando.',
      () async {
    final prefs = await SharedPreferences.getInstance();

    expect(prefs.getString('test-string'), "is-it-safe"); // Valor antigo

    expect(await prefs.setString('test-string', "Is It Safe?"), true);

    expect(prefs.getString('test-string'), "Is It Safe?"); // Valor novo
  });

  test(
      'Testa se a operação de atualizar e resgatar valores `int` está funcionando.',
      () async {
    final prefs = await SharedPreferences.getInstance();

    expect(prefs.getInt('test-int'), 1); // Valor antigo

    expect(await prefs.setInt('test-int', 33), true);

    expect(prefs.getInt('test-int'), 33); // Valor novo
  });
  test(
      'Testa se a operação de atualizar e resgatar valores `double` está funcionando.',
      () async {
    final prefs = await SharedPreferences.getInstance();

    expect(prefs.getDouble('test-double'), 3.3); // Valor antigo

    expect(await prefs.setDouble('test-double', 4.2), true);

    expect(prefs.getDouble('test-double'), 4.2); // Valor novo
  });
  test(
      'Testa se a operação de atualizar e resgatar valores `List<String>` está funcionando.',
      () async {
    final prefs = await SharedPreferences.getInstance();

    expect(prefs.get('test-stringed-list'), []); // Valor antigo

    expect(
        await prefs.setStringList('test-stringed-list', ['1', '2', '3']), true);

    expect(prefs.get('test-stringed-list'), ['1', '2', '3']); // Valor novo
  });
}
