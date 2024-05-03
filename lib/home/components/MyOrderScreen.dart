import 'package:ebuuy/consts/consts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Widgets/reviewCart.dart';
import '../orderTrackScreen.dart'; // Import GetX package

class MyOrderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: redColor,
        title: Text("My Orders", style: TextStyle(color: Colors.white)),
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
      ),
      body: FutureBuilder(
        future: FirebaseServices.OrderTracking(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.data!.docs.isEmpty) {
            return Center(child: Text("No Data Found"));
          } else {
            var data = snapshot.data!.docs;
            return ListView.separated(
              scrollDirection: Axis.vertical,
              physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                print(data[index].id);
                return reviewCart(
                  title: data[index]["order_name"],
                  price: data[index]["total_price"],
                  img: data[index]["img"],
                  data: data[index],
                  onpressed: () {
                    Get.to(() => OrderTrackScreen(data: data[index]));
                  },
                );
              },
              separatorBuilder: (context, index) => const Divider(),
              itemCount: data.length,
            ).box.white.make();
          }
        },
      ),
    );
  }
}