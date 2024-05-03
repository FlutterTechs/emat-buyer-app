import 'dart:ffi';

import 'package:ebuuy/Services/FirebaseServices.dart';
import 'package:ebuuy/Widgets/ourButton.dart';
import 'package:ebuuy/consts/colors.dart';
import 'package:ebuuy/consts/consts.dart';
import 'package:ebuuy/controllers/cart_Controller.dart';
import 'package:ebuuy/controllers/orderController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentWayScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _paymentWayScreen();

}

class _paymentWayScreen extends State<PaymentWayScreen>{
  var cartController = Get.put(CartController());
  var productController = Get.put(ProductController());
  var ordercontroller = Get.find<OrderController>();

  bool isCheck = false;


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text("Payment Way"),
      backgroundColor: redColor,),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.all(12),
        child: Obx(
            () => Column(
            children: [
              RadioListTile(title: Text("Online Payment"),value: 1,
                  groupValue: ordercontroller.paymentSelect.value, onChanged: (val){
                  ordercontroller.paymentSelect.value = val!;
              }),
              20.heightBox,
              RadioListTile(title: Text("COD"),subtitle:Text("(Cash on Delivery)"),value: 2,
                  groupValue:ordercontroller.paymentSelect.value , onChanged: (val){

                    ordercontroller.paymentSelect.value = val!;

                  }),
               const Spacer(),

            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        width: double.infinity,
        child:  "Order Placed".text.center.white.fontFamily(semibold).make().
        box.p20.width(context.screenWidth).color(redColor).make().onTap(() async{
          if(ordercontroller.paymentSelect.value == 1) {
            print("online delivery");
            ordercontroller.paymentMethodCon.text = "online delivery";
            print(ordercontroller.getFinalPrice());
            Razorpay razorpay = Razorpay();
            int rp = await ordercontroller.getFinalPrice() * 100 ;
            var options = {
              'key': 'rzp_test_1DP5mmOlF5G5ag',
              'amount': rp,
              'name': 'Emart pvt.ltd',
              'description': 'User Products',
              'retry': {'enabled': true, 'max_count': 10},
              'send_sms_hash': true,
              'prefill': {
                'contact': '7339867748',
                'email': 'rahulrawal7860@gmail.com'
              },
              'external': {
                'wallets': ['paytm']
              }
            };

            razorpay.on(
                Razorpay.EVENT_PAYMENT_ERROR, handlePaymentError);
            razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS,
                handlePaymentSuccess);
            razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET,
                handleExternalWallet);
            razorpay.open(options);
          }
          else{
            ordercontroller.paymentMethodCon.text = "COD";
            print("Cash on delivery");
            productController.removeFromCartSingle();
            ordercontroller.OrderProduct();
            Get.offAll(()=>const Home());
          }

        }),
      ),

    );
  }

  void handlePaymentSuccess(PaymentSuccessResponse response) {
    print("payment successful");
    Fluttertoast.showToast(msg: "Order Placed");
    productController.removeFromCartSingle();
     ordercontroller.OrderProduct();

    Get.offAll(()=>const Home());

  }

  void handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(msg: "You can try 10 times");
  }

  void handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet was selected
  }
}