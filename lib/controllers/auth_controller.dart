
import 'package:ebuuy/consts/consts.dart';
import 'package:ebuuy/home/home.dart';
import 'package:ebuuy/views/loginScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ebuuy/consts/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class AuthController extends GetxController{
  var emailCon = TextEditingController();
  var passCon = TextEditingController();
  var  isCheck = false.obs;

  late final dynamic data;
   var isloading = false.obs;
  Future<UserCredential?> loginMethod({context}) async{
    UserCredential? userCredential;
    isloading(true);
    try{
      userCredential = await auth.signInWithEmailAndPassword(
          email: emailCon.text,
          password: passCon.text
      ).then((value) {
        Fluttertoast.showToast(msg: "Login Sucessfully");
        isloading(false);
        Get.offAll(()=> Home());
      }).onError((error, stackTrace) {
        isloading(false);
        Fluttertoast.showToast(msg: "$error");
      });
    }on FirebaseAuthException catch (e){
      isloading(false);
      print("error : $e");
      Fluttertoast.showToast(msg: e.toString());
    }
    return  userCredential;
  }

  Future<UserCredential?> signInMethod({email,password,name}) async{
    UserCredential? userCredential;
    isloading(true);
     if(email.toString() != "" && password.toString() != ""){
        if(password.toString().length >= 6){
          await auth.createUserWithEmailAndPassword(email: email, password: password).then((value) {
            storeUser(
                name: name,
                email: email,
                password: password
            );
            Get.offAll(()=>const LoginScreen());
          }).onError((error, stackTrace){
            Fluttertoast.showToast(msg: "Enable to create user");
            auth.signOut();
          });
        }else{
          Fluttertoast.showToast(msg: "Password should atleat 6 character");
          isloading(false);

        }
     }else{
       Fluttertoast.showToast(msg: "please enter value");
     }
    return  userCredential;
  }

  storeUser({name,password,email}) async{
    DocumentReference store = firestore.collection(userCollection).doc(currentUser?.uid);
    store.set({
      "name":name,
      "password":password,
      "email":email,
      "imageUrl":"",
      "id": auth.currentUser!.uid,
      "total_cart":"00",
      "total_wishlist":"00",
      "total_order":"00"
    }).onError((error, stackTrace) {
      Fluttertoast.showToast(msg: "Enable to store user");
    });
  }

  logOut(context) async{
     try{
       await auth.signOut();
       Get.offAll(()=>const LoginScreen());
     }catch(e){
       print("Error:");
       Fluttertoast.showToast(msg: e.toString());
     }
  }

 Future<void> changeAuthPassword({oldPassword,confirmPassword,newPassword}) async{
    if(oldPassword == confirmPassword){
       User? user = FirebaseAuth.instance.currentUser;
       try{
         user!.updatePassword(newPassword);
         await  firestore.collection(userCollection).doc(currentUser!.uid).update({
           "password":newPassword
         });
         print("password Updated sucessfully");
         Get.offAll(()=>LoginScreen());

       }catch(e){
         print("Password Change Error : $e");
       }

     }else{
       Fluttertoast.showToast(msg: "Password Doesn't match");
     }

  }

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
      print('Password reset email sent successfully');
      Fluttertoast.showToast(msg: "password reset mail sent");
      Get.offAll(()=>LoginScreen());
    } catch (e) {
      print('Error sending password reset email: $e');
    }
  }



}