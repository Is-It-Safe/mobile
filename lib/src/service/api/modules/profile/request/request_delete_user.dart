class RequestDeleteUser {
  int? id;

  RequestDeleteUser({
    this.id,
  });

  Map<String, dynamic> toJson(RequestDeleteUser request) {
    return {"id": id};
  }
}
