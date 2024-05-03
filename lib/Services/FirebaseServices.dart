import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebuuy/consts/firebase_auth.dart';
import 'package:get/get.dart';
import 'dart:core';
class FirebaseServices{

  static getUserData(uid) {
    return firestore.collection(userCollection).where("id",isEqualTo: uid).snapshots();
  }

  static getProducts(category){
    return firestore.collection(productCollection).where("category",isEqualTo: category).snapshots();
  }

  static getSubProducts(subcat){
    return firestore.collection(productCollection).where("sub_category",isEqualTo: subcat).snapshots();
  }

  static getCart({uid}){
    return firestore.collection(cartColllection).where("added_by",isEqualTo: uid).snapshots();
  }

  static getReadyToOrder({uid}){
    return firestore.collection(cartColllection).where("added_by",isEqualTo: uid).get();
  }

  static getFeaturedProduct(){
    return firestore.collection(productCollection).where("is_featured",isEqualTo: true).get();
  }

  static getAllProduct(){
    return firestore.collection(productCollection).snapshots();
  }

  static getWhislist(){
    return firestore.collection(productCollection).where("wishlist",arrayContains: currentUser!.uid).snapshots();
  }

  static removeFromCart() async{
   var data =  await firestore.collection(cartColllection).where("added_by",isEqualTo: currentUser!.uid).get();
   for(var i = 0;i < data.size; i ++){
     await firestore.collection(cartColllection).doc(data.docs[i].id).delete();
   }
  }

  static getLikeProducts(){
    return firestore.collection(productCollection).get();

  }

  static getChatMessage(docIds) {
    return firestore.collection(chatCollection).doc(docIds).collection(messageCollection).orderBy("created_on",descending: false).snapshots();
  }

  static getCartCount(){
    return firestore.collection(cartColllection).where("added_by",isEqualTo: currentUser!.uid).snapshots().map((event){
      return event.docs.length;
    });
  }

  static getCount() async{
    var res = await Future.wait([
      firestore.collection(cartColllection).where("added_by",isEqualTo: currentUser!.uid).get().then((value) {
        return value.docs.length;
      }),
      firestore.collection(productCollection).where("wishlist",arrayContains: currentUser!.uid).get().then((value){
        return value.docs.length;
      }),
      firestore.collection(orderCollection).where("order_by_id",isEqualTo: currentUser!.uid).get().then((value) {
        return value.docs.length;
      })
    ]);
    return res;
  }
  
  static searchProduct(title) async{
    return firestore.collection(productCollection).get();
  }

  static userInfo(){
    return firestore.collection(userCollection).where("id",isEqualTo: currentUser!.uid).get();
  }
  
  static OrderTracking(){
    return firestore.collection(orderCollection).where("order_by_id",isEqualTo: currentUser!.uid).get();
  }

  static GetVendorProduct(vendorId){
    return firestore.collection(productCollection).where("vendor_id",isEqualTo: vendorId).get();
  }


  static GetBrands(){
    return firestore.collection(brandsCollection).get();
  }

  static getProductBySeller(String seller_name){
    return firestore.collection(productCollection).where("seller_name",isEqualTo: seller_name).get();
  }
  static getProductById(String productId){
    return firestore.collection(productCollection).doc(productId).get();
  }
  static getProductByBrand(String brand_name){
    return firestore.collection(productCollection).where("brand_name",isEqualTo: brand_name).get();
  }
  static GetAllChats(){
    return firestore.collection(chatCollection).where("fromId",isEqualTo: currentUser!.uid).snapshots();
  }
  static getLastMsg({docIds,lastMsgId}){
    return firestore.collection(chatCollection).doc(docIds).collection(messageCollection).doc(lastMsgId).snapshots();
  }
  static getSeller(){
    return firestore.collection(sellerCollection).get();
  }

}