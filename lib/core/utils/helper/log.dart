import 'dart:developer' as dev;

class Log {
  static void route(String text) => dev.log(text, name: "ROUTE");

  static void error(String text) => dev.log(text, name: "ERROR");

  static void request(String text) => dev.log(text, name: "REQUEST");
  static void response(String text) => dev.log(text, name: "RESPONSE");
  static void responseError(String text) =>
      dev.log(text, name: "RESPONSE ERROR");

  static void log(String text, {required String name}) =>
      dev.log(text, name: name);
}
