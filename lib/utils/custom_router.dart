import 'package:flutter/material.dart';
import 'package:my_n_life/view/base_page.dart';

class CustomRouter {
  static Route<dynamic> generateRoute(RouteSettings setting) {
    switch (setting.name) {
      // case "/InviteFriendPage":
      //   return MaterialPageRoute(builder: (_) => InviteFriendPage(route: setting.arguments.toString(),));
      // case "/PointCashHistoryPage":
      //   return MaterialPageRoute(builder: (_) => PointCashHistoryPage());
      // case "/CashToMoneyPage":
      //   return MaterialPageRoute(builder: (_) => CashToMoneyPage());
      // case "/UpdateProfilePage":
      //   return MaterialPageRoute(builder: (_) => UpdateProfilePage());
      default:
        return MaterialPageRoute(builder: (context) => const BasePage());
    }
  }

  static Map<String, Widget Function(BuildContext)> routes(){
    return <String, WidgetBuilder>{
      '/BasePage': (BuildContext context) => const BasePage(),
    };
  }

  static List<String> routeList(){
    return [
      '/BasePage',
    ];
  }
}