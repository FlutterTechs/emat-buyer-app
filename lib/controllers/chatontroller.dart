import 'package:ebuuy/consts/firebase_auth.dart';
import 'package:ebuuy/controllers/home_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:firebase_core/firebase_core.dart';
class ChatController extends GetxController{

  @override
  void onInit() {
    getChatId();
    super.onInit();
  }
  var chats = firestore.collection(chatCollection);
  var friendName = Get.arguments[0];
  var friendId = Get.arguments[1];
  var productId = Get.arguments[2];

  var senderName = Get.find<HomeController>().username;
  var currentId = currentUser!.uid;
  var msgController = TextEditingController();

  dynamic chatDocId;
  var isLoading = false.obs;
  getChatId() async{
    isLoading(true);
    await chats.where(Filter.and(Filter("fromId",isEqualTo: currentId,), Filter("product_id",isEqualTo: productId),Filter("toId",isEqualTo: friendId))).get()
    .then((value){
      if(value.docs.isNotEmpty){
        chatDocId = value.docs.single.id;
      }else{
        chats.add({
          "product_id":productId,
          "lastMsgTime":FieldValue.serverTimestamp(),
          "created_on":FieldValue.serverTimestamp(),
          "lastId":"",
          "toId":friendId,
          "fromId":currentId,
          "friend_name":friendName,
          "sender_name":senderName
        }).then((value){
          print(value.id);
          chatDocId = value.id;
        });
      }
    });
    isLoading(false);

  }
var chatData;
  var lastMsgId;
  sendMsg(String msg) async{
    if(msg.trim().isNotEmpty){
      dynamic lastmsgId;
      await chats.doc(chatDocId).collection(messageCollection).add({
        "created_on":FieldValue.serverTimestamp(),
        "msg":msg,
        "sender_id":currentId
      }).then((value) {
        lastmsgId = value.id;
      });
      await  chats.doc(chatDocId).update({
        "lastMsgTime":FieldValue.serverTimestamp(),
        "lastId":lastmsgId
      });


    }
  }
}