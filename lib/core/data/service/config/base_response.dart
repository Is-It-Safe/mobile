class BaseResponse<T> {
  Status status;
  T? data;
  String? message;

  BaseResponse.loading() : status = Status.LOADING;

  BaseResponse.completed({required this.data}) : status = Status.COMPLETED;

  BaseResponse.error(this.message) : status = Status.ERROR;

  @override
  String toString() {
    return "Status : $status \n Message : $message \n Data : $data";
  }
}

enum Status { LOADING, COMPLETED, ERROR }
