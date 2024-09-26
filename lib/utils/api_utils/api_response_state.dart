class ApiResponseState<T> {
  Status status;
  T? data;
  String? message;

  ApiResponseState.initial() : status = Status.initial;
  ApiResponseState.loading({this.message = 'Loading'})
      : status = Status.loading;
  ApiResponseState.completed(this.data) : status = Status.completed;
  ApiResponseState.error(this.message) : status = Status.error;

  @override
  String toString() {
    return "Status : $status \n Message : $message \n Data : $data";
  }
}

enum Status { initial, loading, completed, error }
