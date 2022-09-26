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
    getProfile();
    return isSignup;
  }

  Future<dynamic> getProfile() async {
    const callUri = "/api/users/getProfile";
    final response = await _apiService.get(callUri);
    Log.info(response);
    try{
      users = Users.fromMap(response);
      update();
    }catch(e){
      update();
      return null;
    }
  }
}