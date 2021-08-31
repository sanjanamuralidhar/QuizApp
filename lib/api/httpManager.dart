import 'package:dio/dio.dart';

String dioErrorHandle(DioError error) {
  print(
      '......................dioerror...........................UtilError$error');
  switch (error.type) {
    case DioErrorType.RESPONSE:
      return error.response?.data['message'].toString() ?? 'Unknown error';

    case DioErrorType.SEND_TIMEOUT:
    case DioErrorType.RECEIVE_TIMEOUT:
      return "request_time_out";

    default:
      return "connect_to_server_fail";
  }
}

class HTTPManager {
  BaseOptions baseOptions = BaseOptions(
    baseUrl: "http://www.listar.passionui.com/index.php/wp-json",
    connectTimeout: 30000,
    receiveTimeout: 30000,
    headers: {},
    contentType: Headers.jsonContentType,
    responseType: ResponseType.json,
  );

  ///Get method
  Future<dynamic> get({
    String url,
    Map<String, dynamic> params,
    Options options,
  }) async {
    Dio dio = new Dio(baseOptions);
    try {
      final response = await dio.get(
        url,
        queryParameters: params,
        options: options,
      );
      return response.data;
    } on DioError catch (error) {
      return {"message": dioErrorHandle(error)};
    }
  }

  factory HTTPManager() {
    return HTTPManager._internal();
  }

  HTTPManager._internal();
}

HTTPManager httpManager = HTTPManager();
