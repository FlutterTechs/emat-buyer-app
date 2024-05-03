import 'package:ebuuy/consts/consts.dart';
import '../models/product_model.dart';

class AddToCartController extends GetxController{

   List<products> orderlist = [];

   int totalPrice = 0;
   var isCartEmpty = true.obs;

  String TotalPrice(data){
    totalPrice = 0;
      for(int i =0;i<data.length;i++){
         totalPrice += int.parse(data[i]["tprice"]);
      }
      return totalPrice.toString();
   }
}