import 'package:flutter/material.dart';
import 'package:my_n_life/utils/style/custom_color.dart';
import 'package:my_n_life/utils/style/custom_text_style.dart';
import 'package:my_n_life/utils/style/size_config.dart';

class SelectLifePage extends StatefulWidget {
  const SelectLifePage({Key? key}) : super(key: key);

  @override
  _SelectLifePageState createState() => _SelectLifePageState();
}

class _SelectLifePageState extends State<SelectLifePage> {
  bool loadingDone = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<void> getLifeList() async {

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: SizeConfig.safeAreaTop! + 20, left: 20, right: 20),
          child: Column(
            children: [
              Text("새로운 나의 라이프를 시작해볼까요?", style: CustomTextStyle.createTextStyle(fontSize: 15, color: CustomColor.black, fontWeight: FontWeight.w700),)
            ],
          ),
        ),
      ),
    );
  }
}
