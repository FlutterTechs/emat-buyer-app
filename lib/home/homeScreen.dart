import 'package:ebuuy/Services/FirebaseServices.dart';
import 'package:ebuuy/Widgets/home_button.dart';
import 'package:ebuuy/consts/colors.dart';
import 'package:ebuuy/consts/consts.dart';
import 'package:ebuuy/consts/list.dart';
import 'package:ebuuy/controllers/barcodeController.dart';
import 'package:ebuuy/controllers/product_controller.dart';
import 'package:ebuuy/controllers/qrController.dart';
import 'package:ebuuy/home/TopSellerScreen.dart';
import 'package:ebuuy/home/brandsScreen.dart';
import 'package:ebuuy/home/components/featuredButton.dart';
import 'package:ebuuy/home/featuredScreen.dart';
import 'package:ebuuy/home/productScreen.dart';
import 'package:ebuuy/home/searchProductScreen.dart';
import 'package:ebuuy/home/searchScreen.dart';
import 'package:ebuuy/home/subcatScreen.dart';
import 'package:ebuuy/home/topCategoryScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../Widgets/productView.dart';
import '../controllers/userInfo_controller.dart';

class HomeScreen extends StatefulWidget{



  @override
  State<StatefulWidget> createState() => _homeScreen();

}

class _homeScreen extends State<HomeScreen>{
  var _scanBarcode;
  var productController = Get.put(ProductController());
  var searchCon = TextEditingController();
  var qrController = Get.put(QrController());
  var check = Get.put(UserInfoController());
  var featureddata;
  var result = "";
  Future<void> SimpleBarcode() async{
   await FlutterBarcodeScanner.getBarcodeStreamReceiver("#ff6666", "Cancel", true, ScanMode.QR);
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Container(
        padding: const EdgeInsets.all(12),
        color: lightGrey,
        width: context.screenWidth,
        height: context.screenHeight,
        child: SafeArea(child: ListView(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  VxSwiper.builder(
                      autoPlay: true,
                      enlargeCenterPage: true,
                      aspectRatio: 16/9,
                      height: 150,
                      itemCount: sliderList.length,
                      itemBuilder: (context,index){
                        return Image.asset(sliderList[index],fit: BoxFit.fill,).box.shadowSm.margin(const EdgeInsets.symmetric(horizontal: 8)).rounded.clip(Clip.antiAlias).make();
                      }),
                  15.heightBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(2, (index) {
                      return homeButton(
                          image: index == 0 ? icTodaysDeal : icFlashDeal,
                          title: index == 0 ? todaysDeals : flashSale,
                          width: context.screenWidth / 2.5,
                          height: context.screenHeight * 0.1

                      );
                    }),
                  ),
                  15.heightBox,
                  VxSwiper.builder(
                      aspectRatio: 16/9,
                      autoPlay: true,
                      height: 150,
                      enlargeCenterPage: true,
                      itemCount: secondSlideList.length, itemBuilder: (context,index){
                    return Image.asset(secondSlideList[index],
                      fit: BoxFit.fill,).box.shadowSm.clip(Clip.antiAlias).rounded.margin(const EdgeInsets.symmetric(horizontal: 8)).make();
                  }),
                  15.heightBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(3, (index) {
                      return homeButton(
                          height: context.screenHeight * 0.1,
                          width: context.screenWidth / 3.5,
                          title: index == 0 ? topcategories : (index == 1) ? brands : topSallers,
                          image: index == 0 ? icTopCategories : (index == 1) ? icBrands : icTopSeller
                      ).onTap(() {
                        if(index == 1){
                          Get.to(()=>BrandScreen());
                        }else if(index == 0){
                          Get.to(()=>TopCategoryScreen());

                        }else if(index == 2){
                          Get.to(()=>TopSellerScreen());
                        }
                      });
                    }),
                  ),
                  15.heightBox,

                  Align(
                    alignment: Alignment.centerLeft,
                    child: featuredCategories.text.fontFamily(bold).color(darkFontGrey).size(18).make(),
                  ),
                  20.heightBox,
                  //Featured Categories
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                        children: List.generate(3,(index) => Column(
                          children: [
                            InkWell(child: featuredButton(title: featureTitle1[index],icon: featureImages1[index]),
                            onTap: (){
                              Get.to(()=>SubcategoryScreen(featureTitle1[index]));
                            },),
                            10.heightBox,
                            InkWell(child: featuredButton(title: featureTitle2[index],icon: featureImages2[index]),
                            onTap: (){
                              Get.to(()=>SubcategoryScreen(featureTitle2[index]));

                            },),
                          ],
                        ))
                    ),
                  ),
                  //Featured Products
                  20.heightBox,
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(color: Colors.blueGrey),
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        featuredProduct.text.fontFamily(bold).white.size(20).make(),
                        10.heightBox,
                      SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              FutureBuilder(future: FirebaseServices.getFeaturedProduct() ,
                                  builder: (BuildContext context,AsyncSnapshot snapshot){
                                if(!snapshot.hasData){
                                  return const CircularProgressIndicator();
                                }else if(snapshot.data!.docs.isEmpty){
                                  return "No Data Found".text.center.makeCentered();
                                }else{
                                   featureddata = snapshot.data!.docs;
                                  return Row(
                                    children: List.generate(
                                      featureddata.length > 8  ? 2 : featureddata.length,
                                          (index) {
                                      return productCart(
                                        image: featureddata[index]["p_image"][0],
                                        price: featureddata[index]["p_price"],
                                        title: featureddata[index]["p_name"]
                                      ).box.margin(const EdgeInsets.symmetric(horizontal: 5)).make().onTap(() {
                                        productController.getFav(featureddata[index]["wishlist"]);
                                        Get.to(()=> ProductScreen(data: featureddata[0],title: "${featureddata[index]["sub_category"]}",));
                                      }).box.height(250).width(context.screenWidth / 2.2).make();
                                  },
                                    )
                                  );

                                }
                                                      }),
                              Container(
                                width: 80,
                                  child:  Center(child: IconButton(onPressed: (){
                                    Get.to(()=>FeaturedProductsScreen(featureddata));
                                  }, icon: const Icon(Icons.arrow_circle_right_outlined,size: 50,)),))
                            ],
                          )
                        )
                      ],

                    ),
                  ),
                  20.heightBox,
                  VxSwiper.builder(
                      aspectRatio: 16/9,
                      autoPlay: true,
                      height: 150,
                      enlargeCenterPage: true,
                      itemCount: secondSlideList.length, itemBuilder: (context,index){
                    return Image.asset(thirdSliderList[index],
                       fit: BoxFit.fill,).box.shadowSm.clip(Clip.antiAlias).rounded.margin(const EdgeInsets.symmetric(horizontal: 8)).make();
                  }),
                  20.heightBox,
                  Align(
                    alignment: Alignment.centerLeft,
                    child: "Top Products".text.fontFamily(bold).color(darkFontGrey).size(20).make(),

                  ),
                 20.heightBox,
                 StreamBuilder(stream: FirebaseServices.getAllProduct(),
                      builder: (context,AsyncSnapshot snapshot){
                       if(!snapshot.hasData){
                         return const CircularProgressIndicator();
                       }else if(snapshot.data!.docs.isEmpty){
                         return "No data found".text.makeCentered();
                       }else{
                         var data = snapshot.data!.docs;
                         return GridView.builder(
                             physics: const NeverScrollableScrollPhysics(), //diables the scrolling
                             itemCount: data.length,
                             shrinkWrap: true,
                             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                               mainAxisExtent: 250,
                                 crossAxisSpacing: 8,
                                 mainAxisSpacing: 8,
                                 crossAxisCount:2,
                             ),
                             itemBuilder:(context,index){
                               return productCart(
                                   title: data[index]["p_name"],
                                   image: data[index]["p_image"][0],
                                   price: data[index]["p_price"]
                               ).onTap(() {
                                 productController.getFav(data[index]["wishlist"]);
                                 Get.to(()=> ProductScreen(data: data[index],title: "${data[index]["sub_category"]}",));
                               });
                             });
                       }
                      }),
                  30.heightBox
                ],
              ),
            )
          ],
        )),
      ),
    );
  }

}