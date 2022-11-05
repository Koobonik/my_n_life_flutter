import 'package:flutter/cupertino.dart';

class ContextHandler {
  static CupertinoTabController bottomController = CupertinoTabController(initialIndex: 0);
  // static int bottomIndex = 2;
  static List<BuildContext>? context0 = [];
  static List<BuildContext>? context1 = [];
  static List<BuildContext>? context2 = [];
  static List<BuildContext>? context3 = [];
  static List<BuildContext>? context4 = [];
  static pop(){
    switch (bottomController.index){
      case 0:
        if(context0!.length <= 1) return ;
        BuildContext context = context0!.removeLast();
        return Navigator.of(context).pop();
      case 1:
        if(context1!.length <= 1) return ;
        BuildContext context = context1!.removeLast();
        return Navigator.of(context).pop();
      case 2:
        if(context2!.length <= 1) return ;
        BuildContext context = context2!.removeLast();
        return Navigator.of(context).pop();
      case 3:
        if(context3!.length <= 1) return ;
        BuildContext context = context3!.removeLast();
        return Navigator.of(context).pop();
      case 4:
        if(context4!.length <= 1) return ;
        BuildContext context = context4!.removeLast();
        return Navigator.of(context).pop();
      default:
        break;
    }
  }
  static setContext(BuildContext context){
    switch (bottomController.index){
      case 0:
        context0!.add(context);
        break;
      case 1:
        context1!.add(context);
        break;
      case 2:
        context2!.add(context);
        break;
      case 3:
        context3!.add(context);
        break;
      case 4:
        context4!.add(context);
        break;
      default:
        break;
    }
  }

  static List<BuildContext>? getContext(){
    switch (bottomController.index){
      case 0:
        return context0;
      case 1:
        return context1;
      case 2:
        return context2;
      case 3:
        return context3;
      case 4:
        return context4;
      default:
        return null;
    }
  }

  static goToRootPage(){
    switch (bottomController.index){
      case 0:
        for(int i = 0; i < context0!.length; i++){
          if(context0!.length == 1) break;
          Navigator.of(context0!.removeLast()).pop();
        }
        break;
      case 1:
        for(int i = 0; i < context1!.length; i++){
          if(context1!.length == 1) break;
          Navigator.of(context1!.removeLast()).pop();
        }
        break;
      case 2:
        for(int i = 0; i < context2!.length; i++){
          if(context2!.length == 1) break;
          Navigator.of(context2!.removeLast()).pop();
        }
        break;
      case 3:
        for(int i = 0; i < context3!.length; i++){
          if(context3!.length == 1) break;
          Navigator.of(context3!.removeLast()).pop();
        }
        break;
      case 4:
        for(int i = 0; i < context4!.length; i++){
          if(context4!.length == 1) break;
          Navigator.of(context4!.removeLast()).pop();
        }
        break;
      default:
        return null;
    }
  }
}