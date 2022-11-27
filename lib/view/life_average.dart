import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:my_n_life/getx/controller/hobby_getx_controller.dart';
import 'package:my_n_life/getx/model/hobby.dart';
import 'package:my_n_life/utils/log.dart';
import 'package:my_n_life/utils/style/custom_button.dart';
import 'package:my_n_life/utils/style/custom_color.dart';
import 'package:my_n_life/utils/style/custom_text_style.dart';
import 'package:my_n_life/utils/util.dart';
import 'package:my_n_life/view/base_page.dart';

class LifeAveragePage extends StatefulWidget {
  Hobby hobby;
  LifeAveragePage(this.hobby, {Key? key}) : super(key: key);

  @override
  _LifeAveragePageState createState() => _LifeAveragePageState();
}

class _LifeAveragePageState extends State<LifeAveragePage> {

  List<Map> data = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    init();

  }
  init() async {
    final result = await HobbyGetXController().getOneHobbyCostDataList(id: widget.hobby.id);
    Log.info("Result -> $result");
    if(result is List<Map>){
      data = result;
      setState(() {

      });
    }
  }

  @override
  Widget build(BuildContext context) {
    print(widget.hobby);
    return Scaffold(
      body: Stack(
        children: [
          ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
              child: CachedNetworkImage(imageUrl: widget.hobby.mainImage, height: double.infinity, fit: BoxFit.cover,)),
          SingleChildScrollView(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Center(child: Text("${widget.hobby.name} 취미에 대한 평균 입문 비용을 계산해볼게요...", style: CustomTextStyle.createTextStyle(fontSize: 16, fontWeight: FontWeight.w700),)),
                    ),

                    const SizedBox(height: 20,),

                    Align(
                      alignment: Alignment.centerRight,
                      child: Text("옆으로 넘기면서 보기 >", style: CustomTextStyle.createTextStyle(fontSize: 11, fontWeight: FontWeight.w700),)
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 100,
                      child: PageView.builder(
                        // clipBehavior: Clip.none,
                        // allowImplicitScrolling: true,
                        itemCount: data.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index){
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: Colors.blue),
                              color: CustomColor.lightBlue.withOpacity(0.2)
                            ),
                            alignment: Alignment.center,
                            margin: const EdgeInsets.only(left: 20, right: 20),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                children: data[index].entries.map((e) => Text("${e.key} : ${Util.getMoneyFormat(e.value)}원", style: CustomTextStyle.createTextStyle(fontSize: 14, fontWeight: FontWeight.w700),)).toList(),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20),
        child: CustomButton.outlinedButton(child: SizedBox(
          width: double.infinity,
          child: Text("${widget.hobby.name} 시작하기!", style: CustomTextStyle.createTextStyle(fontSize: 14, fontWeight: FontWeight.w700), textAlign: TextAlign.center,),), backgroundColor: CustomColor.lightBlue, radius: 24, outlineColor: Colors.transparent, onPressed: () async {
          // 취미 계정을 서버에서 생성 해주어야 함.
          
            Navigator.of(context).push(MaterialPageRoute(builder: (_) => const BasePage()));
        }),
      ),
    );
  }
}
