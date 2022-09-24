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
    const callUri = "/api/v1/social/access";
    final response = await _apiService.post(callUri, {"accessToken" : code, "socialType": socialType});
    Log.info("$callUri :: -> $response");
    if(response is ApiResponseDto){
      return response;
    }
    await Util.setSharedString(KEY_TOKEN, response);
    getProfile();
    return null;
  }

  Future<dynamic> getProfile() async {
    const callUri = "/api/v1/getProfile";
    final response = await _apiService.get(callUri);
    Log.info(response);
    users = Users.fromMap(response);
    update();
  }
}