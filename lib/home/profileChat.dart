
import 'package:ebuuy/consts/consts.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../controllers/chatontroller.dart';
class ProfileChatScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _chatScreen();

}

class _chatScreen extends State<ProfileChatScreen>{
  String getTime(time){
    var date = DateTime.fromMicrosecondsSinceEpoch(time.microsecondsSinceEpoch);
    var orderdate = DateFormat("hh:mm a").format(date);
    return orderdate;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        appBar: AppBar(
          title: "Sellers Chat".text.bold.white.make(),
          backgroundColor: redColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)
          ),
        ),
        body: StreamBuilder(stream: FirebaseServices.GetAllChats(),
            builder:(BuildContext context,AsyncSnapshot snapshot){
              if(!snapshot.hasData){
                return Center(child: CircularProgressIndicator(),);
              }else if(snapshot.data!.docs.isEmpty){
                return Center(child: "No Chats Available".text.make(),);
              } else{
                var data = snapshot.data!.docs;
                return ListView.separated(
                  itemCount: data.length,
                  itemBuilder: (context,index){
                    return ListTile(
                        onTap: (){
                         Get.to(()=>ChatScreen(title:"${data[index]["friend_name"]}"),arguments: [data[index]["friend_name"],data[index]["toId"],data[index]["product_id"]]);
                        },
                        leading: CircleAvatar(backgroundColor: Colors.grey,child: Icon(Icons.person),),
                        title: data[index]["friend_name"].toString().text.bold.make(),
                        subtitle: StreamBuilder(
                            stream: FirebaseServices.getLastMsg(docIds:data[index].id ,
                                lastMsgId: data[index]["lastId"].toString()),
                            builder: (BuildContext context,AsyncSnapshot snapshot){
                              if(!snapshot.hasData){
                                return SizedBox();
                              }else{
                                var msg = snapshot.data;
                                return Text(msg["msg"].toString());
                              }
                            }),
                       trailing: Text(getTime(data[index]["lastMsgTime"]))
                    );

                  }, separatorBuilder: (BuildContext context, int index) {
                  return Divider();
                },);
              }
            })
    );
  }
}