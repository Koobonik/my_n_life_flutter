import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:my_n_life/getx/controller/hobby_getx_controller.dart';
import 'package:my_n_life/getx/model/hobby.dart';
import 'package:my_n_life/utils/log.dart';
import 'package:my_n_life/utils/style/custom_text_style.dart';
import 'package:my_n_life/utils/util.dart';

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
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Center(child: Text("${widget.hobby.name} 취미에 대한 평균 입문 비용을 계산해볼게요...", style: CustomTextStyle.createTextStyle(fontSize: 16, fontWeight: FontWeight.w700),)),

                const SizedBox(height: 20,),
                if(data.isNotEmpty) Column(
                  children: List.generate(data.length, (index) =>
                      Column(
                        children: data[index].entries.map((e) => Text("${e.key} : ${e.value}")).toList(),
                      )),
                ),
                GridView.builder(
                  itemCount: data.length, //item 개수
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, //1 개의 행에 보여줄 item 개수
                    // childAspectRatio: 1/1, //item 의 가로 1, 세로 2 의 비율
                    mainAxisSpacing: 5, //수평 Padding
                    crossAxisSpacing: 5, //수직 Padding
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    //item 의 반목문 항목 형성
                    return GestureDetector(
                      onTap: (){
                      },
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.blue)
                            ),
                            alignment: Alignment.center,
                            margin: const EdgeInsets.only(top: 4),
                            child: Column(
                              children: data[index].entries.map((e) => Text("${e.key} : ${Util.getMoneyFormat(e.value)}원")).toList(),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
