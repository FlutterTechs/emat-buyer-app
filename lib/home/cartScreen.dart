import 'package:ebuuy/Services/FirebaseServices.dart';
import 'package:ebuuy/Widgets/ourButton.dart';
import 'package:ebuuy/consts/consts.dart';
import 'package:ebuuy/home/homeScreen.dart';
import 'package:ebuuy/home/searchScreen.dart';
import 'package:lottie/lottie.dart';
import 'package:ebuuy/controllers/addtocartController.dart';
import 'package:ebuuy/controllers/cart_Controller.dart';
import 'package:ebuuy/controllers/orderController.dart';
import 'package:ebuuy/controllers/product_controller.dart';
import 'package:ebuuy/home/components/addToCart_cart.dart';
import 'package:ebuuy/home/paymentWayScreen.dart';
import 'package:ebuuy/home/productScreen.dart';
import 'package:ebuuy/home/userinfoScreen.dart';
import 'package:flutter/material.dart';
import 'package:ebuuy/consts/firebase_auth.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:ebuuy/Widgets/label.dart';
import 'addressScreen.dart';

class CartScreen extends StatefulWidget{


  @override
  State<StatefulWidget> createState() => _cartScreen();

}

class _cartScreen extends State<CartScreen>{
 /* var cartController = Get.put(CartController());
  var productController = Get.put(ProductController());*/
  var data;
   bool isCartEmpty = false;
  @override
  Widget build(BuildContext context) {
   var orderController = Get.put(OrderController());
   var addToCCartCon  = Get.put(AddToCartController());
      return Scaffold(
        backgroundColor: Colors.white,
      body: Stack(
        children: [
        SizedBox(
          width: context.screenWidth,
          child: StreamBuilder(stream: FirebaseServices.getCart(uid: currentUser!.uid),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if(!snapshot.hasData){
              return Center(child: CircularProgressIndicator(),);
            }else if(snapshot.data!.docs.isEmpty){
              isCartEmpty = true;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset(emptyCart,fit: BoxFit.cover),
                    "Your cart is empty!".text.bold.size(28).make(),
                    10.heightBox,
                   TextButton(
                       onPressed: (){

                         Get.offAll(()=>const Home());
                       },
                   style: TextButton.styleFrom(
                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                     backgroundColor: Colors.blue
                   ), child: "Shop now".text.white.bold.make(),).box.size(150, 35).make()
                  ],
                );
            }else{
              data = snapshot.data!.docs;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                 Expanded(
                   flex: 1,
                   child: ListView.separated(
                     itemBuilder: (context,index){
                     return
                         ListTile(
                           onTap: (){
                           },
                           leading: Image.network(data[index]["img"].toString(),width:100 ,height:100,fit:BoxFit.cover,).box.roundedSM.make(),
                           title: data[index]["title"].toString().text.make(),
                           subtitle: Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               "\u20B9 \t${data[index]["tprice"]}".text.bold.make(),
                               "QTY :${data[index]["qty"]}".text.make(),
                             ],
                           ),
                           trailing: IconButton(onPressed: (){
                             orderController.removeFromCart(data[index].id);

                             setState(() {
                               if(index == 0){
                                 isCartEmpty = true;
                               }
                             });
                           }, icon: const Icon(Icons.delete)),
                         ).box.shadow.white.make();

                   },
                     itemCount: data.length,
                     separatorBuilder: (context,index){
                       return const Divider();
                     },
                   ),
                 ),
                  snapshot.data!.docs.isEmpty?Container():Container(
                    padding: const EdgeInsets.all(20),
                    color: Colors.redAccent.shade200,
                    child: Column(
                      children: [
                      Label(label: "Product Price", value:  addToCCartCon.TotalPrice(data) ),
                        Label(label: "Delivery Charges",
                            value: int.parse(addToCCartCon.TotalPrice(data)) > 400 ? "+0" :"+40"
                        ),
                        Label(label: "Total Price", value:addToCCartCon.TotalPrice(data) ),

                      ],
                    ),
                  )

         ],
              ).box.p12.white.make();
            }
            },),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(),
        ),

        ]
      ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.all(0),
          width: double.infinity,
          child: "Place Your Order".text.center.white.fontFamily(semibold).make().
            box.p20.width(context.screenWidth).color(redColor).make().onTap(() {
              if(isCartEmpty){
                 Fluttertoast.showToast(msg: "Please add a product on cart");
              }else{
                orderController.ReadyOrder(data);
                Get.to(()=>AddressScreen());
              }
          })
        ),
    );
  }
}