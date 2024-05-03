import 'package:ebuuy/Widgets/bg_widget.dart';
import 'package:ebuuy/Widgets/custom_textfeild.dart';
import 'package:ebuuy/Widgets/ourButton.dart';
import 'package:ebuuy/consts/consts.dart';
import 'package:flutter/material.dart';
import 'package:ebuuy/consts/strings.dart';
class ForgetPwdScreen extends StatelessWidget{
  var emailCon = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var authController = Get.put(AuthController());
    return bgWidget(
      child: Scaffold(
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              (context.screenHeight*0.10).heightBox,
              forgetPassword.text.size(30).white.fontWeight(FontWeight.bold).make(),
              (context.screenHeight*0.10).heightBox,

              Column(
                children: [
                  customTextFeild(
                    controller: emailCon,
                    hint: "Enter Email",
                    title: "Email"
                  ),
                  30.heightBox,

                  20.heightBox,
                  ourButton(
                    title: "Submit",
                    color: redColor,
                    onpress: (){
                    if(emailCon.text != ""){
                      if(emailCon.text.contains("@gmail.com")){
                      authController.sendPasswordResetEmail(emailCon.text);
                      }else{
                        Fluttertoast.showToast(msg: "Invalid email");
                      }
                     }else{
                      Fluttertoast.showToast(msg: "Please enter email");
                     }
                    },
                    textColor: whiteColor
                  ).box.width(context.screenWidth - 80).make()
                ],
              ).box.roundedSM.white.p20.shadow.width(context.screenWidth -70).make()
            ],
          ),
        ),
      )
    );
  }

}