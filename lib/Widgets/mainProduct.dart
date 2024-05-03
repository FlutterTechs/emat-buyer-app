import 'package:ebuuy/consts/consts.dart';
import 'package:flutter/cupertino.dart';

Widget MainProduct({String? img,String? title,required double rating,String? price,var features}){
  return Container(
    color: Colors.white,
    padding: const EdgeInsets.all(12),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Image.network(img!,width: 120,height: 100,fit: BoxFit.contain,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title!,softWrap: true,style: TextStyle(
                    fontWeight: FontWeight.bold
                  ),),
                  10.heightBox,
                  VxRating(
                    isSelectable: false,
                    value: rating,
                    maxRating: 5,
                    normalColor: textfieldGrey,
                    selectionColor: golden,
                    size: 25,
                    onRatingUpdate: (String value) {
                    },
                  ),
                  10.heightBox,

                  Text(" \u20B9 ${price}",style: TextStyle(
                    fontWeight: FontWeight.bold
                  ),)
                ],
              ).box.p8.make(),
            )
          ],
        ),
        10.heightBox,
        Container(
          child: Wrap(
            children: List.generate(features.length, (index) {
              return Text(features[index]["value"],style: TextStyle(
                fontSize: 12
              ),).box.p3.margin(const EdgeInsets.symmetric(horizontal: 8,vertical: 5)).border(color: Colors.grey.shade300).make();
            }),
          ),
        )
      ],
    ),
  );
}