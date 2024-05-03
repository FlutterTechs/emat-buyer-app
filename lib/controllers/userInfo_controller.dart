import 'package:ebuuy/consts/consts.dart';
import 'package:ebuuy/models/userInfo_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../consts/strings.dart';
import '../models/addressmodel.dart';
class UserInfoController extends GetxController{
  var isloading = false.obs;
  var selectedValue = 1.obs;
  var nameCon = TextEditingController();
  var contactNumberCon = TextEditingController();
  var addressCon = TextEditingController();
  var landmarkCon = TextEditingController();
  var cityCon = TextEditingController();
  var stateCon = TextEditingController();
  var countryCon = TextEditingController();
  var pincodeCon = TextEditingController();
  var shipmentCon = TextEditingController();
  convertToAddress(dynamic data) async{
    print("data is :");
    print(data);
    if(data!= null && data.isNotEmpty){
      nameCon.text = data["name"];
      contactNumberCon.text =  data["contact_number"];
      landmarkCon.text = data["landmark"];
      cityCon.text = data["city"];
      addressCon.text = data["Address"];
      stateCon.text = data["state"];
      countryCon.text = data["country"];
      pincodeCon.text = data["pincode"];
      shipmentCon.text = data["shipment_type"];
    }
  }
  firstAdress() async{
    isloading(true);
    await firestore.collection(userCollection).doc(currentUser!.uid).update({
      "address":FieldValue.arrayUnion([UserAddress(
          name: nameCon.text,
          address: addressCon.text,
          city: cityCon.text,
          contactNumber: contactNumberCon.text,
          country: countryCon.text,
          landmark: landmarkCon.text,
          pincode: pincodeCon.text,
          shipmentType: shipmentCon.text,
          state: stateCon.text
      ).toJson()])
    });
    isloading(false);

  }
  addAdress(oldAddress) async{
     isloading(true);
     await firestore.collection(userCollection).doc(currentUser!.uid).update({
       "address":FieldValue.arrayRemove([oldAddress])
     });
    await firestore.collection(userCollection).doc(currentUser!.uid).update({
      "address":FieldValue.arrayUnion([UserAddress(
          name: nameCon.text,
          address: addressCon.text,
          city: cityCon.text,
          contactNumber: contactNumberCon.text,
          country: countryCon.text,
          landmark: landmarkCon.text,
          pincode: pincodeCon.text,
          shipmentType: shipmentCon.text,
          state: stateCon.text
      ).toJson()])
    });
    isloading(false);
  }


}