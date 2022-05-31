import 'package:logger/logger.dart';

///A classe [LogUtil] é responsável por gerenciar os métodos de log utilizados no projeto.
///Sua utilização deve-se fazer a instanciação da classe e utilizar o método escolhido.
///**Exemplo:**
/// ```dart
/// LogUtil().route(Modular.to.path);
/// ```
class LogUtil {
  late final Logger logger;

  LogUtil() {
    logger = Logger(
      printer: PrettyPrinter(
        methodCount: 0,
        errorMethodCount: 20,
      ),
    );
    PrettyPrinter.levelColors[Level.debug] = AnsiColor.fg(10);
  }

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
  void request({
    String? http,
    String? path,
    String? body,
    String? header,
  }) {
    String log = '''
    -----------------------> REQUEST <------------------------\n
    HTTP: $http\n
    PATH: $path\n
    HEADER: $header\n
    BODY: $body\n
    ----------------------------------------------------------
    ''';

    logger.d(log);
  }

  ///Método de log de response
  void response({
    int? statusCode,
    String? path,
    String? params,
    String? body,
    String? header,
    bool? isError,
  }) {
    String log = '''
    -----------------------> RESPONSE <-----------------------\n
    Status Code: $statusCode\n
    Header: $header\n
    Path: $path\n
    Request: $params\n
    Body: $body\n
    ----------------------------------------------------------
    ''';
    if (isError == true) {
      logger.e(log);
    } else {
      logger.d(log);
    }
  }
}
