import 'package:ebuuy/consts/consts.dart';
import 'package:flutter/cupertino.dart';

Widget homeButton({height,width,String? title,image,}){
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Image.asset(image,width: 26,),
      5.heightBox,
      title!.text.size(12).fontFamily(semibold).color(darkFontGrey).make()
    ],
  ).box.rounded.white.shadowSm.size(width, height).make();
}