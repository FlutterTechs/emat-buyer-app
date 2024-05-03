import 'dart:convert';

import 'package:ebuuy/Services/FirebaseServices.dart';
import 'package:ebuuy/Widgets/bg_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:ebuuy/Widgets/mainProduct.dart';
import 'package:ebuuy/Widgets/productView.dart';
import 'package:ebuuy/consts/consts.dart';
import 'package:ebuuy/controllers/product_controller.dart';
import 'package:ebuuy/controllers/qrController.dart';
import 'package:ebuuy/home/productScreen.dart';
import 'package:ebuuy/home/searchScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:get/get_core/src/get_main.dart';

class CategoriesSetailsScreen extends StatefulWidget{
  // ignore: prefer_typing_uninitialized_variables
  final String title;
  const CategoriesSetailsScreen({Key? key,required this.title}) : super(key : key);

  @override
  State<StatefulWidget> createState() => _categoriesDetailsScreen( title:this.title);

}

class _categoriesDetailsScreen extends State<CategoriesSetailsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  final String title;
   _categoriesDetailsScreen({required this.title});
  @override
  Widget build(BuildContext context) {
    var productController = Get.find<ProductController>();
    var qrController = Get.put(QrController());
   /* var metadata = FirebaseServices.getProducts(title.text);

    // Assuming your stream looks like this:

   // Convert the stream to a list of maps
    List<Map<String, dynamic>> mapList = [];
    metadata.listen((QuerySnapshot<Map<String, dynamic>> snapshot) {
      // Iterate over the documents in the snapshot and convert each to a map
      List<Map<String, dynamic>> documents = snapshot.docs.map((QueryDocumentSnapshot<Map<String, dynamic>> doc) {
        return doc.data() as Map<String, dynamic>;
      }).toList();

      // Add the list of maps to the overall list
      mapList.addAll(documents);
    });*/

// Now 'mapList' contains the list of maps from your stream.

    return Scaffold(
      backgroundColor: Colors.white,
        appBar:AppBar(
          toolbarHeight: 70,
          automaticallyImplyLeading: false,
          backgroundColor: redColor,
          title: Container(
            width: 330,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Icon(Icons.search),
                TextField(
                  enabled: false,
                  decoration: InputDecoration(
                      hintText: "Search for product"
                  ),
                ).box.width(200).make(),
                Icon(Icons.qr_code_scanner),
                Icon(Icons.mic),
              ],
            ),
          ).onTap(() {
            Get.to(()=>SearchScreen());
          }),
          actions: [
            IconButton(onPressed: (){
              qrController.scanQR();
            }, icon:const Icon(Icons.qr_code_scanner_outlined,color: Colors.white,),
            ),
            20.widthBox
          ],
        ),
      body: StreamBuilder(stream: FirebaseServices.getProducts(title),
          builder: (BuildContext context,AsyncSnapshot snapshot){
        if(!snapshot.hasData){
          return Center(child: CircularProgressIndicator(),);
        }else if(snapshot.data!.docs.isEmpty){
           return Center(child:Lottie.asset(noitemFound),heightFactor: double.maxFinite,widthFactor: double.maxFinite,);
        }else{
          var data = snapshot.data!.docs;
          return Column(
            children: [
              Container(
                padding: const EdgeInsets.only(left: 20),
                height: 50,
                color: Colors.white,
                alignment: Alignment.centerLeft,
                child: "${"Category"} : ${title}".text.bold.make(),
              ),
              Divider(height: 5,thickness: 4,color: Colors.grey.shade200,),

              Expanded(
                child: ListView.separated(
                  shrinkWrap: true,
                    itemBuilder: (context,index){
                      return MainProduct(
                        rating: data[index]["p_rating"] == "" ? 0 : double.parse(data[index]["p_rating"]),
                        title: data[index]["p_name"].toString(),
                        img: data[index]["p_image"][0].toString(),
                        price:data[index]["p_price"].toString(),
                        features: data[index]["Specification"]
                      ).onTap(() {
                        Get.to(()=>ProductScreen(data: data[index], title: data[index]["sub_category"].toString()));
                      });
                    },
                    separatorBuilder: (context,index){
                      return const Divider();
                    },
                    itemCount: data.length),
              ),

            ],
          );
        }
      })
    );

  }
}