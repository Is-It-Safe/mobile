// ignore_for_file: public_member_api_docs, sort_constructors_first
class ResponseDeleteUser {
  DateTime? timestamp;
  int? status;
  String? error;
  String? message;
  String? path;

  ResponseDeleteUser(
      {this.timestamp, this.status, this.error, this.message, this.path});

  ResponseDeleteUser.fromJson(Map<String, dynamic> json) {
    timestamp = json['timestamp'];
    status = json['status'];
    error = json['error'];
    message = json['message'];
    path = json['path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['timestamp'] = this.timestamp;
    data['status'] = this.status;
    data['error'] = this.error;
    data['message'] = this.message;
    data['path'] = this.path;
    return data;
  }
}
