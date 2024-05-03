import 'dart:io';

import 'package:ebuuy/consts/consts.dart';
import 'package:ebuuy/models/reviewModel.dart';
import 'package:path/path.dart';
class AddReviewController extends GetxController{
   var isLoading = false.obs;
  late final File image;
  var nameCon = TextEditingController();
  var isImage = false.obs;
  var uploadimg = "";
  var rating = "";
  var feedback = TextEditingController();
  PickImage() async{
    try{
      final img = await ImagePicker().pickImage(source: ImageSource.gallery,imageQuality: 70);
      if(img == null) return;
      image = File(img.path);
      isImage(true);
    }on PlatformException catch (e){
      Fluttertoast.showToast(msg:"Unable to get image");
    }
  }

  uploadImage(productId) async{

  }

uploadReview(productId) async{
    if(rating != "" && feedback.text != ""  && nameCon.text != "" && image != null){
      try{
        isLoading(true);
        var filename = basename(image.path);
        var destination = "Reviews/${currentUser!.uid}/$filename";
        Reference ref = FirebaseStorage.instance.ref().child(destination);
        ref.putFile(image);
        uploadimg = await ref.getDownloadURL();
         var myReview = ReviewModel(
           ratings: rating,
           customerId: currentUser!.uid.toString(),
           customerName: nameCon.text,
           feedback: feedback.text,
           date: Timestamp.now(),
           image: uploadimg
         );
        await firestore.collection(productCollection).doc(productId).update({
          "reviews": FieldValue.arrayUnion([myReview.toJson()])
        });
        isLoading(false);
        Fluttertoast.showToast(msg: "Review Added");
        Get.offAll(()=>const Home());
      }on PlatformException catch (e){
        print("error: $e");
        Fluttertoast.showToast(msg: "unable to upload image");
        isLoading(false);

      }
    }else{
      Fluttertoast.showToast(msg: "fill the items");
      isLoading(false);

    }
}
/*  await firestore.collection(productCollection).doc(productId).update({
  "reviews":
});*/

}