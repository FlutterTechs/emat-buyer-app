import 'package:ebuuy/Services/FirebaseServices.dart';
import 'package:ebuuy/Widgets/featuresView.dart';
import 'package:ebuuy/Widgets/ourButton.dart';
import 'package:ebuuy/Widgets/productView.dart';
import 'package:ebuuy/consts/consts.dart';
import 'package:ebuuy/controllers/addtocartController.dart';
import 'package:ebuuy/controllers/product_controller.dart';
import 'package:ebuuy/home/cartScreen.dart';
import 'package:ebuuy/home/chatScreen.dart';
import 'package:ebuuy/home/productReviewsscreen.dart';
import 'package:ebuuy/models/product_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart ';
import '../Widgets/colorPicker.dart';
import 'addressScreen.dart';
class ProductScreen extends StatefulWidget{
  final dynamic data;
  final String title;
  const ProductScreen({super.key, required this.data, required this.title});
  @override
  State<StatefulWidget> createState() => _product_Screen(data,title);
}

class _product_Screen extends State<ProductScreen>{
  final dynamic data;
  late final String title;
  _product_Screen(this.data, this.title);
  var controller = Get.put(ProductController());
 var addTocartCon = Get.put(AddToCartController());
 @override
  void initState() {

   controller.getColor = data["p_color"];
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var orderController = Get.put(OrderController());
    controller.productColor = "";
    print(data["p_name"]);
    controller.total_price.value = int.parse(data['p_price']);
        var orderlist = [];
    return PopScope(
     canPop: true,
     onPopInvoked: (val) => controller.resetValues(),
     child: Scaffold(backgroundColor: Colors.white,
       appBar: AppBar(
         title: title.text.color(darkFontGrey).fontFamily(bold).make(),
         actions: [
           IconButton(onPressed: (){}, icon: Icon(Icons.share)),
           StreamBuilder(
               stream: FirebaseServices.getCartCount()
               , builder:(BuildContext context,AsyncSnapshot snapshot){
                 if(!snapshot.hasData){
                   return  IconButton(onPressed: (){}, icon: Icon(Icons.shopping_bag));
                 }else{
                   var count = snapshot.data;
                   print(count);
                   return Stack(
                     children: [
                       IconButton(onPressed: (){
                         Get.to(()=>CartScreen() );
                       }, icon: Icon(Icons.shopping_bag)),
                       Positioned(
                       top: 3,
                       right: 5,
                           child: Container(
                             alignment: Alignment.center,
                             width: 20,
                             child: "${count}".text.white.make(),
                             decoration: BoxDecoration(
                               borderRadius: BorderRadius.circular(10),
                               color: Colors.redAccent
                             )
                           )
                       )
             ],
                   );

                 }
           }),
           Obx(
           ()=> IconButton(onPressed: (){

                 if(controller.isFav.value){
                   controller.removeToFav(data.id);
                 }else{
                   controller.addToFav(data.id);
                 }
             }, icon:Icon(
                 Icons.favorite,
               color: controller.isFav.value ? Colors.red :  Colors.grey,
             )),
           ),

         ],
       ),
       body: Obx(
           () => Column(
           children: [
             Expanded(child: SingleChildScrollView(
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                  VxSwiper.builder(
                     height: context.screenHeight / 2.5,
                       aspectRatio: 16 /9,
                       itemCount: data["p_image"].length,
                       enlargeCenterPage: true,
                       itemBuilder: (context,index){
                     return Image.network(
                       data["p_image"][index],
                       width: double.infinity,
                       fit: BoxFit.cover,
                     );
                   }),
                   ListTile(
                     title:data["p_name"].toString().text.make(),
                   ),
                     ListTile(
                       title: VxRating(
                         isSelectable: false,
                       value: data["p_rating"] == "" ? 0 : double.parse(data["p_rating"]),
                       maxRating: 5,
                       normalColor: textfieldGrey,
                       selectionColor: golden,
                       size: 25,
                       onRatingUpdate: (String value) {
                       },
                                          ),
                     ),
                   ListTile(
                     title:"\u20B9 \t ${data["p_price"]}".text.fontFamily(semibold).color(Colors.black).make(),
                   ),
                   ListTile(
                     title: "Colors :".text.make(),
                   ),
                   Container(
                     width: double.infinity,
                     child: ColorPickerRow(
                       data["p_color"].map((e){
                         return int.parse(e);
                       }).toList()
                     ),
                   ),
                  10.heightBox,
                  Divider(height: 5,thickness: 4,color: Colors.grey.shade200,),
                  ListTile(
                    title: seller.text.make(),
                    subtitle: "${data["p_seller"]}".text.make(),
                    trailing: const Icon(Icons.message),
                    onTap: (){
                      Get.to(()=>ChatScreen(title:"${data["p_seller"]}"),arguments: [data["p_seller"],data["vendor_id"],data.id]);
                    },
                  ),

                   ListTile(
                      title: quantity.text.make(),
                      trailing: VxStepper(
                        defaultValue: controller.total_quantity.value,
                        min: 1,
                        max: 100,
                        actionButtonColor: redColor,
                        onChange: (val){
                          controller.total_price.value = int.parse(data['p_price']);
                          controller.changeQuantity(val);
                        },
                      ),
                    ),
                   ListTile(
                      title: totalPrice.text.make(),
                      trailing: "\u20B9 \t${controller.total_price.value}".text.color(darkFontGrey).make(),
                    ),
                   10.heightBox,
                   Divider(height: 5,thickness: 4,color: Colors.grey.shade200,),
                   ListTile(
                     title:"Specification :".text.bold.color(darkFontGrey).size(18).make(),
                   ),
                   Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: List.generate(data["Specification"].length, (index){
                         var features  = data["Specification"];
                         return Featuresview(
                             key: features[index]["keyName"],
                             val: features[index]["value"]
                         );
                       })

                   ).p8().box.width(double.infinity).make(),
                   Divider(height: 5,thickness: 4,color: Colors.grey.shade200,),

                   ListTile(
                   title:discription.text.bold.color(darkFontGrey).size(18).make()
                 ),
                   ListTile(
                     title:Text("${data["p_description"]}",style: TextStyle(
                       color: Colors.black,
                     ),softWrap: true,),
                   ),
                   Divider(height: 5,thickness: 4,color: Colors.grey.shade200,),

                   10.heightBox,
                   ListTile(
                       title:"$reviews :".text.bold.color(darkFontGrey).size(18).make(),
                     trailing: IconButton(onPressed: (){
                       Get.to(()=>ProductReviewsScreen(data["reviews"]));
                     }, icon: const Icon(Icons.arrow_forward_ios,size: 20,)),
                   ),
                   Divider(),
                   data["reviews"] != ""? Column(
                     children:  List.generate(data["reviews"].length > 3 ? 3:data["reviews"].length, (index){
                       var reviews = data["reviews"].toList();
                       var publishtime = reviews[index]["date"];
                       return ListTile(
                         leading: Image.network(reviews[index]['image'].toString(),height: 100,width: 100,),
                         title: Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             Text("Customer : ${reviews[index]["customer_name"].toString()}",style: const TextStyle(
                               fontWeight: FontWeight.bold
                             ),),
                             Text("Feedback : ${reviews[index]["feedback"].toString()}"),
                             VxRating(onRatingUpdate: (val){},
                               isSelectable: false,
                               maxRating: 5,stepInt: true,count: 5,
                               value: double.parse(reviews[index]["ratings"]),)

                           ],
                         ),
                       );
                     }),
                   ):SizedBox(
                     height: 50,
                       child: Center(child: "No review yet avaliable".text.make(),)),
                   Divider(height: 5,thickness: 4,color: Colors.grey.shade200,),
                   ListTile(
                     title: returnPolicy.text.bold.make(),
                   ),
                   const Padding(
                     padding: EdgeInsets.only(right: 12,left: 12),
                     child: ReadMoreText(return_policy,
                       trimMode: TrimMode.Line,
                       trimLines: 4,
                       trimCollapsedText: 'Show more',
                       trimExpandedText: 'Show less',
                       moreStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                       lessStyle:  TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                     )
                   ),
                   10.heightBox,
                   Divider(height: 5,thickness: 4,color: Colors.grey.shade200,),

                   ListTile(
                     title: suppoerPolicy.text.bold.make(),
                   ),
                   const Padding(
                       padding: EdgeInsets.only(right: 12,left: 12),
                       child: ReadMoreText(customerSupport,
                         trimMode: TrimMode.Line,
                         trimLines: 4,
                         trimCollapsedText: 'Show more',
                         trimExpandedText: 'Show less',
                         moreStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                         lessStyle:  TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                       )
                   ),

                   10.heightBox,
                //   productYouAlosLike.text.fontFamily(bold).size(18).color(Colors.black).make(),
                   10.heightBox,

                 ],
               ),

             )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  style: TextButton.styleFrom(
                    side: BorderSide(
                      width: 0.5,
                      color: Colors.grey
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0))
                  ),
                    onPressed: (){
                  controller.addToCart(
                      img: data['p_image'][0],
                      title: data['p_name'],
                      qty: controller.total_quantity.value.toString(),
                      seller_name: data['p_seller'],
                      tprice: controller.total_price.value.toString(),
                      vendorId: data["vendor_id"],
                      productId: data.id
                  );
                  controller.resetValues();
                  setState(() {

                  });
                }, child: Text("Add To Cart",style: TextStyle(color: Colors.black),)).box.height(50).width(context.screenWidth / 2.4).make(),
                TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.yellow,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0))
                    ),
                    onPressed: (){
                        if(controller.productColor != ""){
                          addTocartCon.orderlist.add(products(
                            id: data.id.toString(),
                            vendorId: data["vendor_id"].toString(),
                            sellerName: data["p_seller"].toString(),
                            qty: controller.total_quantity.value.toString(),
                            title: data["p_name"].toString(),
                            img: data["p_image"][0].toString(),
                            color: controller.productColor,
                            tprice: controller.total_price.value.toString(),
                          ));
                          Get.to(()=>AddressScreen());
                        }else{
                          Fluttertoast.showToast(msg: "Please choice color of product");
                        }
                    }, child: Text("Buy Now",style: TextStyle(color: Colors.black),)).box.height(50).width(context.screenWidth / 2.4).make(),

              ],
            ).box.white.p8.make(),
             10.heightBox

           ],
         ),
       ),
     ),
   );
  }
}