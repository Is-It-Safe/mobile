/// A classe de [RegexConstants] é responsável por gerenciar as constantes de utilidades
class RegexConstants {
  static const Pattern emailRegex =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  static const Pattern passwordRegex =
      r'^(?=.*\d)(?=.*[\x21-\x2F\x3A-\x40\x5B-\x60\x7B-\x7E])[0-9a-zA-Z\x21-\x2F\x3A-\x40\x5B-\x60\x7B-\x7E]{8,}$';
  static const Pattern linkFromTextRegex =
      r'((https?:www\.)|(https?:\/\/)|(www\.))[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9]{1,6}(\/[-a-zA-Z0-9()@:%_\+.~#?&\/=]*)?';
  static const Pattern nameRegex =
      r'^[a-zA-ZÀ-ÖØ-öø-ÿÇç]{4,}(?:\s[a-zA-ZÀ-ÖØ-öø-ÿÇç]+)*$';
  static const Pattern nickNameRegex =
      r'^[a-zA-Z\d]{4,}$';
}
