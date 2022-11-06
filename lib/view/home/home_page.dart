import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
    var channel = IOWebSocketChannel.connect(Uri.parse('ws://192.168.0.5:8080/chat'));

  @override
  void initState() {
    // TODO: implement initState
    super.initState();


    channel.stream.listen((message) {

      channel.sink.add('received!');
      // channel.sink.close(status.goingAway);
    });

  }

  Future<void> initSocket() async {

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    channel.sink.close();
  }
  @override
  Widget build(BuildContext context) {
    print(channel.innerWebSocket?.pingInterval);
    return Scaffold(
      appBar: AppBar(
        title: Text("홈"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TextButton(onPressed: (){
              Map map = {"userToken": "hi", "text":"반가워요 ㅎㅎ", "createdAt": DateTime.now().toString()};
              channel.sink.add(jsonEncode(map));
              // channel.stream.listen((message) {
              //   channel.sink.add('received!');
              //   // channel.sink.close(status.goingAway);
              // });
            }, child: Text("전송")),

            TextButton(onPressed: (){
              channel = IOWebSocketChannel.connect(Uri.parse('ws://192.168.0.5:8080/chat'));

            }, child: Text("재연결"))
          ],
        ),
      ),
    );
  }
}
