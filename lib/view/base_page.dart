import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_n_life/utils/context_handler.dart';
import 'package:my_n_life/utils/custom_router.dart';
import 'package:my_n_life/utils/log.dart';
import 'package:my_n_life/utils/style/custom_color.dart';
import 'package:my_n_life/utils/style/custom_text_style.dart';
import 'package:my_n_life/utils/style/size_config.dart';
import 'package:my_n_life/view/home/home_page.dart';
import 'package:my_n_life/view/my/my_page.dart';

class BasePage extends StatefulWidget {
  const BasePage({Key? key}) : super(key: key);

  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {

  bool _notificationsEnabled = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ContextHandler.bottomController.addListener(() {
      setState(() {
        Log.info("인식해");
      });
    });

    // _isAndroidPermissionGranted();
    // _requestPermissions();
    // _configureDidReceiveLocalNotificationSubject();
    // _configureSelectNotificationSubject();
  }

  // Future<void> init() async {
  // }
  //
  // Future<void> _isAndroidPermissionGranted() async {
  //   if (Platform.isAndroid) {
  //     final bool granted = await flutterLocalNotificationsPlugin
  //         .resolvePlatformSpecificImplementation<
  //         AndroidFlutterLocalNotificationsPlugin>()
  //         ?.areNotificationsEnabled() ??
  //         false;
  //
  //     setState(() {
  //       _notificationsEnabled = granted;
  //     });
  //   }
  // }
  //
  // Future<void> _requestPermissions() async {
  //   if (Platform.isIOS || Platform.isMacOS) {
  //     await flutterLocalNotificationsPlugin
  //         .resolvePlatformSpecificImplementation<
  //         IOSFlutterLocalNotificationsPlugin>()
  //         ?.requestPermissions(
  //       alert: true,
  //       badge: true,
  //       sound: true,
  //     );
  //     await flutterLocalNotificationsPlugin
  //         .resolvePlatformSpecificImplementation<
  //         MacOSFlutterLocalNotificationsPlugin>()
  //         ?.requestPermissions(
  //       alert: true,
  //       badge: true,
  //       sound: true,
  //     );
  //   } else if (Platform.isAndroid) {
  //     final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
  //     flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
  //         AndroidFlutterLocalNotificationsPlugin>();
  //
  //     final bool? granted = await androidImplementation?.requestPermission();
  //     setState(() {
  //       _notificationsEnabled = granted ?? false;
  //     });
  //   }
  // }
  //
  // void _configureDidReceiveLocalNotificationSubject() {
  //   didReceiveLocalNotificationSubject.stream
  //       .listen((ReceivedNotification receivedNotification) async {
  //     await showDialog(
  //       context: context,
  //       builder: (BuildContext context) => CupertinoAlertDialog(
  //         title: receivedNotification.title != null
  //             ? Text(receivedNotification.title!)
  //             : null,
  //         content: receivedNotification.body != null
  //             ? Text(receivedNotification.body!)
  //             : null,
  //         actions: <Widget>[
  //           CupertinoDialogAction(
  //             isDefaultAction: true,
  //             onPressed: () async {
  //               Navigator.of(context, rootNavigator: true).pop();
  //               // await Navigator.push(
  //               //   context,
  //               //   MaterialPageRoute<void>(
  //               //     builder: (BuildContext context) =>
  //               //         SecondPage(receivedNotification.payload),
  //               //   ),
  //               // );
  //             },
  //             child: const Text('Ok'),
  //           )
  //         ],
  //       ),
  //     );
  //   });
  // }
  //
  // void _configureSelectNotificationSubject() {
  //   selectNotificationSubject.stream.listen((String? payload) async {
  //     await Navigator.pushNamed(context, '/secondPage');
  //   });
  // }
  //
  // void initLocalPush() async {
  //   await _configureLocalTimeZone();
  //
  //   final NotificationAppLaunchDetails? notificationAppLaunchDetails = !kIsWeb &&
  //       Platform.isLinux
  //       ? null
  //       : await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
  //   // String initialRoute = LocalNotificationHomePage.routeName;
  //   // if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
  //   //   selectedNotificationPayload = notificationAppLaunchDetails!.payload;
  //   //   initialRoute = SecondPage.routeName;
  //   // }
  //   flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
  //       AndroidFlutterLocalNotificationsPlugin>()?.requestPermission();
  //
  //   const AndroidInitializationSettings initializationSettingsAndroid =
  //   AndroidInitializationSettings('@mipmap/launcher_icon');
  //
  //   /// Note: permissions aren't requested here just to demonstrate that can be
  //   /// done later
  //   final IOSInitializationSettings initializationSettingsIOS =
  //   IOSInitializationSettings(
  //       requestAlertPermission: false,
  //       requestBadgePermission: false,
  //       requestSoundPermission: false,
  //       onDidReceiveLocalNotification: (
  //           int id,
  //           String? title,
  //           String? body,
  //           String? payload,
  //           ) async {
  //         didReceiveLocalNotificationSubject.add(
  //           ReceivedNotification(
  //             id: id,
  //             title: title,
  //             body: body,
  //             payload: payload,
  //           ),
  //         );
  //       });
  //   const MacOSInitializationSettings initializationSettingsMacOS =
  //   MacOSInitializationSettings(
  //     requestAlertPermission: false,
  //     requestBadgePermission: false,
  //     requestSoundPermission: false,
  //   );
  //   final LinuxInitializationSettings initializationSettingsLinux =
  //   LinuxInitializationSettings(
  //     defaultActionName: 'Open notification',
  //     defaultIcon: AssetsLinuxIcon('icons/app_icon.png'),
  //   );
  //   final InitializationSettings initializationSettings = InitializationSettings(
  //     android: initializationSettingsAndroid,
  //     iOS: initializationSettingsIOS,
  //     macOS: initializationSettingsMacOS,
  //     linux: initializationSettingsLinux,
  //   );
  //   await flutterLocalNotificationsPlugin.initialize(initializationSettings,
  //       onSelectNotification: (String? payload) async {
  //         if (payload != null) {
  //           debugPrint('notification payload: $payload');
  //         }
  //         selectedNotificationPayload = payload;
  //         selectNotificationSubject.add(payload);
  //       });
  // }
  //
  // Future<void> _configureLocalTimeZone() async {
  //   if (kIsWeb || Platform.isLinux) {
  //     return;
  //   }
  //   tz.initializeTimeZones();
  //   // final String? timeZoneName = tz.TimeZone(offset, isDst: isDst, abbreviation: abbreviation)
  //   // tz.setLocalLocation(tz.getLocation(timeZoneName!));
  // }

  List<int> stack = [2];

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return CupertinoTabScaffold(
      controller: ContextHandler.bottomController,
      tabBar: CupertinoTabBar(
        currentIndex: ContextHandler.bottomController.index,
        height: sBottomNavigatorHeight,
        activeColor: CustomColor.white,
        onTap: (bottomIndex) {
          Log.info("지금의 바텀 인덱스 -> ${ContextHandler.bottomController.index}");
          if(ContextHandler.bottomController.index == bottomIndex){
            stack.add(bottomIndex);
            if(stack.isNotEmpty && stack.length > 2 && stack.last == stack[stack.length-2]){
              ContextHandler.goToRootPage();
            }
          }
          setState(() {
            // ContextHandler.controller.index = bottomIndex;
            ContextHandler.bottomController.index = bottomIndex;
          });
        },
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ContextHandler.bottomController.index == 0 ? const Icon(Icons.home, color: CustomColor.black) : const Icon(Icons.home_outlined),
                Text("홈", style: CustomTextStyle.createTextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: ContextHandler.bottomController.index == 0 ? CustomColor.black : CustomColor.darkGrey),)
              ],
            ),
          ),
          BottomNavigationBarItem(
            icon: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ContextHandler.bottomController.index == 1 ? const Icon(Icons.chat_bubble, color: CustomColor.black) : const Icon(Icons.chat_bubble_outline),
                Text("채팅", style: CustomTextStyle.createTextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: ContextHandler.bottomController.index == 1 ? CustomColor.black : CustomColor.darkGrey),)
              ],
            ),
          ),
          BottomNavigationBarItem(
            icon: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ContextHandler.bottomController.index == 2 ? const Icon(Icons.people, color: CustomColor.black) : const Icon(Icons.people_alt_outlined),
                Text("커뮤니티", style: CustomTextStyle.createTextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: ContextHandler.bottomController.index == 2 ? CustomColor.black : CustomColor.darkGrey),)
              ],
            ),
          ),
          BottomNavigationBarItem(
            icon: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ContextHandler.bottomController.index == 3 ? const Icon(Icons.shopping_basket_rounded, color: CustomColor.black) : const Icon(Icons.shopping_basket_outlined),
                Text("쇼핑", style: CustomTextStyle.createTextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: ContextHandler.bottomController.index == 3 ? CustomColor.black : CustomColor.darkGrey),)
              ],
            ),
          ),
          BottomNavigationBarItem(
            icon: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ContextHandler.bottomController.index == 4 ? const Icon(Icons.person, color: CustomColor.black) : const Icon(Icons.person_outline_outlined),
                Text("마이", style: CustomTextStyle.createTextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: ContextHandler.bottomController.index == 4 ? CustomColor.black : CustomColor.darkGrey),)
              ],
            ),
          ),
        ],
      ),
      tabBuilder: (context, index) {
        switch (index) {
          case 0:
            return WillPopScope(
              onWillPop: () async {
                Log.info("이이 SearchPage pop");
                ContextHandler.pop();
                return false;
              },
              child: CupertinoTabView(
                  onGenerateRoute: CustomRouter.generateRoute,
                  routes: CustomRouter.routes(),
                  builder: (context) {
                    Log.info("이이 SearchPage");
                    return const CupertinoPageScaffold(
                      child: HomePage(),
                    );
                  }),
            );
          case 1:
            return CupertinoTabView(
                onGenerateRoute: CustomRouter.generateRoute,
                routes: CustomRouter.routes(),

                // onUnknownRoute: (settings) => MaterialPageRoute(builder: (_) => StorePage()),
                builder: (context) {
                  Log.info("이이 StorePage");
                  return const CupertinoPageScaffold(
                    child: SizedBox.shrink(),
                  );
                });
          case 2:
            return WillPopScope(
              onWillPop: () async {
                Log.info("이이222");
                ContextHandler.pop();
                return false;
              },
              child: CupertinoTabView(
                  onGenerateRoute: CustomRouter.generateRoute,
                  routes: CustomRouter.routes(),
                  // onUnknownRoute: (settings) => MaterialPageRoute(builder: (_) => GoogleMapPage()),
                  builder: (context) {
                    return const CupertinoPageScaffold(
                      child: SizedBox.shrink(),
                    );
                  }),
            );
          case 3:
            return CupertinoTabView(
                onGenerateRoute: CustomRouter.generateRoute,
                routes: CustomRouter.routes(),
                // onUnknownRoute: (settings) => MaterialPageRoute(builder: (_) => PushMessagePage()),
                builder: (context) {
                  Log.info("이이 PushMessagePage");
                  return const Scaffold(
                    body: SizedBox.shrink(),
                  );
                });
          case 4:
            return CupertinoTabView(
                onGenerateRoute: CustomRouter.generateRoute,
                routes: CustomRouter.routes(),
                onUnknownRoute: (_) => null,
                builder: (context) {
                  Log.info("이이 MyPage");
                  return const CupertinoPageScaffold(
                    child: MyPage(),
                  );
                });
          default:
            return CupertinoTabView(
                onGenerateRoute: CustomRouter.generateRoute,
                routes: CustomRouter.routes(),
                builder: (context) {
                  Log.info("이이 default");
                  return const CupertinoPageScaffold(
                    child: SizedBox.shrink(),
                  );
                });
        }
      },
    );
  }
}