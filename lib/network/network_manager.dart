import 'dart:convert';
import 'package:abosiefienapp/cache/app_cache.dart';
import 'package:abosiefienapp/model/mymakhdoms_model.dart';
import 'package:abosiefienapp/network/parser.dart';
import 'package:abosiefienapp/utils/app_debug_prints.dart';
import 'package:alice/alice.dart';
import 'package:dio/dio.dart';

class NetworkManager {
  static Alice? alice = Alice(
      showNotification: true, showInspectorOnShake: true, darkTheme: false);

  late Dio dio;
  CancelToken? cancelToken;

  Map<String, dynamic> headers = {
    "Accept": "application/json",
    "Content-Type": "application/json",
  };
  Map<String, dynamic> headersFile = {
    "Accept": "application/json",
    "Content-Type": "application/json",
  };

  NetworkManager({this.cancelToken}) {
    dio = Dio();
    dio.options = BaseOptions(headers: headers);
    dio.interceptors.add(LogInterceptor(
      requestBody: true,
      request: true,
      requestHeader: true,
      responseBody: true,
      responseHeader: false,
    ));
    if (alice != null) dio.interceptors.add(alice!.getDioInterceptor());
  }

  void _updateHeaders() {
    printError(AppCache.instance.getApiToken().toString());
    if (AppCache.instance.getApiToken() != null) {
      String? token = AppCache.instance.getApiToken();
      printDone('token is: $token');
      if (token != null) {
        headers['Authorization'] = "$token";
      }
    }
/*
    var lang = AppCache.instance.getLanguage();
    if (lang != null) {
      headers['Accept-Language'] = lang;
    }*/
  }

  Future<T?> get<T>(String url, {Map<String, dynamic>? params}) async {
    _updateHeaders();
    print(headers);
    if (params == null) params = {};
    print(params);

    Response response = await dio.get(url,
        queryParameters: params,
        cancelToken: cancelToken,
        options: Options(headers: headers));
    print(response.statusCode);
    print("*************");

    return parseResponse<T>(response);
  }

  Future<List<T>?> getList<T>(String url,
      {Map<String, dynamic>? params, bool? needToken}) async {
    if (needToken != null && needToken) _updateHeaders();
    if (params == null) params = {};

    Response response = await dio.get(url,
        queryParameters: params,
        cancelToken: cancelToken,
        options: Options(headers: headers));
    return parseListResponse<T>(response);
  }

  Future<T?> post<T>(String url, {Map<String, dynamic>? body}) async {
    _updateHeaders();
    if (body == null) body = {};
    print(body);

    var formData = json.encode(body);
    Response response = await dio.post(url,
        cancelToken: cancelToken,
        options: Options(headers: headers),
        data: formData);
    printDone('response.statusCode ${response.statusCode}');
    return parseResponse<T>(response);
  }

  Future<T?> put<T>(String url, {Map<String, dynamic>? body}) async {
    _updateHeaders();
    if (body == null) body = {};
    print(body);

    var formData = json.encode(body);
    Response response = await dio.put(url,
        cancelToken: cancelToken,
        options: Options(headers: headers),
        data: formData);
    printDone('response.statusCode ${response.runtimeType}');
    printWarning('IN Put $response');
    return parseResponse<T>(response);
  }

  Future<Response> postString(String url, String body) async {
    _updateHeaders();

    Response response = await dio.post(url,
        cancelToken: cancelToken,
        options: Options(headers: headers),
        data: body);

    return response;
  }

  Future<T?> patch<T>(String url, {Map<String, dynamic>? body}) async {
    _updateHeaders();
    if (body == null) body = {};

    Response response = await dio.patch(url,
        queryParameters: body,
        cancelToken: cancelToken,
        options: Options(headers: headers));

    return parseResponse<T>(response);
  }

  Future<T?> delete<T>(String url, {Map<String, dynamic>? params}) async {
    _updateHeaders();
    if (params == null) params = {};
//    print(params);

    Response response = await dio.delete(url,
        queryParameters: params,
        cancelToken: cancelToken,
        options: Options(headers: headers));

    return parseResponse<T>(response);
  }

  Future<T?> postFile<T>(String url, FormData formdata, String? data) async {
    _updateHeadersFile();
    if (formdata == null) formdata;
    var body = {
      "file": formdata,
      "national_id": data,
    };
    print(formdata);
    Response response = await dio.post(url,
        cancelToken: cancelToken,
        options: Options(headers: headersFile),
        data: formdata);

    return parseResponse<T>(response);
  }

  void _updateHeadersFile() {
    if (AppCache.instance.getApiToken() != null) {
      String? token = AppCache.instance.getApiToken()!;
      if (token != null) {
        headersFile['Authorization'] = "Bearer $token";
      }
    }
  }

  T? parseResponse<T>(Response response) {
    if (response.statusCode != 200) return null;
    var map;
    if (T == null || T == dynamic) {
      printDone('IN If Condition');
      return response.data;
    } else {
      map = response.data;
      print('MAP IS: $map');
    }

    return Parser.parse<T>(map);
  }

  List<T>? parseListResponse<T>(Response response) {
    if (response.statusCode != 200) return null;

    var map;
    if (T == null || T == dynamic) {
      return response.data;
    } else {
      map = response.data;
    }

    List<T> list = [];

    (map as List).forEach((m) {
      list.add(Parser.parse<T>(m));
    });

    return list;
  }
}
