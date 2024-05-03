import 'package:ebuuy/consts/consts.dart';
import 'package:ebuuy/consts/list.dart';
import 'package:ebuuy/controllers/product_controller.dart';
import 'package:ebuuy/home/categories_detailsScreen.dart';
import 'package:ebuuy/home/searchScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../Widgets/bg_widget.dart';

class CategoriesScreen extends StatelessWidget{
   CategoriesScreen({super.key});
   var controller = Get.put(ProductController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: redColor,
        body: Container(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: GridView.builder(
                  scrollDirection: Axis.vertical,
                    itemCount: 9,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      mainAxisExtent: 200,
                      crossAxisSpacing: 12,
                    mainAxisSpacing: 12),
                    itemBuilder: (context,index){
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(padding: const EdgeInsets.all(12),
                          child:categoriesNameList[index].text.bold.color(darkFontGrey).make(),
                              ),
                          Image.asset(categoriesImageList[index],height: 120,width: 200,fit: BoxFit.contain,),

                        ],
                      ).box.white.shadow.roundedSM.make().onTap(() {
                        controller.getSubcategory(categoriesNameList[index]);
                        Get.to(()=> CategoriesSetailsScreen(title: categoriesNameList[index],));
                      });
                    }),
              ),
            ],
          ),
        ),
      );

  }

}