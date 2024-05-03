import 'package:ebuuy/consts/consts.dart';

import '../Widgets/mainProduct.dart';

class ResultPage extends StatelessWidget{
  String productId;
  ResultPage({super.key,required this.productId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: redColor,
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back,color: Colors.white,)),
        title: "Result Page".text.white.bold.make(),
      ),
        body: FutureBuilder(future: FirebaseServices.getProductById(productId),
            builder:(BuildContext context,AsyncSnapshot snapshot){
            if(!snapshot.hasData){
               return Center(child: "No Such Product Found".text.make(),);
            }else{
              var data = snapshot.data;
               return MainProduct(
                   rating: data["p_rating"] == "" ? 0 : double.parse(data["p_rating"]),
                   title: data["p_name"].toString(),
                   img: data["p_image"][0].toString(),
                   price:data["p_price"].toString(),
                   features: data["Specification"]
               ).onTap(() {
                 Get.to(()=>ProductScreen(data: data, title: data["sub_category"].toString()));
               });
            }
    }),
    );
  }

}