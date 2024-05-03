import 'package:ebuuy/consts/consts.dart';
import 'package:ebuuy/home/reviewScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:order_tracker/order_tracker.dart';
class OrderTrackScreen extends StatefulWidget{
  dynamic data;
  OrderTrackScreen({super.key,this.data});
  @override
  // ignore: no_logic_in_create_state
  State<StatefulWidget> createState() => _orderTrackScreen(data);

}

class _orderTrackScreen extends State<OrderTrackScreen>{
  dynamic data ;
  _orderTrackScreen(this.data);
  List<TextDto> orderList = [
    TextDto("Your order has been placed",""),
    TextDto("Seller has processed your order", ""),

  ];

  List<TextDto> shippedList = [
    TextDto("Your order has been shipped", ""),
  ];

  List<TextDto> outOfDeliveryList = [
    TextDto("Your order is out for delivery", ""),
  ];

  List<TextDto> deliveredList = [
    TextDto("Your order has been delivered", ""),
  ];
  @override
  Widget build(BuildContext context) {
    var orderController = Get.put(OrderController());
    if(data["is_order_delivered"]){
     orderController.incressSelles(data["product_id"].toString());
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: redColor,
        title: "Order Tracking".text.white.make(),
        automaticallyImplyLeading: false,
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back,color: Colors.white,)),
      ),
      backgroundColor: Colors.white,
      body: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        children: [
          data["is_order_delivered"] ?
              TextButton(onPressed: (){
                Get.to(()=>ReviewScreen(data["product_id"].toString()));
              }, child: Text("Add a Review"))
              : SizedBox(),
            ListTile(
              title: Text("Product Image"),
              trailing: Container(height: 50, width: 50,child: Image.network(data["img"].toString()),),
            ),
            ListTile(
              title: Text("Product Name"),
              trailing: Text(data["order_name"].toString(),maxLines: 3,).box.width(100).make(),
            ),
            ListTile(
                title: Text("Total Price :"),
                trailing: Text(
                  data["total_price"].toString(),
                )),
            ListTile(
                title: Text("Quantity :"),
                trailing: Text(
                  data["total_qty"].toString(),
                )),
            ListTile(
                title: Text("Payment Method:"),
                trailing: Text(
                  data["payment_method"].toString(),
                )),
            ListTile(
                title: Text("Shipment Type:"),
                trailing: Text(
                  data["shipment_type"].toString(),
                )),
          ListTile(
              title: Text("Order ID:"),
              trailing: Text(
                data.id.toString(),
              )),
            Divider(),
            Text(
              "Address",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            Text(
              "${data["order_by_address"]}, ${data["order_by_landmark"]},"
                  "${data["order_by_city"]} - ${data["order_by_pincode"]},"
                  "${data["order_by_state"]},${data["order_by_country"]}"
            ),
            Divider(),
            ListTile(
              title: Text("OTP :"),
              trailing: data["otp"] == ""? "Not yet".text.make():Text(data["otp"].toString()),
            ),
            Container(
              width: double.infinity,
              child: data["is_order_cancel"] ? "Order canceled".text.red700.make() :ElevatedButton(
                  onPressed: () {
                    orderController.cancelOrder(data.id.toString());
                  }, child: Text("Cancel Order")),
            ),
            Divider(),
           OrderTracker(
             status: data["is_order_delivered"] ? Status.delivered : (data["is_order_on_delivery"] ? Status.outOfDelivery : (data["is_order_ready"] && data["is_order_on_delivery"] ? Status.shipped : Status.order)),
             activeColor: Colors.green,
             inActiveColor: Colors.grey[300],
             orderTitleAndDateList: orderList,
             shippedTitleAndDateList: shippedList,
             outOfDeliveryTitleAndDateList: outOfDeliveryList,
             deliveredTitleAndDateList: deliveredList,
           ).box.make(),
        ]
      ).box.p12.make(),
    );
  }

}
