import 'package:ebuuy/Widgets/applogo_widget.dart';
import 'package:ebuuy/consts/consts.dart';
import 'package:ebuuy/home/home.dart';
import 'package:ebuuy/views/loginScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ebuuy/consts/firebase_auth.dart';

import '../consts/firebase_auth.dart';
class SplashScreen extends StatefulWidget{
  const SplashScreen({super.key});

  @override
  State<StatefulWidget> createState() => _splashScreen();

}

class _splashScreen extends State<SplashScreen>{

  changeScreen(){
    Future.delayed(Duration(seconds: 3),(){
     auth.authStateChanges().listen((user) {
       if(user == null){
          Get.offAll(() => LoginScreen());
       }else{
         Get.offAll(() => Home());
       }
     });

    });
  }
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    changeScreen();
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: redColor,
      body: Center(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Image.asset(icSplashBg,width: 300,),
            ),
            20.heightBox,
            applogowidget(),
            10.heightBox,
            appname.text.fontFamily(bold).size(22).white.make(),
            5.heightBox,
            appversion.text.white.make(),
            Spacer(),
            credits.text.white.fontFamily(semibold).make(),
            30.heightBox
          ],
        ),
      ),
    );
  }
}