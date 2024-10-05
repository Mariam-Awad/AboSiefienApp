import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';

import '../shared_prefrence/app_shared_prefrence.dart';
import 'api_endpoints.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => false;
  }
}

class DioHelper {
  static late Dio dio;

  static String api = Endpoints.TEST_BASE_URL;

  static void initialize() {
    dio = Dio(
      BaseOptions(
        headers: <String, dynamic>{
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
        receiveDataWhenStatusError: true,
        validateStatus: (int? state) => state! < 500,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        contentType: 'application/json',
      ),
    );
    dio.interceptors.addAll(
      [
        InterceptorsWrapper(
            onRequest:
                (RequestOptions options, RequestInterceptorHandler handler) =>
                    onRequestHandler(options, handler)),
        LogInterceptor(
          responseBody: true,
          error: true,
          requestBody: true,
          requestHeader: true,
        ),
      ],
    );
  }

  static void onRequestHandler(
      RequestOptions req, RequestInterceptorHandler handler) async {
    log("from onRequestHandler");
    final token =
        AppSharedPreferences.getString(SharedPreferencesKeys.accessToken);
    log(token.toString() + " token");
    if (token != null && token.isNotEmpty) {
      req.headers['Authorization'] = " $token";
    }
    req.headers['Content-Type'] = 'application/json';
    handler.next(req);
  }

  Future<dynamic> postDataWithoutToken(String parameter, dynamic data) async {
    final response = await dio.post('$api/$parameter',
        data: data,
        options: Options(
          contentType: "application/json-patch+json",
          validateStatus: (state) => state! < 500,
        ));
    return handleResponse(response);
  }

  Future<dynamic> postData(String parameter, dynamic data,
      {Options? options}) async {
    final response = await dio.post("${api + parameter}",
        data: data,
        options: options ??
            Options(
              contentType: 'application/json',
              method: 'POST',
              validateStatus: (state) => state! < 500,
            ));
    return handleResponse(response);
  }

  Future<dynamic> postDataWithOtherBaseUrl(String parameter,
      {dynamic data, Options? options}) async {
    final response = await dio.post('$parameter',
        data: data,
        options: options ??
            Options(
              contentType: 'application/json',
              method: 'POST',
              validateStatus: (state) => state! < 500,
            ));
    return handleResponse(response);
  }

  Future<dynamic> patchData(String parameter, dynamic data,
      {Options? options}) async {
    final response = await dio.patch('$api$parameter',
        data: data,
        options: options ??
            Options(
              contentType: 'application/json',
              method: 'PATCH',
              validateStatus: (state) => state! < 500,
            ));
    return handleResponse(response);
  }

  Future<dynamic> refreshTokenApi(
    String parameter,
    dynamic data,
  ) async {
    log('$api$parameter');
    final response = await Dio().post('$api$parameter',
        options: Options(
          contentType: 'application/json',
          method: 'POST',
          headers: data,
          validateStatus: (state) => state! < 500,
        ));
    return handleResponse(response);
  }

  Future<dynamic> postWithParameters(
    String path,
    String parameter,
  ) async {
    log('$api/$path?$parameter');
    final response = await dio.post('$api+$path?$parameter',
        options: Options(
          contentType: 'application/json',
          method: 'POST',
          validateStatus: (state) => state! < 500,
        ));
    return handleResponse(response);
  }

  Future<dynamic> putData(
    String parameter,
    Map<String, dynamic> data,
  ) async {
    log('$api$parameter');
    log(data.toString());
    final response = await dio.put("${api + parameter}",
        data: json.encoder.convert(data),
        options: Options(
          contentType: 'application/json',
          method: 'PUT',
          validateStatus: (state) => state! < 500,
        ));
    return handleResponse(response);
  }

  Future<dynamic> delData(String parameter,
      {Map<String, dynamic>? data}) async {
    final response = await dio.delete('$api$parameter',
        data: data,
        options: Options(
          contentType: 'application/json',
          method: 'DEL',
          validateStatus: (state) => state! < 500,
        ));
    return handleResponse(response);
  }

  Future<dynamic> getData({
    required String endPont,
    String? token,
    bool? isVersion1,
  }) async {
    final response = await dio.get(
      "${api + endPont}",
      options: Options(
        headers: <String, dynamic>{
          'Authorization': ' $token',
        },
      ),
    );
    return handleResponse(response);
  }

  Future<dynamic> getDataWithoutBaseurl({
    required String url,
    String? token,
    bool? isVersion1,
  }) async {
    final response = await dio.get(
      "$url",
      options: Options(
        headers: <String, dynamic>{
          'Authorization': ' $token',
        },
      ),
    );
    return handleResponse(response);
  }

  Future<dynamic> getDataWithQuery(
      {required String endPont,
      required Map<String, dynamic> query,
      String? token}) async {
    log('$api/$endPont');
    log(query.toString());
    final response = await dio.get(
      '$api$endPont',
      queryParameters: query,
      options: Options(
        headers: <String, dynamic>{
          'Authorization': ' $token',
        },
      ),
    );
    return handleResponse(response);
  }

  Future<dynamic> uploadFiles({
    required String url,
    required List<File> files,
    required String keyImage,
    required String? key2,
    required dynamic val2,
    required String? key3,
    required dynamic val3,
    String? key4,
    List<dynamic>? val4,
    String? token,
  }) async {
    dio.options.headers = <String, dynamic>{
      'Content-Type': 'multipart/form-data',
      'Accept': '*/*',
      'language': 'en',
      'Authorization': ' $token',
    };
    log(url);

    List<MultipartFile> uploadList = <MultipartFile>[];
    for (File file in files) {
      MultipartFile multipartFile = await MultipartFile.fromFile(file.path);
      uploadList.add(multipartFile);
    }

    FormData formData = FormData.fromMap(<String, dynamic>{
      keyImage: uploadList,
      if (key2 != null) key2: val2,
      if (key3 != null) key3: val3,
      if (key4 != null) key4: val4,
    });

    final response = await dio.post(
      "$api$url",
      data: formData,
      options: Options(
        followRedirects: false,
        validateStatus: (int? state) => state! < 500,
      ),
    );

    return handleResponse(response);
  }

  dynamic handleResponse(Response response) {
    if (response.statusCode.toString()[0] != "2") {
      throw DioError(
        response: response,
        requestOptions: response.requestOptions,
        type: DioErrorType.badResponse,
      );
    }
    return response.data;
  }
}
