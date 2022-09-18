import 'package:my_n_life/getx/parent/api_service.dart';
import 'package:my_n_life/getx/parent/getx_parent_controller.dart';
import 'package:my_n_life/utils/log.dart';

class UsersGetXController extends GetXParentController{
  final _apiService = ApiService();
  Future<dynamic> accessSocial({required String code, required String socialType}) async {
    const callUri = "/api/v1/social/access";
    final response = await _apiService.post(callUri, {"accessToken" : code, "socialType": socialType});
    Log.info("$callUri :: -> $response");
    // if(response is DefaultResponse){
    //   return response;
    // }
    // else if(response is NestResponse){
    //   return response;
    // }
    // return SignUpResponseDto.fromMap(response);
  }
}