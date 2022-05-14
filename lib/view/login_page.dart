import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:my_n_life/utils/log.dart';
import 'package:my_n_life/utils/style/custom_button.dart';
import 'package:my_n_life/utils/style/custom_color.dart';
import 'package:my_n_life/utils/style/custom_text_style.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text("나의 N 라이프\n로그인해서 시작하기"),
              const SizedBox(height: 20,),
              CustomButton.bottomButton(
                  text: Padding(
                    padding: const EdgeInsets.only(left :14.0, right: 14),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset("assets/icons/social/kakao_image.png", height: 24,),
                        Text("Kakao 로그인", style: CustomTextStyle.createTextStyle(fontSize: 13, color: CustomColor.black, fontWeight: FontWeight.w700),),
                        Image.asset("assets/icons/social/kakao_image.png", color: Colors.transparent, height: 24),
                      ],
                    ),
                  ),
                  backgroundColor: CustomColor.kakao_yellow,
                  press: () async {
                    // KakaoContext.appVer
                    print("safdsa");
                    try {
                      // AccessTokenInfo tokenInfo =
                      // await UserApi.instance.accessTokenInfo();
                      // print('토큰 유효성 체크 성공 ${tokenInfo.id} ${tokenInfo.expiresIn}');
                      var code = await isKakaoTalkInstalled() ? await UserApi.instance.loginWithKakaoTalk() : await UserApi.instance.loginWithKakaoAccount();
                      // var code = await AuthCodeClient.instance.requestWithTalk();
                      Log.info("code -> $code");
                      try {

                        // var token = await AuthApi.instance.issueAccessToken(authCode: code.accessToken);
                        // Log.info("token -> $token");
                        final user = await UserApi.instance.me();
                        Log.info("user -> $user");

                        // final result = await UserApi.instance.loginWithKakaoTalk();
                        // Log.info("result -> $result");
                        // AccessTokenStore.instance.toStore(token);
                        // final kakaoUrl = Uri.parse('[토큰 전달할 URL]');

                      } catch (error) {
                        if (kDebugMode) {
                          print(error.toString());
                        }
                      }
                    } catch (error) {
                      if (kDebugMode) {
                        print(error.toString());
                      }
                    }
                  }
              ),
            ],
          ),
        ),
      ),
    );
  }
}
