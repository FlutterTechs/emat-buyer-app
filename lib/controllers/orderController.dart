
import 'package:ebuuy/controllers/addtocartController.dart';
import 'package:ebuuy/home/components/addToCart_cart.dart';
import 'package:ebuuy/models/addressmodel.dart';
import 'package:ebuuy/models/userInfo_model.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../consts/consts.dart';
import '../models/product_model.dart';

class OrderController extends GetxController{


  var paymentSelect = 0.obs;
  var isSelected = false.obs;

  var nameCon = TextEditingController();
  var contactNumberCon = TextEditingController();
  var addressCon = TextEditingController();
  var landmarkCon = TextEditingController();
  var cityCon = TextEditingController();
  var stateCon = TextEditingController();
  var countryCon = TextEditingController();
  var genderCon = TextEditingController();
  var pincodeCon = TextEditingController();
  var paymentMethodCon = TextEditingController();
  var shipmentCon = TextEditingController();
  removeFromCart(docId) async{
    await firestore.collection(cartColllection).doc(docId).delete();
  }

  removeAddress(element) async{
    await firestore.collection(userCollection).doc(currentUser!.uid).update({
      "address":FieldValue.arrayRemove([element])
    });
  }

var orderAdd = 0.obs;
  var selectedValue = 0.obs;
bool checkValue(){
  if(nameCon.text.trim() != "" && addressCon.text.trim() != "" && contactNumberCon.text.trim() != "" &&
      landmarkCon.text.trim() != "" && cityCon.text.trim() != "" && stateCon.text.trim() != "" &&
      countryCon.text.trim() != "" && pincodeCon.text.trim() != "" && shipmentCon.text.trim() != ""){
    return true;
  }else{
    return false;
  }
}
addAdress() async{
  await firestore.collection(userCollection).doc(currentUser!.uid).update({
    "address":FieldValue.arrayUnion([UserAddress(
      name: nameCon.text,
      address: addressCon.text,
      city: cityCon.text,
      contactNumber: contactNumberCon.text,
      country: countryCon.text,
      landmark: landmarkCon.text,
      pincode: pincodeCon.text,
      shipmentType: shipmentCon.text,
      state: stateCon.text
    ).toJson()])
  });
}
resetAddress(){
  nameCon.clear();
  addressCon.clear();
  landmarkCon.clear();
  cityCon.clear();
  stateCon.clear();
  countryCon.clear();
  nameCon.clear();
  pincodeCon.clear();
  contactNumberCon.clear();
}
convertToAddress(dynamic data) async{
  print("data is :");
  print(data);
    if(data!= null){
    nameCon.text = data["name"];
    contactNumberCon.text =  data["contact_number"];
    landmarkCon.text = data["landmark"];
    cityCon.text = data["city"];
    addressCon.text = data["Address"];
    stateCon.text = data["state"];
    countryCon.text = data["country"];
    pincodeCon.text = data["pincode"];
    shipmentCon.text = data["shipment_type"];
  }
}
var addToCartCon = Get.put(AddToCartController());
dynamic data ;
  Future<void> ReadyOrder(data) async {

    for(int i =0;i<data.length;i++){
      addToCartCon.orderlist.add(
        products(
          cartId: data[i].id.toString(),
          id: data[i]["product_id"].toString(),
          vendorId: data[i]["vendor_id"].toString(),
          sellerName: data[i]["seller_name"].toString(),
          qty: data[i]["qty"].toString(),
          title: data[i]["title"].toString(),
          img: data[i]["img"].toString(),
          color: data[i]["color"].toString(),
          tprice: data[i]["tprice"].toString()
        )
      );

    }
    }
  OrderProduct() async{
      print("before loop");
      print(addToCartCon.orderlist);
        if(addToCartCon.orderlist.isNotEmpty){
          addToCartCon.orderlist.forEach((element) async{
            await firestore.collection(orderCollection).doc().set(
                {
                  "order_by_name":nameCon.text,
                  "order_by_id":currentUser!.uid,
                  "contact_number":contactNumberCon.text,
                  "order_by_address":addressCon.text,
                  "order_by_landmark":landmarkCon.text,
                  "order_by_pincode":pincodeCon.text,
                  "order_by_city":cityCon.text,
                  "order_by_state":stateCon.text,
                  "order_by_country":countryCon.text,
                  "product_id":element.id,
                  "order_name":element.title,
                  "total_price":element.tprice,
                  "total_qty":element.qty,
                  "img":element.img,
                  "color":element.color,
                  "vendor_id":element.vendorId,
                  "vendor_name":element.sellerName,
                  "is_order_placed":true,
                  "is_order_confirmed":false,
                  "is_order_on_delivery":false,
                  "is_order_delivered":false,
                  "payment_method":paymentMethodCon.text,
                  "shipment_type":shipmentCon.text,
                  "invoice":"",
                  "is_order_cancel":false,
                  "is_order_ready":false,
                  "is_order_rejected":false,
                  "is_order_dispatched":false,
                  "otp":"",
                  "booking_date":FieldValue.serverTimestamp(),
                }
            );
          });
          Fluttertoast.showToast(msg: "Order Placed");
        }else{
          Fluttertoast.showToast(msg: "Please add on cart");
        }

  }

   getFinalPrice(){
    var TotalPrice = 0.obs;
    addToCartCon.orderlist.forEach((element) {
      TotalPrice.value += int.parse(element?.tprice ?? '0');
    });
    return TotalPrice.value;
   }

  incressSelles(productId)async{
    await firestore.collection(productCollection).doc(productId).update({
      "selles":FieldValue.increment(1)
    });
  }

  cancelOrder(orderId) async{
    await firestore.collection(orderCollection).doc(orderId).update({
      "is_order_cancel":true
    }).whenComplete(() {
      Get.offAll(()=>Home());
    });
  }

}



  // For Single Order

