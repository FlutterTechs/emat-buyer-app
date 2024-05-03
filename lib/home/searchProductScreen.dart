import 'package:ebuuy/Services/FirebaseServices.dart';
import 'package:ebuuy/consts/consts.dart';
import 'package:ebuuy/controllers/product_controller.dart';
import 'package:ebuuy/home/productScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Widgets/productView.dart';

class SearchProductScreen extends StatefulWidget{
   String title;

  SearchProductScreen({super.key,required this.title});
  @override
  State<StatefulWidget> createState() => _searchProductScreen(title);

}

class _searchProductScreen  extends State<SearchProductScreen>{
  String title;
  _searchProductScreen(this.title);
  @override
  Widget build(BuildContext context) {
    var productController = Get.put(ProductController());
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
      title: "Search result:${title}".text.make(),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.all(20),
        child: FutureBuilder(
            future: FirebaseServices.searchProduct(title),
            builder: (BuildContext context,AsyncSnapshot snapshot){
              if(!snapshot.hasData){
                return Center(child: CircularProgressIndicator(),);
              }else if(snapshot.data!.docs.isEmpty){
                return Center(child: "No Such data Found".text.make(),);
              }else{
                var data = snapshot.data!.docs;

                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(data.length, (index) {
                      return productCart(
                          image: data[index]["p_image"][0],
                          price: data[index]["p_price"],
                          title: data[index]["p_name"]
                      ).onTap(() {
                        productController.getFav(data[index]["wishlist"]);
                        Get.to(()=> ProductScreen(data: data[0],title: "${data[index]["p_name"]}",));
                      });
                    },
                    )
                );
              }
            }),
      ),
    );
}}