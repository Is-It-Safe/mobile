import 'package:logger/logger.dart';

///A classe [LogUtil] é responsável por gerenciar os métodos de log utilizados no projeto.
///Sua utilização deve-se fazer a instanciação da classe e utilizar o método escolhido.
///**Exemplo:**
/// ```dart
/// LogUtil().route(Modular.to.path);
/// ```
class LogUtil {
  final logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 3,
      lineLength: 50,
      colors: true,
      printEmojis: true,
      printTime: false,
    ),
  );

  ///Método de log default
  void log({
    required String title,
    required String message,
    required Level level,
  }) =>
      logger.log(level, '$title: $message');

  ///Método de log de rota
  void route(String route) => logger.i('ROUTE: $route');

  ///Método de log de erro
  void error(String error, {String? title}) {
    title ??= 'ERROR';
    logger.e('$title: $error');
  }

  ///Método de log de request
  void request(String request) => logger.d('REQUEST: $request');

  ///Método de log de response
  void response(
    String response, {
    bool? isError,
  }) {
    if (isError == true) {
      logger.e('RESPONSE ERROR: $response');
    } else {
      logger.d('RESPONSE: $response');
    }
  }
}
