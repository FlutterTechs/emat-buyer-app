import 'package:ebuuy/consts/consts.dart';
import 'package:flutter/cupertino.dart';

Widget productView(){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(child: Image.asset(imgP1,fit: BoxFit.fill,width: 150,),flex: 6,),
      5.heightBox,
      Expanded(child: "Laptop 4Gb/64Gb".text.fontFamily(semibold).color(darkFontGrey).make(),flex: 2,),
      5.heightBox,
      Expanded(child: "${800}".text.fontFamily(bold).color(redColor).make(),flex: 2,),
      5.heightBox,
    ],
  ).box.height(200).roundedSM.p4.white.margin(const EdgeInsets.symmetric(horizontal: 5)).make();
}
Widget productCart({image,String? title,String? price}){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(child: Align(alignment: Alignment.center,
          child: Image.network(image,fit: BoxFit.fill,width: 150,)),flex: 8,),
      5.heightBox,
      Expanded(child: "$title".text.overflow(TextOverflow.ellipsis).maxLines(3).fontFamily(semibold).color(darkFontGrey).make(),flex: 3,),
      5.heightBox,
      Expanded(child: "\u20B9${price}".text.fontFamily(bold).color(redColor).make(),flex: 2,),
      5.heightBox,
    ],
  ).box.shadow.roundedSM.p4.white.make();
}
