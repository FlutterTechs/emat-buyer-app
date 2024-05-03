import 'dart:ffi';

import 'package:ebuuy/consts/consts.dart';
import 'package:ebuuy/controllers/addreviewController.dart';

class ReviewScreen extends StatelessWidget{
  String productId;
  ReviewScreen(this.productId);
  @override
  Widget build(BuildContext context) {
    var reviewController = Get.put(AddReviewController());
    print(productId);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: redColor,
        title: "Review & Feedback".text.white.make(),
        automaticallyImplyLeading: false,
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: const Icon(Icons.arrow_back)),
      ),
      body: Obx(
          () => reviewController.isLoading.value ? Center(
            child: CircularProgressIndicator(),
          ) :  Container(
          padding: const EdgeInsets.all(12),
          child: SingleChildScrollView(
             scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customTextFeild(
                  controller: reviewController.nameCon,
                  title: "Customer Name",
                  hint: "Enter Your name"
                ),
                "Add Images".text.make(),
              Obx(() =>
              reviewController.isImage.value ? Container(
                color: Colors.brown,
                child: Image.file(reviewController.image),
              ) :  Container(
                width: double.infinity,
                height: 100,
                color: Colors.grey,
                child: IconButton(onPressed: (){
                  reviewController.PickImage();
                }, icon: Icon(Icons.add)),
              ),),
                10.heightBox,
                "Add Feedback".text.make(),
                TextField(
                  controller: reviewController.feedback,
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText: "Your Feedback and review of this product",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 1)
                    )
                  ),
                ),
                10.heightBox,
                "Give Ratings".text.make(),
                 VxRating(onRatingUpdate: (val){
                   double a = double.parse(val);
                   int b = a.floor() + 1;
                   reviewController.rating = b.toString();
                   print(reviewController.rating);
                 },
                   size: 50,
                   value: 1,
                   count: 5,
                   stepInt: true,
                   maxRating: 5.0,
                 )
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: "Upload Review".text.white.bold.makeCentered().box.color(redColor).size(
          double.infinity,
          50).make().onTap(() {
        reviewController.uploadReview(productId);
      }),
    );
  }

}