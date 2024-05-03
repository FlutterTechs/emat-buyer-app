import 'package:ebuuy/Widgets/bg_widget.dart';
import 'package:ebuuy/consts/consts.dart';
import 'package:ebuuy/controllers/auth_controller.dart';
import 'package:ebuuy/home/home.dart';
import 'package:ebuuy/views/loginScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:velocity_x/velocity_x.dart';
import '../Widgets/applogo_widget.dart';
import '../Widgets/custom_textfeild.dart';
import '../Widgets/ourButton.dart';
import '../consts/list.dart';
import 'package:ebuuy/consts/firebase_auth.dart';
import 'package:velocity_x/velocity_x.dart';


class SignupScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _signupScreen();

}

class _signupScreen extends State<SignupScreen> {


  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());
    var nameCon = TextEditingController();
    var emailCon = TextEditingController();
    var pwdCon = TextEditingController();
    var conpwdCon = TextEditingController();
    return bgWidget(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body:Center(
          child: Column(
            children: [
              (context.screenHeight *0.1).heightBox,
              applogowidget(),
              "Join the $appname".text.fontFamily(bold).white.size(18).make(),
              15.heightBox,
              Obx(
                  ()=> Column(
                  children: [
                    customTextFeild(title:name,hint:nameHint,controller: nameCon),
                    customTextFeild(title:email,hint: emailHint,controller: emailCon),
                    customTextFeild(title:password,hint: hintPassword,controller: pwdCon),
                    customTextFeild(title:confirmPassword,hint:hintPassword,controller: conpwdCon),
                    Row(
                      children: [
                        Checkbox(
                            checkColor: redColor,
                            value: controller.isCheck.value,
                            onChanged:(newValue){
                                controller.isCheck.value = newValue!;
                            }),
                        10.widthBox,
                        Expanded(
                          child: RichText(text: TextSpan(
                              children: [
                                TextSpan(text: "I agree to the ",style: TextStyle(
                                  fontFamily: regular,
                                  color: fontGrey,
                                )),
                                TextSpan(text: termCondition,style: TextStyle(
                                  fontFamily: regular,
                                  color: redColor,
                                )),
                                TextSpan(text: " & ",style: TextStyle(
                                  fontFamily: regular,
                                  color: fontGrey,
                                )),
                                TextSpan(text: privacyPolicy,style: TextStyle(
                                  fontFamily: regular,
                                  color: redColor,
                                )),

                              ]
                          )),
                        ),
                      ],
                    ),
                 controller.isloading.value ? CircularProgressIndicator() :
                 ourButton(
                        textColor: whiteColor,
                        color: controller.isCheck.value ?redColor:lightGrey,
                        onpress: (){
                            // Sign method
                            controller.signInMethod(
                              email: emailCon.text,
                              name: nameCon.text,
                              password: pwdCon.text
                            );
                        },
                        title: login).box.width(context.screenWidth-50).make(),
                    10.heightBox,
                    GestureDetector(
                      child: RichText(text: TextSpan(
                        children: [
                          TextSpan(text: alreadyHaveAccount,style: TextStyle(
                            fontFamily: bold,
                            color: fontGrey
                          )),
                          TextSpan(text: login,style: TextStyle(
                              fontFamily: bold,
                              color: redColor
                          )),

                        ]
                      )),
                      onTap: (){
                        Get.back();
                      },
                    )

                  ],
                ).box.white.rounded.padding(const EdgeInsets.all(26)).width(context.screenWidth -70).shadowSm.make(),
              ),


            ],
          ),
        ),
      ),

    );
  }
}