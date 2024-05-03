import 'package:ebuuy/consts/consts.dart';
import 'package:flutter/cupertino.dart';

Widget featuredButton({String? title,icon}){
  return Row(
    children: [
      Image.asset(icon,width: 60,fit: BoxFit.fill,),
      5.widthBox,
      title!.text.fontFamily(semibold).color(darkFontGrey).make()
    ],
  ).box.white.margin(const EdgeInsets.symmetric(horizontal: 8)).width(200).roundedSM.outerShadowSm.padding(const EdgeInsets.all(4)).make();
}