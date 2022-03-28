import 'dart:developer' as dev;

///O [Log] é uma classe responsável por gerenciar e armazenar variádos
///tipos de métodos de log.
class Log {
  ///Método responsável por emitir o log de uma rota.
  static void route(String text) => dev.log(text, name: "ROUTE");

  ///Método responsável por emitir um log de erro.
  static void error(String text) => dev.log(text, name: "ERROR");

  ///Método responsável por emitir um log de request.
  static void request(String text) => dev.log(text, name: "REQUEST");

  ///Método responsável por emitir um log de response.
  static void response(String text) => dev.log(text, name: "RESPONSE");

  ///Método responsável por emitir um log de response error.
  static void responseError(String text) =>
      dev.log(text, name: "RESPONSE ERROR");

  ///Método responsável por emitir um log customozável.
  static void log(String text, {required String name}) =>
      dev.log(text, name: name);
}
