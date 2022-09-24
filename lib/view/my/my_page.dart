import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:my_n_life/getx/controller/users_getx_controller.dart';
import 'package:my_n_life/utils/style/custom_color.dart';
import 'package:my_n_life/utils/style/custom_text_style.dart';
import 'package:my_n_life/utils/style/size_config.dart';

class MyPage extends StatefulWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  @override
  Widget build(BuildContext context) {
    final usersGetXController = Get.put(UsersGetXController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: SizeConfig.safeAreaTop! + 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(width: double.infinity,),
              Center(child: Text("${usersGetXController.users!.nickname}님 반갑습니다.", style: CustomTextStyle.createTextStyle(fontSize: 20, fontWeight: FontWeight.w700),)),
              const SizedBox(height: 20,),
              Container(
                width: double.infinity,
                color: Colors.orange.withOpacity(0.8),
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(200),
                      child: CachedNetworkImage(imageUrl: usersGetXController.users!.imageUrl, width: 200, fit: BoxFit.cover,)
                    ),
                    const SizedBox(width: 12,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("나의 바이크 라이프", style: CustomTextStyle.createTextStyle(fontSize: 13, fontWeight: FontWeight.w700),),
                        const SizedBox(height: 12,),
                        Text("닉네임 : 살떡꿀떡"),
                        const SizedBox(height: 20,),
                        Text("팔로잉 : 97"),
                        Text("팔로워 : 125"),
                        Text("게시물 수 : 5"),
                        Text("좋아요 수 : 120"),
                      ],
                    )
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(right: 20, left: 20),
                child: Column(
                  children: [
                    const SizedBox(height: 20,),

                    Row(
                      children: [
                        Text("지금 나의 프로필", style: CustomTextStyle.createTextStyle(fontSize: 13, fontWeight: FontWeight.w500),),
                        Expanded(child: Container()),
                        Text("스와이프 해보세요!", style: CustomTextStyle.createTextStyle(fontSize: 11, fontWeight: FontWeight.w400, color: CustomColor.grey3),)
                      ],
                    ),

                    slidableWidget("바이크 & 모터사이클"),

                    const SizedBox(height: 12,),
                    Text("그 외 프로필", style: CustomTextStyle.createTextStyle(fontSize: 13, fontWeight: FontWeight.w500),),

                    slidableWidget("스쿠버다이빙"),
                    slidableWidget("야구"),
                    slidableWidget("싸이클 & 자전거"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget slidableWidget(String title){
    return Slidable(
      // Specify a key if the Slidable is dismissible.
      // key: const ValueKey(0),

      // The start action pane is the one at the left or the top side.
      startActionPane: ActionPane(
        // A motion is a widget used to control how the pane animates.
        motion: const ScrollMotion(),

        // A pane can dismiss the Slidable.
        dismissible: DismissiblePane(onDismissed: () {}),
        dragDismissible: false,

        // All actions are defined in the children parameter.
        children: const [
          // A SlidableAction can have an icon and/or a label.
          SlidableAction(
            onPressed: null,
            backgroundColor: Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
          SlidableAction(
            onPressed: null,
            backgroundColor: Color(0xFF21B7CA),
            foregroundColor: Colors.white,
            icon: Icons.share,
            label: 'Share',
          ),
        ],
      ),

      // The end action pane is the one at the right or the bottom side.
      endActionPane: const ActionPane(
        motion: ScrollMotion(),
        children: [
          SlidableAction(
            // An action can be bigger than the others.
            flex: 2,
            onPressed: null,
            backgroundColor: Color(0xFF7BC043),
            foregroundColor: Colors.white,
            icon: Icons.archive,
            label: 'Archive',
          ),
          SlidableAction(
            onPressed: null,
            backgroundColor: Color(0xFF0392CF),
            foregroundColor: Colors.white,
            icon: Icons.save,
            label: 'Save',
          ),
        ],
      ),

      // The child of the Slidable is what the user sees when the
      // component is not dragged.
      child: ListTile(title: Text(title)),
    );
  }
}
