import 'dart:io';

import 'package:ebuuy/Widgets/bg_widget.dart';
import 'package:ebuuy/Widgets/insightsButton.dart';
import 'package:ebuuy/Widgets/ourButton.dart';
import 'package:ebuuy/consts/consts.dart';
import 'package:ebuuy/consts/firebase_auth.dart';
import 'package:ebuuy/consts/list.dart';
import 'package:ebuuy/controllers/auth_controller.dart';
import 'package:ebuuy/controllers/edit_profile_controller.dart';
import 'package:ebuuy/home/TermsandConditonScreen.dart';
import 'package:ebuuy/home/components/MyOrderScreen.dart';
import 'package:ebuuy/home/edit_profileScreen.dart';
import 'package:ebuuy/home/orderTrackScreen.dart';
import 'package:ebuuy/home/profileChat.dart';
import 'package:ebuuy/home/resetPasswordScreen.dart';
import 'package:ebuuy/views/loginScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ebuuy/Services/FirebaseServices.dart';
class ProfileScreen extends StatefulWidget {


  @override
  State<StatefulWidget> createState() => _profileScreen();
}

class _profileScreen extends State<ProfileScreen> {
  var data;
  var contoller = Get.put(AuthController());
 var editContoller = Get.put(EditProfileController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: redColor,
            body: StreamBuilder(
                stream: FirebaseServices.getUserData(auth.currentUser!.uid),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    data = snapshot.data!.docs[0];
                    print("data");
                    print(data['name']);
                    return SafeArea(
                      child: Container(
                          padding: const EdgeInsets.all(12),
                          width: double.infinity,
                          height: double.infinity,
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.centerRight,
                                child: IconButton(onPressed: () {
                                  Get.to(() => EditProfileScreen(data: data));
                                }, icon: Icon(Icons.edit)),
                              ),
                               ListTile(
                                  leading:
                                      data["imageUrl"] == "" && editContoller.profileImagePath.isEmpty
                                    ? Image.asset(imgProfile2,width: 70,fit: BoxFit.cover,).box.roundedFull.clip(Clip.antiAlias).make()
                                      : data["imageUrl"] != null && editContoller.profileImagePath.isEmpty
                                    ? Image.network(data["imageUrl"],width: 70,fit: BoxFit.cover,).box.roundedFull.clip(Clip.antiAlias).make()
                                      :Image.file(File(editContoller.profileImagePath.value),width: 70,fit: BoxFit.cover,).box.roundedFull.clip(Clip.antiAlias).make(),
                                  title: "${data['name']}".text.white.size(15).make(),
                                  subtitle: "${data['email']}".text.white.size(12).make(),
                                  trailing: OutlinedButton(
                                      style: OutlinedButton.styleFrom(
                                          side: BorderSide(
                                              color: Colors.white
                                          )
                                      ),
                                      onPressed: () {
                                        contoller.logOut(context);
                                      }, child: logout.text.white.make()),
                                ),

                                   20.heightBox,

                              //         height: context.screenHeight / 11,
                              //          width: context.screenWidth / 3.5,
                            FutureBuilder(
                                future: FirebaseServices.getCount(),
                                builder: (BuildContext context,AsyncSnapshot snapshot){
                                  if(!snapshot.hasData){
                                    return const CircularProgressIndicator();
                                  }else{
                                    var count = snapshot.data;
                                    return Row(
                                        children: [
                                          insightsButton(title:"Cart",
                                            value: count[0].toString(),
                                            width: context.screenWidth / 3.5,
                                            height: context.screenHeight / 11,),
                                          insightsButton(title: "Wishlist",
                                            value: count[1].toString(),
                                            width: context.screenWidth / 3.5,
                                            height: context.screenHeight / 11,),
                                          insightsButton(title: "Ordered",
                                            value: count[2].toString(),
                                            width: context.screenWidth / 3.5,
                                            height: context.screenHeight / 11,),
                                        ]
                                    );

                                }
                                }),
                              20.heightBox,
                             Column(
                               children: [
                                 ListTile(
                                   title: "My Order".text.make(),
                                   leading: Icon(Icons.map_outlined),
                                   onTap: (){
                                     Get.to(()=>MyOrderScreen());
                                   },
                                 ),
                                 Divider(),
                                 ListTile(
                                   title: "Notification".text.make(),
                                   leading: Icon(Icons.notifications),
                                   onTap: (){},
                                 ),
                                 Divider(),


                                 ListTile(
                                   title: "Chats".text.make(),
                                   leading: Icon(Icons.chat),
                                   onTap: (){
                                     Get.to(()=>ProfileChatScreen());
                                   },
                                 ),
                                 Divider(),
                                 ListTile(
                                   title: "Reset Password".text.make(),
                                   leading: Icon(Icons.key),
                                   onTap: (){
                                     Get.to(()=>ResetPasswordScreen(data["password"].toString(),data["email"].toString()));
                                   },
                                 ),
                                 Divider(),
                                 ListTile(
                                   title: "Terms and Conditions".text.make(),
                                   leading: Icon(Icons.policy),
                                   onTap: (){
                                     Get.to(()=>TermsAndConditionScreen());
                                   },
                                 ),
                               ],
                             ).box.white.p12.shadow.roundedSM.width(context.screenWidth - 60).make()
                            ],
                          ),
                        ),

                    );
                  } else {
                    return Center(child: CircularProgressIndicator(),);
                  }
                })
        );

  }


}
