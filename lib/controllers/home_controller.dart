import 'package:ebuuy/consts/firebase_auth.dart';
import 'package:get/get.dart';

class HomeController extends GetxController{
 var currentIndex = 0.obs;
 @override
  void onInit() {
    // TODO: implement onInit
    getUserName();
    super.onInit();
  }
 var username;
 getUserName() async{
  var n = await firestore.collection(userCollection).where("id",isEqualTo: currentUser!.uid).get().then((value) {
   if(value.docs.isNotEmpty){
    return value.docs.single["name"];
   }
  });
  username = n;
 }
}