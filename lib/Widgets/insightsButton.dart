import 'package:ebuuy/consts/consts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget insightsButton({width,height,onpress,String? value,String? title}){
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      value!.text.fontFamily(bold).size(15).color(Colors.black).make(),
      5.heightBox,
      title!.text.wrapWords(true).fontFamily(semibold).size(8).color(darkFontGrey).makeCentered(),
    ],
  ).box
      .width(width)
      .height(height)
      .p12
      .rounded
      .white
      .margin(const EdgeInsets.symmetric(horizontal: 4))
      .make().onTap(() => onpress);
}