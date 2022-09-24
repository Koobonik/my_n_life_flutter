import 'package:flutter/material.dart';
import 'package:my_n_life/utils/style/custom_text_style.dart';
import 'package:my_n_life/view/my/my_page.dart';

import '../utils/style/custom_color.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  final List<Widget> _widgetOptions = <Widget>[
    const Center(child: Center(child: Text("홈 페이지"))),
    const Center(child: Center(child: Text("몰라 나도"))),
    const MyPage()
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        enableFeedback: true,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedLabelStyle: CustomTextStyle.createTextStyle(fontSize: 10, fontWeight: FontWeight.w500, color: CustomColor.black),
        unselectedLabelStyle: CustomTextStyle.createTextStyle(fontSize: 10, fontWeight: FontWeight.w500, color: CustomColor.grey4),
        selectedIconTheme: const IconThemeData(
          color: CustomColor.black,
        ),
        unselectedIconTheme: const IconThemeData(
          color: CustomColor.grey5,
        ),
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(bottom: 4.0),
              child: Icon(Icons.home, size: 24, color: _selectedIndex == 0 ? CustomColor.black : CustomColor.grey3,),
            ),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(bottom: 4.0),
              child: Icon(Icons.chat_bubble_outline_sharp, size: 24, color: _selectedIndex == 1 ? CustomColor.black : CustomColor.grey3,),
            ),
            label: '대화',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(bottom: 4.0),
              child: Icon(Icons.person, size: 24, color: _selectedIndex == 2 ? CustomColor.black : CustomColor.grey3,),
            ),
            label: 'MY',
          ),
        ],
        currentIndex: _selectedIndex,
        backgroundColor: CustomColor.grey2,
        elevation: 1,
        selectedItemColor: CustomColor.black,
        unselectedItemColor: CustomColor.grey3,
        onTap: _onItemTapped,
      ),
    );
  }
}