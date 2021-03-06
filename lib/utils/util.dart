import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'style/custom_button.dart';
import 'style/custom_color.dart';
import 'style/custom_text_style.dart';
import 'style/size_config.dart';

const IS_BGM = 'IS_BGM';
const IS_NARRATION = "IS_NARRATION";
const FIRST_GAME = "FIRST_GAME";

const int MAXIMUM_SEC = 60;
const int MAXIMUM_MIN = 60;
const int MAXIMUM_HOUR = 24;
const int MAXIMUM_DAY = 31;
const int MAXIMUM_DAY_MONTH = 365;

class Util {
  static Future<void> setSharedString(String key, value) async {
    if (key != null && value != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString(key, value);
    }
  }

  static Future<String?> getSharedString(String key) async {
    if (key != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getString(key);
    }
    return null;
  }

  static Future<void> setSharedBool(String key, value) async {
    if (key != null && value != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool(key, value);
    }
  }
  static Future<bool?> getSharedBool(String key) async {
    if (key != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getBool(key);
    }
    return null;
  }

  static Future<void> setSharedInt(String key, value) async {
    if (key != null && value != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setInt(key, value);
    }
  }

  static Future<int?> getSharedInt(String key) async {
    if (key != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getInt(key);
    }
    return null;
  }

  static Future<void> addSharedCount(String key) async {
    if (key != null) {
      int a = await Util.getSharedInt(key) ?? 0;
      setSharedInt(key, ++a);
    }
  }

  static void delSharedString(String key) async {
    try {
      if (key != null) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.remove(key);
      }
    } on Exception {
      print('delExceptioni');
    }
  }

  static void allDeleteSharedString() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }


  static String getFormatDate(String startDate) {
    try {
      DateTime startDateTime = DateTime.parse(startDate).toLocal();
      return '${startDateTime.year}.${startDateTime.month}.${startDateTime.day}';
    } catch (e) {}
    return '';
  }

  static String getFormatDateAll(String startDate) {
    try {
      DateTime startDateTime = DateTime.parse(startDate).toLocal();

      return '${startDateTime.year}.${startDateTime.month}.${startDateTime.day} (${Util.getWeekDayInt(startDateTime.weekday)})' +
          '${getTypeOfTime(startDateTime)} ${getHour(startDateTime)}???';
    } catch (e) {}

    return '';
  }

  static String getWeekDayInt(int weekDay) {
    switch (weekDay) {
      case DateTime.monday:
        return '???';
      case DateTime.tuesday:
        return '???';
      case DateTime.wednesday:
        return '???';
      case DateTime.thursday:
        return '???';
      case DateTime.friday:
        return '???';
      case DateTime.saturday:
        return '???';
      case DateTime.sunday:
        return '???';
      default:
        return '';
    }
  }

  static String getWeekDay(String format) {
    switch (format) {
      case 'Monday':
        return '???';
      case 'Tuesday':
        return '???';
      case 'Wednesday':
        return '???';
      case 'Thursday':
        return '???';
      case 'Friday':
        return '???';
      case 'Saturday':
        return '???';
      case 'Sunday':
        return '???';
      default:
        return '-';
    }
  }

  static String dateString(DateTime dateTime) {
    final now = DateTime.now();
    //????????? ???????????? ??????
    if (dateTime.isAfter(now)) return '';

    final difference = now.difference(dateTime);
    if (difference.inSeconds < MAXIMUM_SEC) return '${difference.inSeconds}??? ???';
    if (difference.inMinutes < MAXIMUM_MIN) return '${difference.inMinutes}??? ???';
    if (difference.inHours < MAXIMUM_HOUR) return '${difference.inHours}?????? ???';
    if (difference.inDays < MAXIMUM_DAY) return '${difference.inDays}??? ???';
    if (difference.inDays < MAXIMUM_DAY_MONTH)
      return '${(difference.inDays / 30).round()}??? ???';

    return '${(difference.inDays / 365).round()}??? ???';
  }

  static String leftDateString(String dateTimeString ) {
    if(dateTimeString == null || dateTimeString.isEmpty)
      return '';
    final dateTime = DateTime.parse(dateTimeString);

    if(dateTime == null)
      return '';

    final now = DateTime.now();
    if (dateTime.isBefore(now)) return '?????????';

    final difference = dateTime.difference(now);
    if (difference.inHours < MAXIMUM_HOUR) return '${difference.inHours}?????? ???';
    if (difference.inDays < MAXIMUM_DAY) return '${difference.inDays}??? ???';
    if (difference.inDays < MAXIMUM_DAY_MONTH)
      return '${(difference.inDays / 30).round()}??? ???';

    return '${(difference.inDays / 365).round()}??? ???';
  }

  static String getTypeOfTime(DateTime parse) {
    String typeOfTime = parse.hour < 12 ? '?????? ' : '?????? ';
    return typeOfTime;
  }

  static String getHour(DateTime parse) {
    int hour = parse.hour <= 12 ? parse.hour : parse.hour - 12;
    return hour.toString();
  }

  static String getMinute(DateTime parse) {
    int minute = parse.minute < 60 ? parse.minute : parse.minute - 60;
    return minute.toString();
  }

  static SnackBar noMoreStageSnackBar() {
    return SnackBar(
      duration: Duration(seconds: 2),
      content: Text("????????? ???????????? ?????????."),
      action: SnackBarAction(
        label: "close",
        textColor: Colors.white,
        onPressed: () {},
      ),
    );
  }

  static Future<bool> showNeutralDialog(
      context,
      String title,
      String content,
      String positiveText,
      String neutralText,
      VoidCallback onPositive,
      VoidCallback onNeutral) async {
    bool result = await showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14.0)), //this right here

          child: Container(
            width: SizeConfig.getProportionateScreenWidth(300),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 23),
                Text(
                  title,
                  style: CustomTextStyle.createTextStyle(fontSize: 14, color: CustomColor.black, fontWeight: FontWeight.w700),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 16.0, right: 16.0, top: 6.0, bottom: 17.0),
                  child: Text(
                    content,
                    style: CustomTextStyle.createTextStyle(fontSize: 14, color: CustomColor.black, fontWeight: FontWeight.w700),
                    textAlign: TextAlign.center,
                  ),
                ),
                Divider(height: 0),
                Container(
                  height: 48,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            Navigator.pop(dialogContext);
                            onPositive();
                          },
                          child: Text(
                              positiveText,
                              style: CustomTextStyle.createTextStyle(fontSize: 14, color: CustomColor.black, fontWeight: FontWeight.w700)
                          ),
                        ),
                      ),
                      VerticalDivider(),
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            Navigator.pop(dialogContext);
                            onNeutral();
                          },
                          child: Text(
                              neutralText,
                              style: CustomTextStyle.createTextStyle(fontSize: 14, color: CustomColor.black, fontWeight: FontWeight.w700)
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
    return result;
  }

  static Future<bool> showNegativeDialog4(
      context,
      String title,
      String content,
      String positiveText,
      String negativeText,
      VoidCallback onPositive,
      VoidCallback onNegative,
      {bool barrierDismissible = false}) async {
    bool result = await showDialog(
      barrierDismissible: barrierDismissible, // ????????? ???????????? ??? ????????? ????????? ????????? ????????? flag
      context: context,
      builder: (BuildContext dialogContext) {
        return Dialog(

          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14.0)), //this right here

          child: Container(
            width: SizeConfig.getProportionateScreenWidth(300),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 23),
                Text(
                    title,
                    style: CustomTextStyle.createTextStyle(fontSize: 14, color: CustomColor.black, fontWeight: FontWeight.w700),
                  textAlign: TextAlign.center,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 16.0, right: 16.0, top: 6.0, bottom: 17.0),
                  child: Text(
                    content,
                    style: CustomTextStyle.createTextStyle(fontSize: 14, color: CustomColor.grey, fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                ),
                Divider(height: 0),
                Container(
                  height: 48,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            Navigator.pop(dialogContext);
                            onPositive();
                          },
                          child: Text(
                              positiveText,
                              style: CustomTextStyle.createTextStyle(fontSize: 14, color: CustomColor.black, fontWeight: FontWeight.w500)
                          ),
                        ),
                      ),
                      VerticalDivider(),
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            Navigator.pop(dialogContext);
                            onNegative();
                          },
                          child: Text(
                            negativeText,
                            style: CustomTextStyle.createTextStyle(fontSize: 14, color: CustomColor.lightBlue, fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
    return result;
  }

  static Future<bool> showVerticalTwoButtonDialog(
      context,
      String title,
      String content,
      String top,
      String bottom,
      VoidCallback topFunction,
      VoidCallback bottomFunction,
      {bool barrierDismissible = true}) async {
    bool result = await showDialog(
      barrierDismissible: barrierDismissible, // ????????? ???????????? ??? ????????? ????????? ????????? ????????? flag
      context: context,
      builder: (BuildContext dialogContext) {
        return Dialog(
          backgroundColor: CustomColor.darkBlack,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14.0)), //this right here

          child: Container(
            width: SizeConfig.getProportionateScreenWidth(300),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 23),
                Text(
                  title,
                  style: CustomTextStyle.createTextStyle(fontSize: 14, color: CustomColor.white, fontWeight: FontWeight.w700),
                  textAlign: TextAlign.center,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 16.0, right: 16.0, top: 6.0, bottom: 17.0),
                  child: Text(
                    content,
                    style: CustomTextStyle.createTextStyle(fontSize: 14, color: CustomColor.grey, fontWeight: FontWeight.w400),
                    textAlign: TextAlign.center,
                  ),
                ),
                Divider(height: 0),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      CustomButton.bottomButton(
                        text: Text(top, style: CustomTextStyle.createTextStyle(fontSize: 14, color: CustomColor.lightBlue, fontWeight: FontWeight.w700),),
                        backgroundColor: CustomColor.white,
                        press: (){
                          Navigator.of(dialogContext).pop(true);
                          topFunction();
                        },
                      ),
                      Container(height: 12),
                      CustomButton.bottomButton(
                        text: Text(bottom, style: CustomTextStyle.createTextStyle(fontSize: 14, color: CustomColor.white.withOpacity(0.8), fontWeight: FontWeight.w700),),
                        backgroundColor: CustomColor.darkGrey,
                        press: (){
                          Navigator.of(dialogContext).pop(true);
                          bottomFunction();
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
    return result;
  }



  static Future<bool> showOneButton(
      context,
      String title,
      String positiveText,
      VoidCallback onPositive,
      {bool barrierDismissible = false}) async {
    bool result = await showDialog(
      barrierDismissible: barrierDismissible, // ????????? ???????????? ??? ????????? ????????? ????????? ????????? flag
      context: context,
      builder: (BuildContext dialogContext) {
        return Dialog(

          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14.0)), //this right here

          child: Container(
            width: SizeConfig.getProportionateScreenWidth(300),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    title,
                    style: CustomTextStyle.createTextStyle(fontSize: 14, color: CustomColor.black, fontWeight: FontWeight.w700),
                    textAlign: TextAlign.center,
                  ),
                ),
                Divider(height: 0),
                Container(
                  height: 48,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            Navigator.pop(dialogContext);
                            onPositive();
                          },
                          child: Text(
                              positiveText,
                              style: CustomTextStyle.createTextStyle(fontSize: 14, color: CustomColor.black, fontWeight: FontWeight.w500)
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
    return result;
  }

  static void showSnackBar(BuildContext context, String text){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(text),
        action: SnackBarAction(
            label: '??????',
            onPressed:
            ScaffoldMessenger.of(context).hideCurrentSnackBar)));
  }


  static void showCustomModalBottomSheet({required BuildContext context, required String title, required String content, required String bottomTitle, required String bottomButtonText, required Function onPressed}){
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        builder: (modalContext){
          return Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
              color:CustomColor.darkBlack,
            ),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: CustomTextStyle.createTextStyle(fontSize: 14, color: CustomColor.white, fontWeight: FontWeight.w700),),
                      Container(height: 20,),
                      Text(content, style: CustomTextStyle.createTextStyle(fontSize: 14, color: CustomColor.grey, fontWeight: FontWeight.w400, fontType: FontType.ibmPlexSans),),


                      Expanded(child: Container()),
                      Divider(height: 10, color: CustomColor.grey, thickness: 0.5,),
                      Container(height: 10,),
                      Text(bottomTitle, style: CustomTextStyle.createTextStyle(fontSize: 12, color: CustomColor.grey, fontWeight: FontWeight.w400, fontType: FontType.ibmPlexSans),),
                      Container(height: 60,),
                      OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            primary: CustomColor.black,
                            backgroundColor: CustomColor.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100.0),
                            ),
                          ),
                          onPressed: () async {
                            // Util.setSharedBool(CREATOR_MODE, true)
                            onPressed();
                            Navigator.of(modalContext).pop();
                          },
                          child: Container(
                            width: SizeConfig.getProportionateScreenWidth(320),
                            height: SizeConfig.getProportionateScreenHeight(46),
                            child: Center(
                              child: Text(
                                bottomButtonText,
                                style: CustomTextStyle.createTextStyle(
                                    fontSize: 15,
                                    color: CustomColor.black,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          )
                      )
                    ],
                  ),
                ),
                Positioned(
                  top: 5,
                  right: 5,
                  child: TextButton(child: Text("??????", style: CustomTextStyle.createTextStyle(fontSize: 16, color: CustomColor.lightBlue, fontWeight: FontWeight.w500, fontType: FontType.ibmPlexSans),),
                    onPressed: (){
                      Navigator.of(modalContext).pop();
                    },
                  ),

                )
              ],
            ),
          );
        }
    );
  }

  static String getMoneyFormat(int number){
    return NumberFormat("###,###,###,###").format(number);
  }
}