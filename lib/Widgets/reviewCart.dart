import 'package:ebuuy/consts/consts.dart';

Widget reviewCart({String? img,String? title,String? price,onpressed,dynamic data}){
  return InkWell(
    onTap:  onpressed,
    child: Container(
      padding: EdgeInsets.all(12),
      child: Column(
        children: [
          ListTile(
            leading: Image.network(img!,height:100,width: 100,),
           title: "$title".text.bold.size(15).make(),
           subtitle: "\u20B9 $price".text.make(),
          trailing: Icon(Icons.keyboard_arrow_right),
          ),
          5.heightBox,
          data["is_order_delivered"] ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              "Review & Rating".text.make(),
              VxRating(
                isSelectable: false,
                  stepInt: true,
                  maxRating: 5.0,
                  count: 5,
                  value: 0,
                  onRatingUpdate: (val){

                  })
            ],
          ).box.green100.p4.make():
          (data["is_order_cancel"]) ?Container(
            width: double.infinity,
            padding: const EdgeInsets.all(4),
            color: Colors.redAccent,
            child: Text("order Canceled",),
          )  : (data["is_order_rejected"]) ?Container(
            width: double.infinity,
            padding: const EdgeInsets.all(4),
            color: Colors.red,
            child: Text("Rejected",),
          ) : Container(
            width: double.infinity,
           padding: const EdgeInsets.all(4),
           color: Colors.yellow.shade300,
           child: Text("Pending",),
         )
        ],
      ),
    ),
  );
}