import 'package:dio/dio.dart';
import 'package:my_n_life/getx/model/users.dart';
import 'package:my_n_life/getx/parent/api_service.dart';
import 'package:my_n_life/getx/parent/const_library.dart';
import 'package:my_n_life/getx/parent/getx_parent_controller.dart';
import 'package:my_n_life/utils/log.dart';
import 'package:my_n_life/utils/util.dart';

class UsersGetXController extends GetXParentController{
  final _apiService = ApiService();

  Users? users;

  Future<dynamic> accessSocial({required String code, required String socialType}) async {
    const callUri = "/api/users/social/access";
    final response = await _apiService.post(callUri, {"accessToken" : code, "socialType": socialType}, justReturnResponse: true);
    Log.info("$callUri :: -> $response");
    Log.info("$callUri :: -> ${response.runtimeType}");
    if(response is ApiResponseDto){
      return response;
    }
    bool isSignup = false;
    if(response is Response){
      Log.error("하이");
      if(response.statusCode == 201){
        await Util.setSharedString(KEY_TOKEN, response.data);
        isSignup = true;
      }
      else if(response.statusCode == 200){
        await Util.setSharedString(KEY_TOKEN, response.data);
      }
    }
    await getProfile();
    return isSignup;
  }

  Future<dynamic> getProfile() async {
    const callUri = "/api/users/getProfile";
    try{
      final response = await _apiService.get(callUri);
      Log.info(response);
      users = Users.fromMap(response);
      Log.info("users -> ${users.toString()}");
      update();
    }catch(e){
      update();
      Log.error(e);
      return null;
    }
  }

  Future<dynamic> createHobby(int hobbyId) async {
    final callUri = "/api/users/social/createNewHobbyAccount/$hobbyId";
    try{
      final response = await _apiService.post(callUri, {});
      Log.info(response);
      update();
    }catch(e){
      update();
      return null;
    }
  }

  Future<dynamic> updateUserData(Map map) async{
    const callUri = "/api/users/updateUserData";
    try{
      final response = await _apiService.patch(callUri, map);
      Log.info(response);
      update();
    }catch(e){
      update();
      return null;
    }
  }
}