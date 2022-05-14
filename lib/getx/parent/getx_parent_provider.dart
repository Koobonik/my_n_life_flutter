import 'dart:convert';

import 'package:dio/dio.dart' as dio;
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

const DEFAULT_TIMEOUT_SEC = 5;
enum ViewState {
  Busy,
  Idle
}

class GetXParentProvider extends GetxController{
  ViewState _state = ViewState.Idle;
  ViewState get state => _state;

  setStateBusy() async {
    _state = ViewState.Busy;
    Future.delayed(const Duration(seconds: DEFAULT_TIMEOUT_SEC), (){
      _state = ViewState.Idle;
      update();
    });
    update();
  }
  setStateIdle(){
    _state = ViewState.Idle;
    update();
  }
  dynamic throwException(dio.Response response){
    setStateIdle();
    switch (response.statusCode) {
      case 200:
        var responseJson = jsonDecode(response.data.toString());
        if (kDebugMode) {
          print(responseJson);
        }
        return responseJson;
      case 400:
        throw BadRequestException(response.data.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.data.toString());
      case 500:
      default:
        throw FetchDataException('Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
class AppException implements Exception {
  final _message;
  final _prefix;

  AppException([this._message, this._prefix]);

  @override
  String toString() {
    return "$_prefix$_message";
  }
}

class FetchDataException extends AppException {
  FetchDataException([String? message])
      : super(message, "Error During Communication: ");
}

class BadRequestException extends AppException {
  BadRequestException([message]) : super(message, "Invalid Request: ");
}

class UnauthorisedException extends AppException {
  UnauthorisedException([message]) : super(message, "Unauthorised: ");
}

class InvalidInputException extends AppException {
  InvalidInputException([String? message]) : super(message, "Invalid Input: ");

}
