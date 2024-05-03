import 'package:ebuuy/consts/consts.dart';

class ReviewModel {
String? customerId;
String? customerName;
Timestamp? date;
String? image;
String? feedback;
String? ratings;

ReviewModel({this.customerId, this.customerName, this.date,this.feedback, this.image, this.ratings});

ReviewModel.fromJson(Map<String, dynamic> json) {
customerId = json['customer_id'];
customerName = json['customer_name'];
date = json['date'];
image = json['image'];
ratings = json['ratings'];
feedback = json["feedback"];
}

Map<String, dynamic> toJson() {
final Map<String, dynamic> data = new Map<String, dynamic>();
data['customer_id'] = this.customerId;
data['customer_name'] = this.customerName;
data['date'] = this.date;
data['image'] = this.image;
data['ratings'] = this.ratings;
data["feedback"] = this.feedback;
return data;
}
}