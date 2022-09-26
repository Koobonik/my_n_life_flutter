import 'package:dio/dio.dart';
import 'package:my_n_life/getx/model/hobby.dart';
import 'package:my_n_life/getx/model/users.dart';
import 'package:my_n_life/getx/parent/api_service.dart';
import 'package:my_n_life/getx/parent/const_library.dart';
import 'package:my_n_life/getx/parent/getx_parent_controller.dart';
import 'package:my_n_life/utils/log.dart';
import 'package:my_n_life/utils/util.dart';

class HobbyGetXController extends GetXParentController{
  final _apiService = ApiService();

  Users? users;

  Future<dynamic> getAllHobby() async {
    const callUri = "/api/hobby/getAllHobby";
    final response = await _apiService.get(callUri);
    Log.info("$callUri :: -> $response");
    if (response is ApiResponseDto) {
      return response;
    }
    return response.map<Hobby>((map) => Hobby.fromMap(map)).toList();

  }
}