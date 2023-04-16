class ResponseRegister {
  String? message;

  ResponseRegister({this.message});

  factory ResponseRegister.fromJson(dynamic json) {
    return ResponseRegister(
      message: json['message'],
    );
  }
}
