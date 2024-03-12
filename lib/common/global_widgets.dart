

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'color.dart';

PreferredSizeWidget customAppBar( { required Widget title, required Widget leadingIcon, Function()? onPressed, Widget? icon}){
  return AppBar(
    backgroundColor: Colors.black87,
    title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        title,
        Visibility(
            visible: icon == null ? false:true,
            child: IconButton(onPressed: onPressed, icon: icon ?? Container()))
      ],
    ),
    leading: leadingIcon,
    elevation:5,


  );
}

TextStyle getTextStyle(){
  return GoogleFonts.ubuntu( color: commonColor,);
}

TextStyle getTextStyleWithCustomize({required double fontSize, required FontWeight weight}){
  return GoogleFonts.ubuntu( color: commonColor, fontSize: fontSize, fontWeight: weight);
}

TextStyle authTextStyle(Color color){
  return GoogleFonts.ubuntu( color: color);
}

void navigateToScreen(BuildContext context, Widget screen, {bool replace = false}) {
  if (replace) {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => screen));
  } else {
    Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
  }
}



void navigateAndRemovePush(BuildContext context, Widget screen,){
  Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => screen),
          (Route<dynamic> route) => false
  );
}