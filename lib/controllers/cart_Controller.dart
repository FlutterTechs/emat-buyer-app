import 'dart:ffi';

import 'package:ebuuy/consts/consts.dart';
import 'package:ebuuy/consts/firebase_auth.dart';
import 'package:ebuuy/controllers/home_controller.dart';
import 'package:flutter/cupertino.dart';
import 'dart:core';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CartController extends GetxController{
  int getTotalPrice(data){
    int totalPprice = 0;
    for(int i = 0;i<data.length;i++){
    }
    return totalPprice;
  }
  dynamic productSnapshot;
  var products =[];

  var nameCon = TextEditingController();
  var numCon = TextEditingController();
  var addressCon = TextEditingController();
  var countryCon = TextEditingController();
  var stateCon = TextEditingController();
  var cityCon = TextEditingController();
  var pinCon = TextEditingController();

var placingOrder = false.obs;
var isLoading = false.obs;

}