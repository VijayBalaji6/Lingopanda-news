import 'package:dio/dio.dart';
import 'package:lingoganda_news/constants/api_constants.dart';
import 'package:lingoganda_news/utils/api_utils/api_exception_handler.dart';

class ApiCoreService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: ApiConstants.baseUrl,
    connectTimeout: const Duration(seconds: 15),
    receiveTimeout: const Duration(seconds: 15),
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
  ));

  Future<Response> get(String url, {Map<String, dynamic>? params}) async {
    try {
      params ??= {};

      params['apiKey'] = ApiConstants.apiKey;

      final response = await _dio.get(url, queryParameters: params);
      return _handleResponse(response);
    } catch (error) {
      _handleError(error);
      rethrow;
    }
  }

  Future<Response> post(String url, {dynamic data}) async {
    try {
      final response = await _dio.post(url, data: data);
      return _handleResponse(response);
    } catch (error) {
      _handleError(error);
      rethrow;
    }
  }

  Future<Response> put(String url, {dynamic data}) async {
    try {
      final response = await _dio.put(url, data: data);
      return _handleResponse(response);
    } catch (error) {
      _handleError(error);
      rethrow;
    }
  }

  Future<Response> delete(String url, {dynamic data}) async {
    try {
      final response = await _dio.delete(url, data: data);
      return _handleResponse(response);
    } catch (error) {
      _handleError(error);
      rethrow;
    }
  }

  static Response _handleResponse(Response response) {
    switch (response.statusCode) {
      case 200:
        return response;
      case 400:
        throw BadRequestException(response.data);
      case 401:
        throw UnAuthorizedException(response.data);
      case 403:
        throw AuthenticationException(message: response.data);
      case 404:
        throw NotFoundException(response.data);
      case 409:
        throw ConflictException(message: response.data);
      case 422:
        throw UnprocessableEntityException(message: response.data);
      case 500:
        throw FetchDataException("Internal Server Error");
      case 503:
        throw ServiceUnavailableException("Service Unavailable");
      default:
        throw DefaultException("Unexpected Error: ${response.statusCode}");
    }
  }

  static _handleError(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.receiveTimeout:
          throw TimeoutException("Request timed out");
        case DioExceptionType.cancel:
          throw RequestCanceledException("Request was cancelled");
        case DioExceptionType.unknown:
          if (error.message != null &&
              error.message!.contains("SocketException")) {
            throw NoInternetException("No Internet Connection");
          }
          throw DefaultException(error.message);
        case DioExceptionType.sendTimeout:
          throw DefaultException("Request was cancelled");
        case DioExceptionType.badCertificate:
          throw DefaultException("Request was cancelled");
        case DioExceptionType.badResponse:
          throw DefaultException("Request was cancelled");
        case DioExceptionType.connectionError:
          throw DefaultException("Request was cancelled");
      }
    } else {
      throw DefaultException(error.toString());
    }
  }
}
