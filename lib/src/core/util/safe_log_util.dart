import 'package:flutter/foundation.dart';
import 'package:is_it_safe_app/src/core/constants/string_constants.dart';
import 'package:logger/logger.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

enum SafeLogType { info, request, response, error, warning }

///A classe [SafeLogUtil] é responsável por gerenciar os métodos de log utilizados no projeto.
///Sua utilização deve-se fazer a instanciação da classe e utilizar o método escolhido.
///**Exemplo:**
/// ```dart
/// SafeLogUtil.instance.route(Modular.to.path);
/// ```
class SafeLogUtil {
  static SafeLogUtil instance = SafeLogUtil._();

  late Logger logger;
  late Logger printLogger;

  SafeLogUtil._() {
    logger = Logger(
      printer: PrettyPrinter(
        methodCount: 20,
        errorMethodCount: 20,
      ),
    );
    printLogger = Logger(
      printer: PrettyPrinter(
        methodCount: 0,
      ),
    );
  }

  void route(String route) => printLogger.i('ROUTE: ${route..trim()}');

  void logError(
    dynamic error, {
    StackTrace? stackTrace,
    String? message,
  }) {
    final err = error is Error ? error : null;
    stackTrace ??= err?.stackTrace ?? StackTrace.current;

    final frames = stackTrace.toString().split('\n');
    final classAndMethod = getClassAndMethodName(runtimeType);

    frames.removeWhere((e) => e.contains(classAndMethod) || e.isEmpty);
    final stackTraceString = StackTrace.fromString(frames.join('\n'));

    final date = DateFormat('dd/MM/yyyy HH:mm:ss').format(DateTime.now());
    final log = '$date: ${message.toString()}';

    logger.e(
      error,
      log,
      stackTraceString,
    );
  }

  String getClassAndMethodName(Type? runtimeType) {
    if (runtimeType == null) return StringConstants.empty;

    final stack = StackTrace.current.toString().split('\n').firstWhere(
          (e) => e.contains(runtimeType.toString()),
        );
    final classAndMethod = stack.split(' ').firstWhere(
          (e) => e.contains(runtimeType.toString()),
        );
    return classAndMethod.replaceAll('.<anonymous', StringConstants.empty);
  }

  void printLog(
    dynamic message, {
    SafeLogType type = SafeLogType.info,
  }) {
    final date = DateFormat('HH:mm:ss').format(DateTime.now());
    final log = '$date $message';
    if (kDebugMode) {
      if (type == SafeLogType.request ||
          type == SafeLogType.response ||
          type == SafeLogType.warning) {
        printLogger.w(log);
      } else if (type == SafeLogType.error) {
        printLogger.e(log);
      } else {
        printLogger.i(log);
      }
    }
  }

  void onRequestLog({
    String? http,
    String? path,
    String? body,
    String? header,
  }) {
    printLog(
      '\n-----------------------> REQUEST <------------------------\n'
      'HTTP: $http\n'
      'PATH: $path\n'
      'HEADER: $header\n'
      'BODY: $body\n'
      '----------------------------------------------------------',
      type: SafeLogType.request,
    );
  }

  void onResponseLog({
    int? statusCode,
    String? path,
    String? params,
    String? body,
    String? header,
    bool isError = false,
  }) {
    printLog(
      '\n---------------------> RESPONSE <-----------------------\n'
      'STATUS CODE: $statusCode\n'
      'PATH: $path\n'
      'HEADER: $header\n'
      'REQUEST: $params\n'
      'BODY: $body\n'
      '----------------------------------------------------------',
      type: isError ? SafeLogType.error : SafeLogType.request,
    );
  }

  void log({
    required String title,
    required String message,
    SafeLogType type = SafeLogType.info,
  }) {
    printLog(
      '${title.toUpperCase()}: $message',
      type: type,
    );
  }
}
