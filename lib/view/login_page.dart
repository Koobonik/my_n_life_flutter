import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:my_n_life/utils/log.dart';
import 'package:my_n_life/utils/style/custom_button.dart';
import 'package:my_n_life/utils/style/custom_color.dart';
import 'package:my_n_life/utils/style/custom_text_style.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
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
                    if (kDebugMode) {
                      print("카카오 설치 여부 -> ${await isKakaoTalkInstalled()}");
                    }
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
              const SizedBox(height: 20,),
              CustomButton.bottomButton(
                  text: Padding(
                    padding: const EdgeInsets.only(left :14.0, right: 14),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset("assets/icons/social/apple_image.png", height: 24,),
                        Text("Sign In with Apple", style: CustomTextStyle.createTextStyle(fontSize: 13, color: CustomColor.white, fontWeight: FontWeight.w700),),
                        Image.asset("assets/icons/social/apple_image.png", color: Colors.transparent, height: 24),
                      ],
                    ),
                  ),
                  backgroundColor: CustomColor.black,
                  press: (){
                    signInWithApple();
                  }
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> signInWithApple() async {
    final credential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );

    Log.info(credential);
    print(credential.givenName);
    print(credential.authorizationCode);
    print(credential.identityToken);
    Map<String, dynamic> payload = Jwt.parseJwt(credential.identityToken ?? '');
    print(payload);
    print(payload['email']);
    // SignInWithApple.getKeychainCredential().then((value) => Log.info("${value}"));

    print(credential.userIdentifier);
    SignInWithApple.getCredentialState(credential.userIdentifier ?? '').then((value) => Log.warning(value));

    // final signInResult = await userProvider.socialSignIn(socialSignInDto: SocialSignInRequestDto(token: credential.authorizationCode, platform: APPLE));
    // print(signInResult.runtimeType);
    // if(signInResult is NestResponse){
    //   final credential2 = await SignInWithApple.getAppleIDCredential(
    //     scopes: [
    //       AppleIDAuthorizationScopes.email,
    //       AppleIDAuthorizationScopes.fullName,
    //     ],
    //   );
    //   final response = await userProvider.socialSignUp(signUpDto: SocialSignUpRequestDto(token: credential2.authorizationCode, platform: APPLE, birthdate: "19000101",mobile: Uuid().v4().substring(0, 11), username: payload['email'].toString().split("@")[0], nickname: "No.${Uuid().v4().substring(0, 8)}", profileImageUrl: "", email: payload['email']));
    //   Log.warning(response);
    // }
    // else if(signInResult is DefaultResponse){
    //   if(signInResult.statusCode == 404){
    //     util.Util.showNegativeDialog4(context, "회원가입이 되어 있지 않습니다.", "가입을 위해 한번 더 인증을 해주시기 바랍니다.", "닫기", "인증", () { }, () async {
    //       final credential2 = await SignInWithApple.getAppleIDCredential(
    //         scopes: [
    //           AppleIDAuthorizationScopes.email,
    //           AppleIDAuthorizationScopes.fullName,
    //         ],
    //       );
    //       final response = await userProvider.socialSignUp(signUpDto: SocialSignUpRequestDto(token: credential2.authorizationCode, platform: APPLE, birthdate: "19000101",mobile: Uuid().v4().substring(0, 11), username: payload['email'].toString().split("@")[0], nickname: "No.${Uuid().v4().substring(0, 8)}", profileImageUrl: "", email: payload['email']));
    //       Log.info(signInResult.toString());
    //       Log.info(response.runtimeType);
    //       Log.info(response.toString());
    //       if(response is SocialSignUpResponseDto){
    //         air.Airbridge.event.send(air.SignUpEvent(user: air.User(id: userProvider.user.ID, email: userProvider.user.email),option: air.EventOption(action: "apple")));
    //         loginSuccess(socialSignUpResponseDto: response, socialLoginType: APPLE, isSignUp: true);
    //       }
    //     });
    //   }
    //
    // }
    // else if(signInResult is SocialSignUpResponseDto){
    //   Log.info(signInResult.toString());
    //   loginSuccess(socialSignUpResponseDto: signInResult, socialLoginType: APPLE);
    // }
  }
}
