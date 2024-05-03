import 'dart:convert';

import 'package:ebuuy/consts/consts.dart';
import 'package:ebuuy/consts/firebase_auth.dart';
import 'package:ebuuy/controllers/addtocartController.dart';
import 'package:ebuuy/models/Categoories_model.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/product_model.dart';

class ProductController extends GetxController{
var getColor = [];
  var addToCartCon = Get.put(AddToCartController());
  var subcat = [];
  getSubcategory (title) async{
    var data = await rootBundle.loadString("./assets/categories.json");
    var decode = categoryModelFromJson(data);
    print(decode.categories);

  }

 var total_price = 0.obs;
  var total_quantity = 1.obs;
  var color = 0.obs;
  String productColor = "";
  addToCart({title,img,seller_name,qty,tprice,vendorId,productId}) async{
   if(productColor != ""){
     try{
       await firestore.collection(cartColllection).doc().set({
         "title":title,
         "img":img,
         "seller_name":seller_name,
         "color":productColor,
         "qty":qty,
         "tprice":tprice,
         "added_by": auth.currentUser!.uid,
         "vendor_id":vendorId,
         "product_id":productId
       }).then((value) {
         Fluttertoast.showToast(msg: "Product added on cart");
       });
     }catch(e){
       print("Error : $e");
     }
   }else{
     Fluttertoast.showToast(msg: "Please select Product Color");
   }
  }

  removeFromCartSingle() async{
   for(int i = 0;i<addToCartCon.orderlist.length;i++){
     await firestore.collection(cartColllection).doc(addToCartCon.orderlist[i].cartId).delete();
   }
  }

  changeQuantity(val){
    total_quantity.value = val;
    findTotalPrice();
}
  findTotalPrice(){
    total_price.value = total_quantity.value * total_price.value;
  }
  resetValues(){
    total_price.value = 0 ;
    total_quantity.value = 1;
    color.value = 0;
  }
   var isFav = false.obs;

  getFav(title){
    if(title.contains(currentUser?.uid)){
      isFav.value = true;
    }else{
      isFav.value = false;
    }
  }
   addToFav(docId) async{
    await firestore.collection(productCollection).doc(docId).update({
      "wishlist": FieldValue.arrayUnion([currentUser!.uid])
    });
    isFav(true);
  }
   removeToFav(docId) async{
    await firestore.collection(productCollection).doc(docId).update({
      "wishlist":FieldValue.arrayRemove([currentUser!.uid])
    });
    isFav(false);

  }


}
