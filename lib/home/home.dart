
import 'package:ebuuy/Services/notificationService.dart';
import 'package:ebuuy/consts/colors.dart';
import 'package:ebuuy/consts/consts.dart';
import 'package:ebuuy/consts/firebase_auth.dart';
import 'package:ebuuy/consts/list.dart';
import 'package:ebuuy/controllers/home_controller.dart';
import 'package:ebuuy/controllers/qrController.dart';
import 'package:ebuuy/home/searchScreen.dart';
import 'package:ebuuy/views/loginScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatefulWidget{
  const Home({super.key});
  @override
  State<StatefulWidget> createState() => _home();

}

class _home extends State<Home>{

  NotificationService notificationService = NotificationService();
  @override
  void initState() {
    super.initState();
    notificationService.requestPermission();
   var token =  notificationService.getDeviceToken();
   notificationService.firebaseInit(context);
   notificationService.setInteractMessage(context);
   if (kDebugMode) {
     print(token);
   }
   if(currentUser == null){
      Get.offAll(()=> LoginScreen());
    }

  }
 var Controller = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    var qrController = Get.put(QrController());
    return Scaffold(
      appBar:AppBar(
        toolbarHeight: 70,
        automaticallyImplyLeading: false,
        backgroundColor: redColor,
        title: Container(
          width: 330,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5)
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Icon(Icons.search),
              TextField(
                enabled: false,
                decoration: InputDecoration(
                    hintText: "Search for product"
                ),
              ).box.width(200).make(),
              Icon(Icons.qr_code_scanner),
              Icon(Icons.mic),
            ],
          ),
        ).onTap(() {
          Get.to(()=>SearchScreen());
        }),
        actions: [
          IconButton(onPressed: (){
            qrController.scanQR();
          }, icon:const Icon(Icons.qr_code_scanner_outlined,color: Colors.white,),
          ),
          20.widthBox
        ],
      ),

      body: Column(
        children: [
         Obx(
          () => Expanded(
                  child: navBody.elementAt(Controller.currentIndex.value),
                ),
          ),

        ],
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          selectedItemColor: redColor,
          selectedLabelStyle:const TextStyle(fontFamily: semibold),
          backgroundColor: whiteColor,
          type: BottomNavigationBarType.fixed,
          items: navbarItem,
          currentIndex: Controller.currentIndex.value,
          onTap: (index){
            Controller.currentIndex.value = index;
          },
        ),
      ),

    );
  }
}