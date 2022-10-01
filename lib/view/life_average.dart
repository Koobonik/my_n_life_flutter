import 'package:flutter/material.dart';
import 'package:my_n_life/getx/model/hobby.dart';
import 'package:my_n_life/utils/style/custom_text_style.dart';

class LifeAveragePage extends StatefulWidget {
  Hobby hobby;
  LifeAveragePage(this.hobby, {Key? key}) : super(key: key);

  @override
  _LifeAveragePageState createState() => _LifeAveragePageState();
}

class _LifeAveragePageState extends State<LifeAveragePage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Center(child: Text("${widget.hobby.name} 취미에 대한 평균 입문 비용을 계산해볼게요...", style: CustomTextStyle.createTextStyle(fontSize: 16, fontWeight: FontWeight.w700),)),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
