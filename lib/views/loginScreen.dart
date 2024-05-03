import 'package:ebuuy/Widgets/applogo_widget.dart';
import 'package:ebuuy/Widgets/bg_widget.dart';
import 'package:ebuuy/Widgets/custom_textfeild.dart';
import 'package:ebuuy/Widgets/ourButton.dart';
import 'package:ebuuy/consts/list.dart';
import 'package:ebuuy/controllers/auth_controller.dart';
import 'package:ebuuy/controllers/product_controller.dart';
import 'package:ebuuy/home/homeScreen.dart';
import 'package:ebuuy/views/forgetPwdScreen.dart';
import 'package:ebuuy/views/signupScreen.dart';
import 'package:flutter/material.dart';
import 'package:ebuuy/consts/consts.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import '../home/home.dart';

class LoginScreen extends StatefulWidget{
  const LoginScreen({super.key});

  @override
  State<StatefulWidget> createState() => _loginScreen();
}

// ignore: camel_case_types
class _loginScreen extends State<LoginScreen>{
  var controller = AuthController();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
   controller.emailCon.clear();
    controller.passCon.clear();
  }



  @override
  Widget build(BuildContext context) {
    return bgWidget(child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Column(
            children: [
              (context.screenHeight *0.1).heightBox,
              applogowidget(),
              "Log in to $appname".text.fontFamily(bold).white.size(18).make(),
              15.heightBox,
             Obx(() =>
                      Column(
                  children: [
                    customTextFeild(title:email,hint: emailHint,controller: controller.emailCon),
                    customTextFeild(title:password,hint: hintPassword,controller: controller.passCon),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(onPressed: (){
                        Get.to(()=>ForgetPwdScreen());
                      }, child: forgetPassword.text.make()),
                    ),
                controller.isloading.value ? CircularProgressIndicator() :
                 ourButton(textColor: whiteColor,color: redColor,onpress: () async {
                   if(controller.emailCon.text.isNotBlank && controller.passCon.text.isNotBlank){
                      controller.loginMethod();
                   }else{
                     Fluttertoast.showToast(msg: "Please fill All Feilds");
                   }
                    },title: login).box.width(context.screenWidth-50).make(),
                    5.heightBox,
                    createNewAccount.text.color(fontGrey).make(),
                    5.heightBox,
                    ourButton(title: signup,onpress: (){
                      Get.to(()=>SignupScreen());
                    },color:lightGolden,textColor: redColor,).box.width(context.screenWidth-50).make(),
                    10.heightBox,
                 /*   loginWith.text.color(fontGrey).make(),
                    5.heightBox,
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:
                        List.generate(3, (index) => CircleAvatar(
                          backgroundColor: lightGrey,
                          radius: 25,
                          child: Image.asset(socialIconList[index],width: 30,),
                        ))

                    ),*/
                  ],
                ).box.white.rounded.padding(const EdgeInsets.all(26)).width(context.screenWidth -70).shadowSm.make(),
              ),


            ],
          ),
        ),
      ));
  }
}