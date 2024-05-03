import 'package:ebuuy/consts/consts.dart';

class ReviewController extends GetxController{

  List<String> imges = [];
  var isHaveImg = false.obs;
  var rating = 1.obs;
  var feedBackCon = TextEditingController();
  uploadImage(docId) async{
    if(imges.isNotEmpty){

      Reference ref = FirebaseStorage.instance.ref().child("$docId/Reviews/${currentUser?.uid}/");
     //var uploadImg = ref.putFile();
     var reviewImage = await ref.getDownloadURL();
    }else{
      return;
    }
  }
  SubmitReview(docId) async{
    await uploadImage(docId);
    await firestore.collection(productCollection).doc(docId).update({
      "reviews":FieldValue.arrayUnion([]),
    });
  }
}