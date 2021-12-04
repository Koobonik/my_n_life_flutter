import 'dart:convert';
import 'package:dio/dio.dart' as dio;
import 'package:my_n_life/getx/utils/log.dart';
import 'package:my_n_life/getx/utils/util.dart';
import 'const_library.dart';
import 'package:flutter/foundation.dart';
import 'parent_provider.dart';


class ApiService {
  dio.Dio dioObject = dio.Dio();
  Future<dynamic> query(dynamic data) async {
    Map map = {"query" : data};
    // 토큰이 null 이라면 빈 문자열 넣어줌.
    final token = await Util.getSharedString(KEY_TOKEN) ?? '';
    dioObject.options.headers = {"authorization": "Bearer $token"};
    try{
      final response = await dioObject.post('$hostUrl', data: map).timeout(Duration(seconds: 10));
      print("api_service : ${response.data}");
      return _response(response);
    }on dio.DioError catch (e){
      Log.error(e.response);
      // return _nestResponse(e.response);
    }
  }

  Future<dynamic> get(String _path, {dynamic queryParameters}) async {
    // 토큰이 null 이라면 빈 문자열 넣어줌.
    final token = await Util.getSharedString(KEY_TOKEN) ?? '';
    dioObject.options.headers = {"authorization": "Bearer $token"};
    try{
      final response = await dioObject.get('${Uri.encodeFull('$nestPaymentHostUrl$_path')}', queryParameters: queryParameters).timeout(Duration(seconds: 10));
      print("api_get $_path : ${response.data}");
      return _nestResponse(response);
    } on dio.DioError catch (e){
      return _nestResponse(e.response!);
    }
  }

  Future<dynamic> post(String _path, dynamic data) async {
    // 토큰이 null 이라면 빈 문자열 넣어줌.
    final token = await Util.getSharedString(KEY_TOKEN) ?? '';
    dioObject.options.headers = {"authorization": "Bearer $token"};
    final map = (data is Map ? data : data?.toMap()) ?? {};
    String _body = json.encode(map);
    try{
      final response = await dioObject.post('${Uri.encodeFull('$nestPaymentHostUrl$_path')}', data: _body).timeout(Duration(seconds: 10));
      print("api_post $_path : ${response.data}");
      return _nestResponse(response);
    } on dio.DioError catch (e){
      return _nestResponse(e.response!);
    }
  }

  Future<dynamic> put(String _path, dynamic data) async {
    // 토큰이 null 이라면 빈 문자열 넣어줌.
    final token = await Util.getSharedString(KEY_TOKEN) ?? '';
    dioObject.options.headers = {"authorization": "Bearer $token"};
    final map = (data is Map ? data : data?.toMap()) ?? {};
    String _body = json.encode(map);
    try{
      final response = await dioObject.put('${Uri.encodeFull('$nestPaymentHostUrl$_path')}', data: _body).timeout(Duration(seconds: 10));
      print("api_put $_path : ${response.data}");
      return _nestResponse(response);
    } on dio.DioError catch (e){
      return _nestResponse(e.response!);
    }
  }

  Future<dynamic> patch(String _path, dynamic data) async {
    // 토큰이 null 이라면 빈 문자열 넣어줌.
    final token = await Util.getSharedString(KEY_TOKEN) ?? '';
    dioObject.options.headers = {"authorization": "Bearer $token"};
    final map = (data is Map ? data : data?.toMap()) ?? {};
    String _body = json.encode(map);
    try{
      final response = await dioObject.patch('${Uri.encodeFull('$nestPaymentHostUrl$_path')}', data: _body).timeout(Duration(seconds: 10));
      print("api_patch $_path : ${response.data}");
      return _nestResponse(response);
    } on dio.DioError catch (e){
      return _nestResponse(e.response!);
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
    dioObject.options.headers = {"authorization": "Bearer $token"};
    final map = (data is Map ? data : data?.toMap()) ?? {};
    String _body = json.encode(map);
    final response = await dioObject.delete('${Uri.encodeFull('$nestPaymentHostUrl$_path')}', data: _body).timeout(Duration(seconds: 10));
    print("api_delete $_path : ${response.data}");
    return _nestResponse(response);
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
  dynamic _nestResponse(dio.Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        try{
          if(response.data["data"] != null)
            return response.data["data"];
          else
            return response.data;
        }catch(e){
          Log.error(e);
          return response.data;
        }
        break;
      case 400:
        return NestResponse.fromMap(json.decode(jsonEncode(response.data)));
      case 401:
      case 403:
        return NestResponse.fromMap(json.decode(jsonEncode(response.data)));
      case 409:
        var responseJson = json.decode(response.data.toString());
        return responseJson;
      case 422:
        return NestResponse.fromMap(json.decode(jsonEncode(response.data)));
      case 500:
        return NestResponse.fromMap(json.decode(jsonEncode(response.data)));

      default:
        return NestResponse.fromMap(json.decode(jsonEncode(response.data)));
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

class NestResponse{
  String message;
  String errorMessage;

  NestResponse({required this.message, required this.errorMessage});

  @override
  String toString() {
    return 'NestResponse{message: $message, errorMessage: $errorMessage}';
  }

  Map<String, dynamic> toMap() {
    return {
      'message': message,
      'errorMessage': errorMessage,
    };
  }

  factory NestResponse.fromMap(dynamic map) {
    return NestResponse(
      message: map['message'].toString(),
      errorMessage: map['errorMessage'].toString(),
    );
  }
}
const releaseHost = 'https://api.playinstudio.com/query';
String debugHost = 'https://api.playinstudio.com/query';

bool adminTestMode = false;
String get hostUrl {
  if (adminTestMode) return debugHost;
  if (kReleaseMode) return releaseHost;
  return debugHost;
}

const chatBotHost = "http://27.96.135.168:5100";


const releaseNestPaymentHost = 'https://payments.pingpong.house';
String debugNestPaymentHost = 'https://payments.pingpong.house';
String get nestPaymentHostUrl {
  if (adminTestMode) return debugNestPaymentHost;
  if (kReleaseMode) return releaseNestPaymentHost;
  return debugNestPaymentHost;
}