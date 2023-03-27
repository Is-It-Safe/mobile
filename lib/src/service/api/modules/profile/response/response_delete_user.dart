class ResponseDeleteUser {
  DateTime? timestamp;
  int? status;
  String? error;
  String? message;
  String? path;

  ResponseDeleteUser({
    this.timestamp,
    this.status,
    this.error,
    this.message,
    this.path,
  });

  factory ResponseDeleteUser.fromJson(Map<String, dynamic> json) {
    return ResponseDeleteUser(
      timestamp: json["timestamp"],
      status: json['status'],
      error: json['error'],
      message: json['message'],
      path: json['path'],
    );
  }
}
