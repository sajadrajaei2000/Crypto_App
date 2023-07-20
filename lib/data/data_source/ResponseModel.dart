// ignore_for_file: constant_identifier_names

class ResponseModel<T> {
  late T data;
  late Status status;
  late String massege;
  ResponseModel.loading(this.massege) : status = Status.LOADING;
  ResponseModel.completed(this.data) : status = Status.COMPLETED;
  ResponseModel.error(this.massege) : status = Status.ERROR;
}

enum Status { LOADING, COMPLETED, ERROR }
