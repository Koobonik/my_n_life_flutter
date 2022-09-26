import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_n_life/getx/controller/hobby_getx_controller.dart';
import 'package:my_n_life/getx/model/hobby.dart';
import 'package:my_n_life/utils/log.dart';
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

  List<Hobby> hobbyList = [];
  Hobby? selectedHobby;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLifeList();
  }

  Future<void> getLifeList() async {
    final hobbyGetXController = Get.put(HobbyGetXController());
    final result = await hobbyGetXController.getAllHobby();
    Log.info("result -> $result");
    if(result is List<Hobby>){
      setState(() {
        hobbyList.addAll(result);
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("선택"),
        actions: [
          TextButton(
            onPressed: (){

            },
            child: Text("다음"),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: SizeConfig.safeAreaTop! + 20, left: 20, right: 20),
          child: Column(
            children: [
              Text("새로운 나의 라이프를 시작해볼까요?", style: CustomTextStyle.createTextStyle(fontSize: 15, color: CustomColor.black, fontWeight: FontWeight.w700),),
              const SizedBox(height: 20,),
              GridView.builder(
                itemCount: hobbyList.length, //item 개수
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, //1 개의 행에 보여줄 item 개수
                  // childAspectRatio: 1/1, //item 의 가로 1, 세로 2 의 비율
                  mainAxisSpacing: 5, //수평 Padding
                  crossAxisSpacing: 5, //수직 Padding
                ),
                itemBuilder: (BuildContext context, int index) {
                  //item 의 반목문 항목 형성
                  return GestureDetector(
                    onTap: (){
                      setState(() {
                        selectedHobby = hobbyList[index];
                      });
                    },
                    child: Column(
                      children: [
                        CachedNetworkImage(
                          imageUrl: hobbyList[index].mainImage,
                          imageBuilder: (context, imageProvider) => Container(
                            width: 90.0,
                            height: 90.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: selectedHobby == hobbyList[index] ? Border.all(color: Colors.greenAccent, width: 3) : null,
                              image: DecorationImage(
                                  image: imageProvider, fit: BoxFit.cover),
                            ),
                          ),
                          placeholder: (context, url) => const CircularProgressIndicator(),
                          errorWidget: (context, url, error) => const Icon(Icons.error),
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: Text(
                            hobbyList[index].name,
                            style: const TextStyle(
                              fontSize: 20,
                            ),
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
    );
  }
}
