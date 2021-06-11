
import 'package:dio/dio.dart' hide Headers;

class ServerError implements Exception {
  int? _errorCode;
  String? _errorMessage = "";
  DioErrorType? _type;

  ServerError.withError({DioError? error}) {
    _handleError(error);
  }

  getErrorCode() {
    return _errorCode;
  }

  getErrorMessage() {
    return _errorMessage;
  }

  getType(){
    return _type;
  }
  _handleError(DioError? error) {
    if(error==null)
      return "no error";
    switch (error.type) {
      case DioErrorType.cancel:
        _errorMessage = "Request was cancelled";
        break;
      case DioErrorType.connectTimeout:
        _errorMessage = "Connection timeout";
        break;
      case DioErrorType.other:
        // Default error type, Some other Error. In this case, you can
    /// use the DioError.error if it is not null.
        _errorMessage =
        "Connection failed due to internet connection";
        break;
      case DioErrorType.receiveTimeout:
        _errorMessage = "Receive timeout in connection";
        break;
      case DioErrorType.response:
        _errorMessage =
        "Received invalid status code: ${error.response!.statusCode}";
        _errorCode = error.response!.statusCode;
        break;
      case DioErrorType.sendTimeout:
        _errorMessage = "Receive timeout in send request";
        break;
    }
    _type= error.type;
    return _errorMessage;
  }
}
class BaseModel<T> {
  ServerError? _error;
  T? data;

  setException(ServerError error) {
    _error = error;
  }

  setData(T? data) {
    this.data = data;
  }

  ServerError? get getException {
    return _error;
  }
}