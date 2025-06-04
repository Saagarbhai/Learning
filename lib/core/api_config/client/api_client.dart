import 'package:dio/dio.dart';
import 'package:learning/core/utils/app_export.dart'
    hide Response, MultipartFile;

enum RequestType { GET, POST, PUT, DELETE, PATCH, MULTIPART_POST }

class ApiClient {
  final Dio _dio;

  ApiClient()
      : _dio = Dio(BaseOptions(headers: {'Content-Type': 'application/json'}))
          ..interceptors.add(
            PrettyDioLogger(
              requestHeader: true,
              requestBody: true,
              responseHeader: true,
              responseBody: true,
              request: true,
              error: true,
              compact: true,
              maxWidth: 90,
            ),
          ) {
    _initializeHeaders();
  }

  Future<void> _initializeHeaders() async {
    final headers = await _buildHeaders();
    _dio.options.headers = headers;
  }

  // --------------------------- HEADERS ---------------------------

  static Map<String, String> _buildHeaders() {
    final header = <String, String>{'Content-Type': 'application/json'};
    String? deviceToken = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...';

    if (deviceToken.isNotEmpty) {
      header['Authorization'] = '$deviceToken';
    }
    return header;
  }

  // --------------------------- REQUEST METHOD ---------------------------

  Future<Map<String, dynamic>> request(
    RequestType type,
    String path, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? multipartData,
  }) async {
    try {
      final Response response = switch (type) {
        RequestType.GET => await _dio.get(path),
        RequestType.POST => await _dio.post(path, data: data),
        RequestType.PUT => await _dio.put(path, data: data),
        RequestType.DELETE => await _dio.delete(path),
        RequestType.PATCH => await _dio.patch(path, data: data),
        RequestType.MULTIPART_POST =>
          await _dio.post(path, data: await _buildMultipartForm(multipartData)),
      };

      return _handleSuccess(response);
    } on DioException catch (error) {
      return _handleDioError(error);
    } catch (e) {
      rethrow;
    }
  }

  // --------------------------- SUCCESS HANDLERS ---------------------------

  Map<String, dynamic> _handleSuccess(Response response) {
    if ([200, 201, 204].contains(response.statusCode)) {
      return response.data;
    } else {
      throw _handleFailure(response);
    }
  }

  // --------------------------- ERROR HANDLERS ---------------------------

  DioException _handleFailure(Response response) {
    final code = response.statusCode ?? 0;
    final responseData = response.data;
    String message = "Something went wrong";
    // Improved validation error handling to support multiple formats
    if (responseData is Map<String, dynamic>) {
      // Format 1: Direct validationErrors array
      if (responseData.containsKey('validationErrors') &&
          responseData['validationErrors'] is List) {
        final List errors = responseData['validationErrors'];
        if (errors.isNotEmpty) {
          // Extract all error messages and join them
          message =
              errors.map((e) => e['message']).where((m) => m != null).join('');
          if (message.isEmpty) {
            message = "Validation error occurred";
          }
        }
      }
      // Fallback to standard message fields
      else if (responseData.containsKey('message')) {
        message = responseData['message'];
      } else if (responseData.containsKey('title')) {
        message = responseData['title'];
      }
    }

    // Toast messages based on status code
    if ([400, 401, 403, 422, 500].contains(code)) {
      AppToast.show(message: message, type: ToastificationType.error);
    } else if ([404, 409].contains(code)) {
      AppToast.show(message: message, type: ToastificationType.warning);
    } else if ([429, 503].contains(code)) {
      AppToast.show(message: message, type: ToastificationType.info);
    } else {
      AppToast.show(message: message, type: ToastificationType.error);
    }

    return DioException(
      requestOptions: response.requestOptions,
      response: response,
      type: DioExceptionType.badResponse,
    );
  }

  Map<String, dynamic> _handleDioError(DioException error) {
    if (error.response != null) {
      throw _handleFailure(error.response!);
    } else {
      final message =
          error.message ?? "Network error. Please check your connection.";
      AppToast.show(message: message, type: ToastificationType.error);
      throw DioException(
          requestOptions: error.requestOptions,
          error: error.error,
          type: DioExceptionType.unknown);
    }
  }

  // --------------------------- MULTIPART FORM BUILDER ---------------------------

  Future<FormData> _buildMultipartForm(Map<String, dynamic>? data) async {
    final formData = FormData();

    if (data == null || data.isEmpty) return formData;

    for (final entry in data.entries) {
      final key = entry.key;
      final value = entry.value;

      if (value is List && value.isNotEmpty && value.first is String) {
        for (final path in value) {
          formData.files.add(MapEntry(key, await MultipartFile.fromFile(path)));
        }
      } else {
        formData.fields.add(MapEntry(key, value.toString()));
      }
    }

    return formData;
  }
}
