import 'dart:io';

import 'package:ebuuy/consts/consts.dart';
import 'package:ebuuy/consts/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
class EditProfileController extends GetxController{
var profileImagePath = "".obs;
var profileImageLink = "".obs;

changeImage(context) async{
  try{
    final img = await ImagePicker().pickImage(source: ImageSource.gallery,imageQuality: 70);
    if(img == null) return;
    profileImagePath.value = img!.path;
  }on PlatformException catch (e){
    VxToast.show(context, msg:"Unable to Take Image");
  }

}

uploadImage(context) async{
  try{
    var filename = basename(profileImagePath.value);
    var destination = "Images/${currentUser!.uid}/$filename";
    Reference ref = FirebaseStorage.instance.ref().child(destination);
    ref.putFile(File(profileImagePath.value));
    profileImageLink.value = await ref.getDownloadURL() ;
    await firestore.collection(userCollection).doc(currentUser!.uid).update({
      "imageUrl":profileImageLink.value
    });
  }on PlatformException catch (e){
    VxToast.show(context, msg: "Unable to upload Image");
  }
}

updateProfile({name,password,imageUrl,context}) async{
  try{
    var store = firestore.collection(userCollection).doc(currentUser!.uid);
    print("in store");
    await store.update({
      "name":name,
      "imageUrl":imageUrl.toString(),
      "password":password
    });
    print("in store set");
  }catch(e){
    print("Error :"+e.toString());
  }
}
}