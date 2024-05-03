
import 'package:ebuuy/consts/consts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget orderCart({img,String? title,String? price,String? qty,onpress}){
  bool? check = false;
  return Row(
    children: [
      img,
      5.widthBox,
      Column(
        crossAxisAlignment: CrossAxisAlignment.start ,
        children: [
          title!.text.maxLines(3).overflow(TextOverflow.ellipsis).size(18).make(),
          "\u20B9 $price"!.text.size(10).make(),
          "QTY: $qty".text.size(12).fontFamily(bold).make(),
        ],
      ),
      Spacer(),
      IconButton(onPressed: onpress, icon: Icon(Icons.delete))
    ],
  ).box.roundedSM.white.p12.margin(const EdgeInsets.only(bottom: 10)).shadow.make();
}