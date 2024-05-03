import 'dart:io';

import 'package:ebuuy/Widgets/bg_widget.dart';
import 'package:ebuuy/Widgets/custom_textfeild.dart';
import 'package:ebuuy/Widgets/ourButton.dart';
import 'package:ebuuy/consts/consts.dart';
import 'package:ebuuy/controllers/auth_controller.dart';
import 'package:ebuuy/controllers/edit_profile_controller.dart';
import 'package:ebuuy/controllers/userInfo_controller.dart';
import 'package:ebuuy/home/home.dart';
import 'package:ebuuy/home/profileScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProfileScreen extends StatefulWidget{
  final dynamic data;

  const EditProfileScreen({super.key, required this.data});

  @override
  State<StatefulWidget> createState() => _editprofileScreen(data: this.data);
  
}

class _editprofileScreen extends State<EditProfileScreen>{
  final dynamic data;

  _editprofileScreen({required this.data});

var editContoller = Get.put(EditProfileController());
var userInfoController = Get.put(UserInfoController());
  var a;
@override
  void initState() {
    // TODO: implement initState
   if(data["address"].isNotEmpty){
     a = data["address"].length;
     userInfoController.convertToAddress(data["address"][a-1]);
   }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
  return bgWidget(
    child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(child: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              (context.screenHeight / 7).heightBox,
              Obx(
                ()=> Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    data["imageUrl"] == "" && editContoller.profileImagePath.isEmpty
                        ? Image.asset(imgProfile2,width: 100,fit: BoxFit.cover,).box.roundedFull.clip(Clip.antiAlias).make()
                        : data["imageUrl"] != null && editContoller.profileImagePath.isEmpty
                        ? Image.network(data["imageUrl"],width: 100,fit: BoxFit.cover,).box.roundedFull.clip(Clip.antiAlias).make()
                        :Image.file(File(editContoller.profileImagePath.value),width: 100,fit: BoxFit.cover,).box.roundedFull.clip(Clip.antiAlias).make(),                10.heightBox,
                    ourButton(
                      title: change,
                      color: redColor,
                      textColor: whiteColor,
                      onpress: (){
                        editContoller.changeImage(context);

                      }
                    ),
                    20.heightBox,

                    customTextFeild(
                      controller: userInfoController.nameCon,
                      title: "Name",
                    ),
                    customTextFeild(
                      controller: userInfoController.addressCon,
                      title: "Address",
                    ),
                    customTextFeild(
                      controller: userInfoController.landmarkCon,
                      title: "Landmark",
                    ),customTextFeild(
                      controller: userInfoController.cityCon,
                      title: "City",
                    ),
                    customTextFeild(
                      controller: userInfoController.stateCon,
                      title: "State",
                    ),
                    customTextFeild(
                      controller: userInfoController.countryCon,
                      title: "Country",
                    ),
                    customTextFeild(
                      controller: userInfoController.pincodeCon,
                      title: "pincode",
                    ),
                    customTextFeild(
                      controller: userInfoController.contactNumberCon,
                      title: "Contact Number",
                    ),

                    20.heightBox,
                   userInfoController.isloading.value ? const CircularProgressIndicator():ourButton(
                      textColor: whiteColor,
                      color: redColor,
                      title: save,
                      onpress: () {
                        editContoller.uploadImage(context);
                     if(data["address"].isNotEmpty){
                       userInfoController.addAdress(data["address"][a-1]);
                     }else{
                       userInfoController.firstAdress();
                     }

                      }
                    ).box.width(context.screenWidth -75).make(),
                    20.heightBox
                  ],
                ).box.p12.white.shadow.width(context.screenWidth -60).rounded.make(),
              ),

              100.heightBox
            ],
          ),
        ),
      )
      ),
    )
  );  
  }


}