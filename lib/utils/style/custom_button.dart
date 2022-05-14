import 'package:flutter/material.dart';
import 'custom_color.dart';
import 'custom_text_style.dart';
import 'size_config.dart';
import '../util.dart';

class CustomButton {

  static Widget bottomButton({required Widget text, required Color backgroundColor, bool rounded = true, required Function press, double height = 50, double radius = 30.5}){
    return SizedBox(
      width: double.infinity,
      height: SizeConfig.getProportionateScreenHeight(height),
      child: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: backgroundColor,
            shape:rounded ? RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)) : RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0)),
          ),
          onPressed: () { press();},
          child: text
      ),
    );
  }

  static Widget outlinedButton({
    required Widget child,
    bool rounded = true,
    required Color backgroundColor,
    required double radius,
    required Color outlineColor,
    required VoidCallback onPressed}){
    return OutlinedButton(
        onPressed: (){
          onPressed();
        },
        style: OutlinedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(radius)),
          ),
          side: BorderSide(width: 1, color: outlineColor),
        ),
        child: child);
  }
}