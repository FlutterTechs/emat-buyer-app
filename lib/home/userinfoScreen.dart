import 'package:ebuuy/Widgets/custom_textfeild.dart';
import 'package:ebuuy/Widgets/ourButton.dart';
import 'package:ebuuy/consts/colors.dart';
import 'package:ebuuy/consts/consts.dart';
import 'package:ebuuy/controllers/cart_Controller.dart';
import 'package:ebuuy/controllers/userInfo_controller.dart';
import 'package:ebuuy/home/addressScreen.dart';
import 'package:ebuuy/home/paymentWayScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';


class UserInfoScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _userinfoScreen();

}

class _userinfoScreen extends State<UserInfoScreen>{
  var orderController = Get.put(OrderController());

  @override
  void initState() {
    orderController.resetAddress();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    var userInfoController = Get.put(UserInfoController());
  return Scaffold(
    backgroundColor: Colors.white,
    appBar: AppBar(
      title: "Shippping Address".text.white.make(),
      backgroundColor: redColor,
      centerTitle: true,
      leading: IconButton(icon:Icon(Icons.arrow_back,color: Colors.white), onPressed: () {
        Navigator.pop(context);
      },),    ),
    body: Container(
      width: double.infinity,
      height: double.infinity,
      padding: const EdgeInsets.all(12),
      child: ListView(
        children: [
          customTextFeild(
            title: "Name",
            hint: "Enter Your name",
            controller: orderController.nameCon
          ),
          customTextFeild(
              controller: orderController.contactNumberCon,
              hint: "Mobile Number",title: "Contact Details"),
          customTextFeild(controller: orderController.addressCon,
              hint:"Current Address",title: "Address"),
          customTextFeild(controller: orderController.landmarkCon,
              hint:"Lankmark",title: "Landmark"),
          customTextFeild(controller: orderController.countryCon,
              hint: "Country name",title: "Country"),
          customTextFeild(controller: orderController.stateCon,
              hint: "State Name",title: "State"),
          customTextFeild(controller: orderController.cityCon,
              hint: "City Name",title: "City"),
          customTextFeild(controller: orderController.pincodeCon,
              hint: "Postal Code",title: "Area pin code"),
          "Shipment Type".text.color(redColor).size(16).make(),
          Obx(
              ()=> Row(
               children: [
                 Expanded(child: RadioListTile(
                   title: "Home".text.make(),
                     value: 1,
                     groupValue: orderController.selectedValue.value ,
                     onChanged: (val){
                       orderController.selectedValue.value = val!;
                       orderController.shipmentCon.text = "Home";
                     })),
                 Expanded(child: RadioListTile(
                     title: "Office".text.make(),
                     value: 2,
                     groupValue: orderController.selectedValue.value,
                     onChanged: (val){
                       orderController.selectedValue.value = val!;
                       orderController.shipmentCon.text = "Office" ;

                     }))
               ],
             ),
           ),
          20.heightBox,

        ],
      ),
    ),
    bottomNavigationBar: Container(
      width: double.infinity,
      child:  "Continue".text.center.white.fontFamily(semibold).make().
      box.p20.width(context.screenWidth).color(redColor).make().onTap(() {
        if(orderController.checkValue()){
          orderController.addAdress();
          Get.to(()=>PaymentWayScreen());
        }else{
          Fluttertoast.showToast(msg: "Please fill All items");
        }
       // Get.to(()=>PaymentWayScreen());
      }),
    ),
  );
  }
}