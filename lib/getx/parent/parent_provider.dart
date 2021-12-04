import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart' as dio;
const DEFAULT_TIMEOUT_SEC = 10;
enum ViewState {
  busy,
  idle
}
class ParentProvider with ChangeNotifier{
  ViewState _state = ViewState.idle;
  ViewState get state => _state;

  setStateBusy() async {
    _state = ViewState.busy;
    Future.delayed(Duration(seconds: DEFAULT_TIMEOUT_SEC), (){
      _state = ViewState.idle;
      notifyListeners();
    });
    notifyListeners();
  }
  setStateIdle(){
    _state = ViewState.idle;
    notifyListeners();
  }

  bool isSuccess(int responseCode){
    return responseCode != null && 200 <= responseCode && responseCode < 300;
  }

  dynamic throwException(dio.Response response){
    setStateIdle();
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.data.toString());
        print(responseJson);
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