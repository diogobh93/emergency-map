typedef JSON = Map<String, dynamic>;

typedef Failure = ({
  Object? exception,
  Object? errorData,
  String? message,
  int? statusCode,
});

typedef Success = ({
  JSON? data,
  int? statusCode,
});

class HttpStatus {
  final Success? success;
  final Failure? failure;

  HttpStatus({
    this.success,
    this.failure,
  });
}
