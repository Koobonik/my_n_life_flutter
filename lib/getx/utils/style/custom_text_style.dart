import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_n_life/getx/utils/style/size_config.dart';

import 'custom_color.dart';

enum FontType{notoSans, poppins, ibmPlexSans}

class CustomTextStyle {
  static createTextStyle ({
    required double fontSize,
    required Color color,
    required FontWeight fontWeight,
    // bool fontFamilyIsApple = true,
    double letterSpacing = 0,
    TextDecoration decoration = TextDecoration.none,
    bool shadow = false,
    Shadow? shadowParameter,
    FontType fontType = FontType.notoSans,
    double height = 1
  }){
    TextStyle textStyle = TextStyle(
      decoration: decoration,
      color: color,
      fontWeight: fontWeight,
      height: height,
      // fontFamily: fontFamilyIsApple ? fontWeight == FontWeight.w700 || fontWeight == FontWeight.w800 || fontWeight == FontWeight.w900 ? "AppleSDGothicNeoB" :"AppleSDGothicNeo" : "NotoSansKR",
      fontStyle: FontStyle.normal,
      letterSpacing: SizeConfig.getProportionateScreenWidth(letterSpacing),
      fontSize: SizeConfig.getProportionateScreenWidth(fontSize),
    );

    if(fontType == FontType.poppins)
      return GoogleFonts.poppins(textStyle: textStyle);
    else if(fontType == FontType.ibmPlexSans)
      return GoogleFonts.ibmPlexSans(textStyle: textStyle);
    else
      return GoogleFonts.notoSans(textStyle: textStyle);
  }
}