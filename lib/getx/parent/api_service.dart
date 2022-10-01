import 'dart:convert';
import 'package:dio/dio.dart' as dio;
import 'package:my_n_life/getx/parent/getx_parent_controller.dart';
import 'package:my_n_life/utils/log.dart';
import 'package:my_n_life/utils/util.dart';
import 'const_library.dart';
import 'package:flutter/foundation.dart';

const releaseHost = 'https://seedosee.com';
// String debugHost = 'http://192.168.0.5:8080';
String debugHost = 'http://172.30.1.13:8080';

bool adminTestMode = false;
String get hostUrl {
  if (adminTestMode) return debugHost;
  if (kReleaseMode) return releaseHost;
  return debugHost;
}

class ApiService {
  dio.Dio dioObject = dio.Dio();
  Future<dynamic> query(dynamic data) async {
    Map map = {"query" : data};
    // 토큰이 null 이라면 빈 문자열 넣어줌.
    final token = await Util.getSharedString(KEY_TOKEN) ?? '';
    dioObject.options.headers = {"authorization": token};
    try{
      final response = await dioObject.post(hostUrl, data: map).timeout(const Duration(seconds: 10));

      return _response(response);
    }on dio.DioError catch (e){
      Log.error(e.response);
      // return _nestResponse(e.response);
    }
  }

  Future<dynamic> get(String _path, {dynamic queryParameters}) async {
    // 토큰이 null 이라면 빈 문자열 넣어줌.
    final token = await Util.getSharedString(KEY_TOKEN) ?? '';
    dioObject.options.headers = {"authorization": token};
    try{
      final response = await dioObject.get(Uri.encodeFull('$hostUrl$_path'), queryParameters: queryParameters).timeout(const Duration(seconds: 10));
      if (kDebugMode) {
        print("api_get $_path : ${response.data}");
      }
      return _apiResponse(response);
    } on dio.DioError catch (e){
      return _apiResponse(e.response!);
    }
  }

  Future<dynamic> post(String _path, dynamic data, {bool justReturnResponse = false}) async {
    // 토큰이 null 이라면 빈 문자열 넣어줌.
    final token = await Util.getSharedString(KEY_TOKEN) ?? '';
    dioObject.options.headers = {"authorization": token};
    final map = (data is Map ? data : data?.toMap()) ?? {};
    String _body = json.encode(map);
    try{
      final response = await dioObject.post(Uri.encodeFull('$hostUrl$_path'), data: _body).timeout(const Duration(seconds: 10));
      print("api_post $_path : ${response.data}");
      if(justReturnResponse) return response;
      return _apiResponse(response);
    } on dio.DioError catch (e){
      Log.error(e);
      return _apiResponse(e.response!);
    }
  }

  Future<dynamic> put(String _path, dynamic data) async {
    // 토큰이 null 이라면 빈 문자열 넣어줌.
    final token = await Util.getSharedString(KEY_TOKEN) ?? '';
    dioObject.options.headers = {"authorization": token};
    final map = (data is Map ? data : data?.toMap()) ?? {};
    String _body = json.encode(map);
    try{
      final response = await dioObject.put(Uri.encodeFull('$hostUrl$_path'), data: _body).timeout(const Duration(seconds: 10));
      if (kDebugMode) {
        print("api_put $_path : ${response.data}");
      }
      return _apiResponse(response);
    } on dio.DioError catch (e){
      return _apiResponse(e.response!);
    }
  }

  Future<dynamic> patch(String _path, dynamic data) async {
    // 토큰이 null 이라면 빈 문자열 넣어줌.
    final token = await Util.getSharedString(KEY_TOKEN) ?? '';
    dioObject.options.headers = {"authorization": token};
    final map = (data is Map ? data : data?.toMap()) ?? {};
    String _body = json.encode(map);
    try{
      final response = await dioObject.patch(Uri.encodeFull('$hostUrl$_path'), data: _body).timeout(const Duration(seconds: 10));
      if (kDebugMode) {
        print("api_patch $_path : ${response.data}");
      }
      return _apiResponse(response);
    } on dio.DioError catch (e){
      return _apiResponse(e.response!);
      // if (e.response.statusCode == 401) {
      //   Log.info(e.response.data);
      //   Log.warning(e.response.headers);
      //   Log.wtf(e.response.requestOptions);
      //   return _nestResponse(e.response);
      // } else {
      //   // Something happened in setting up or sending the request that triggered an Error
      //   print(e.requestOptions);
      //   print(e.message);
      // }
    }
  }

  Future<dynamic> delete(String _path, dynamic data) async {
    // 토큰이 null 이라면 빈 문자열 넣어줌.
    final token = await Util.getSharedString(KEY_TOKEN) ?? '';
    dioObject.options.headers = {"authorization": token};
    final map = (data is Map ? data : data?.toMap()) ?? {};
    String _body = json.encode(map);
    final response = await dioObject.delete(Uri.encodeFull('$hostUrl$_path'), data: _body).timeout(const Duration(seconds: 10));
    if (kDebugMode) {
      print("api_delete $_path : ${response.data}");
    }
    return _apiResponse(response);
  }

  dynamic _response(dio.Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        return response.data;
      case 400:
        throw BadRequestException(json.decode(response.data)['message']);
      case 401:
      case 403:
        throw UnauthorisedException(json.decode(response.data)['message']);
      case 409:
        var responseJson = json.decode(response.data.toString());
        return responseJson;
      case 422:
        return response.data;
      case 500:

      default:
        throw FetchDataException(json.decode(response.data)['message']);
    }
  }

  // nest에 대한 리스폰스 핸들링 해주는 곳
  dynamic _apiResponse(dio.Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        Log.info("response data -> ${response.data}");
        if(response.data == null){
          return null;
        }
        try{
          if(response.data["data"] != null) {
            return response.data["data"];
          } else {
            return response.data;
          }
        }catch(e){
          Log.error(e);
          return response.data;
        }
        break;
      case 400:
        return ApiResponseDto.fromMap(json.decode(jsonEncode(response.data)));
      case 401:
      case 403:
        return ApiResponseDto.fromMap(json.decode(jsonEncode(response.data)));
      case 409:
        var responseJson = json.decode(response.data.toString());
        return responseJson;
      case 422:
        return ApiResponseDto.fromMap(json.decode(jsonEncode(response.data)));
      case 500:
        Log.error(response.data);
        try{
          return ApiResponseDto.fromMap(json.decode(jsonEncode(response.data)));
        }catch(e){
          return null;
        }

      default:
        return ApiResponseDto.fromMap(json.decode(jsonEncode(response.data)));
    }
  }

  Future<dynamic> chatBotSendQuery(String url) async {
    try{
      final response = await dio.Dio().get(url);
      return json.decode(response.data);
    } on dio.DioError catch (e){
      Log.error(e);
    }
  }
}

class ApiResponseDto{
  int code;
  String message;

//<editor-fold desc="Data Methods">

  ApiResponseDto({
    required this.code,
    required this.message,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ApiResponseDto &&
          runtimeType == other.runtimeType &&
          code == other.code &&
          message == other.message);

  @override
  int get hashCode => code.hashCode ^ message.hashCode;

  @override
  String toString() {
    return 'ApiResponseDto{' + ' code: $code,' + ' message: $message,' + '}';
  }

  ApiResponseDto copyWith({
    int? code,
    String? message,
  }) {
    return ApiResponseDto(
      code: code ?? this.code,
      message: message ?? this.message,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'code': code,
      'message': message,
    };
  }

  factory ApiResponseDto.fromMap(Map<String, dynamic> map) {
    return ApiResponseDto(
      code: map['code'] as int,
      message: map['message'] as String,
    );
  }

//</editor-fold>
}