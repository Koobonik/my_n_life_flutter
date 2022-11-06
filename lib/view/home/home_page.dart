import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_n_life/getx/parent/const_library.dart';
import 'package:my_n_life/utils/util.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {
  late IOWebSocketChannel channel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initSocket();


  }

  Future<void> initSocket() async {
    channel = IOWebSocketChannel.connect(Uri.parse('ws://192.168.0.5:8080/chat'), headers: {"token": await Util.getSharedString(KEY_TOKEN)});
    channel.stream.listen((message) {
      print(message);
      channel.sink.add('received!');
      // channel.sink.close(status.goingAway);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    channel.sink.close();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("홈"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TextButton(onPressed: () async {
              Map map = {"userToken": await Util.getSharedString(KEY_TOKEN), "text":"반가워요 ㅎㅎ", "createdAt": DateTime.now().toString(), "receivedUserId" : 1};
              channel.sink.add(jsonEncode(map));
              // channel.stream.listen((message) {
              //   channel.sink.add('received!');
              //   // channel.sink.close(status.goingAway);
              // });
            }, child: Text("전송")),

            TextButton(onPressed: () async {
              // channel.sink.close();
              channel = IOWebSocketChannel.connect(Uri.parse('ws://192.168.0.5:8080/chat'), headers: {"token": await Util.getSharedString(KEY_TOKEN)});
              channel.stream.listen((message) {
                print(message);
                // channel.sink.close(status.goingAway);
              });
            }, child: Text("재연결"))
          ],
        ),
      ),
    );
  }
}
