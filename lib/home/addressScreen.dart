import 'dart:ui';

import 'package:ebuuy/consts/consts.dart';
import 'package:ebuuy/controllers/addtocartController.dart';
import 'package:ebuuy/models/addressmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ebuuy/models/userInfo_model.dart';



class AddressScreen extends StatefulWidget{
  dynamic cartValue;
  AddressScreen({super.key,this.cartValue});

  @override
  State<StatefulWidget> createState() => addressScreen(cartValue: cartValue);

}
class addressScreen extends State<AddressScreen>{
  dynamic cartValue;
  addressScreen({this.cartValue});

  @override
  Widget build(BuildContext context) {
    var orderController = Get.put(OrderController());
    var addToCartCon = Get.put(AddToCartController());
    var data;
    // TODO: implement build
    return WillPopScope(
      onWillPop: () async{
        addToCartCon.orderlist = [];
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: "Select Adress".text.white.make(),
          backgroundColor: redColor,
          centerTitle: true,
          leading: IconButton(icon:Icon(Icons.arrow_back,color: Colors.white), onPressed: () {
            Navigator.pop(context);
          },),
        ),
        body: Container(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FutureBuilder(
                future: FirebaseServices.userInfo(),
                builder: (BuildContext context,AsyncSnapshot snapshot) {
                 if(snapshot.data == null) {
                   return VxShimmer(
                     child: Row(
                       children: [
                         Container(
                           height: 50,
                           width: 50,
                           color: Colors.grey,
                         ),
                         Column(
                           children: [
                             Container(
                               height: 10,
                               color: Colors.grey,
                             ),
                             10.heightBox,
                             Container(
                               height: 10,
                               color: Colors.grey,
                             ),
                             10.heightBox,
                             Container(
                               height: 10,
                               color: Colors.grey,
                             ),

                           ],
                         )
                       ],
                     ));
                 }else if(snapshot.data!.docs.isEmpty){
                   return Container();
                  }else{
                    data = snapshot.data.docs.single;
                    print(data);
                    if(snapshot.data.docs.single["address"].isEmpty){
                      print("no data");
                      return Container();
                    }else{
                     return ListView.builder(
                          shrinkWrap: true,
                          itemCount: data["address"].length,
                          itemBuilder: (context,index){
                            var add = data["address"][index];
                            String address = "Name : ${add["name"]},\n Address : ${add["Address"]} ,"
                                "${add["landmark"]} ,"
                                "${add["city"]} - "
                                "${add["pincode"]} ,"
                                "${add["state"]} ,"
                                "${add["country"]},\n"
                                "Contact Number : ${add["contact_number"]},\n"
                                "Address Type : ${add["shipment_type"]}";
                            orderController.convertToAddress(data["address"][0]);
                            orderController.orderAdd.value = 0;
                            print(orderController.nameCon.text);
                            return Obx(
                                  () => RadioListTile(
                                  title: "$address".text.make(),
                                  value: index,
                                  secondary: IconButton(onPressed: (){
                                      orderController.removeAddress(data["address"][index]);
                                      setState(() {

                                      });
                                  }, icon: const Icon(Icons.delete)),
                                  groupValue: orderController.orderAdd.value,
                                  onChanged:(val){
                                    orderController.orderAdd.value = val!;
                                    orderController.convertToAddress(data["address"][index]);
                                  }),
                            );
                          });

                    }

                  }

                }
              ),
                 Divider(),
                 ListTile(
                   leading: Icon(Icons.add,color: redColor,),
                   title: "Add New Address".text.color(redColor).make(),
                   onTap: (){
                     Get.to(()=>UserInfoScreen());
                   },
                 )
            ],
          ),
        ),
        bottomNavigationBar: ourButton(
          color: redColor,
          title: "Continue",
           textColor: whiteColor,
           onpress: (){
              Get.to(()=>PaymentWayScreen());
           }
        ),
      ),
    );
  }

}