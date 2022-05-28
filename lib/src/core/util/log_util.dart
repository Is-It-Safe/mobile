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
      errorMethodCount: 0,
      lineLength: 120,
      colors: true,
      printEmojis: true,
      printTime: false,
      noBoxingByDefault: false,
      stackTraceBeginIndex: 0,
    ),
  );

  ///Método de log default
  void log({
    required String title,
    required String message,
    required Level level,
  }) {
    switch (level) {
      case Level.warning:
        logger.w('${title.toUpperCase()}: $message');
        break;
      case Level.debug:
        logger.d('${title.toUpperCase()}: $message');
        break;
      case Level.error:
        logger.e('${title.toUpperCase()}: $message');
        break;
      case Level.info:
        logger.i('${title.toUpperCase()}: $message');
        break;
      case Level.wtf:
        logger.wtf('${title.toUpperCase()}: $message');
        break;
      case Level.verbose:
        logger.v('${title.toUpperCase()}: $message');
        break;
      default:
        logger.log(level, '${title.toUpperCase()}: $message');
    }
  }

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
