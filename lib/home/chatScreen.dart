import 'package:ebuuy/Services/FirebaseServices.dart';
import 'package:ebuuy/consts/colors.dart';
import 'package:ebuuy/consts/consts.dart';
import 'package:ebuuy/consts/firebase_auth.dart';
import 'package:ebuuy/controllers/chatontroller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:get/get.dart';
class ChatScreen extends StatefulWidget{
  String title;

  ChatScreen({super.key,required this.title});
  @override
  State<StatefulWidget> createState() => _chatScreen(title);

}

class _chatScreen extends State<ChatScreen>{
  var chatController;
  @override
  void initState() {
    chatController = Get.put(ChatController());
    super.initState();
  }

  String title;
  _chatScreen(this.title);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: redColor,
        titleSpacing: 0,
        title: ListTile(
          leading: CircleAvatar(backgroundColor: Colors.blue,),
          title: Text(title),
        ),
      ),
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
        Obx(
          ()=> chatController.isLoading.value? Center(child: CircularProgressIndicator(),): StreamBuilder(stream: FirebaseServices.getChatMessage(chatController.chatDocId.toString()),
              builder: (BuildContext context,AsyncSnapshot snapshot){
               if(!snapshot.hasData){
                 return CircularProgressIndicator();
               }else if(snapshot.data!.docs.isEmpty){
                 return Center(child: "No Chat Found".text.make(),);
               }
               else{
                 chatController.chatData = snapshot.data!.docs;
                 print("data is :");
                 return ListView.builder(
                   itemCount: chatController.chatData.length,
                     itemBuilder: (context,index){
                   return BubbleSpecialThree(
                     color: Colors.grey,
                       isSender: chatController.chatData[index]["sender_id"] == currentUser!.uid ? true : false,
                       text: chatController.chatData[index]["msg"]).box.margin(const EdgeInsets.only(bottom: 20)).make();
                 });
               }
              }),
        ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: EdgeInsets.only(left: 10,bottom: 10,top: 10),
              height: 60,
              width: double.infinity,
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  SizedBox(width: 15,),
                  Expanded(
                    child: TextField(
                      controller:chatController.msgController,
                      decoration: InputDecoration(
                          hintText: "Write message...",
                          hintStyle: TextStyle(color: Colors.black54),
                          border: InputBorder.none
                      ),
                    ),
                  ),
                  SizedBox(width: 15,),
                  FloatingActionButton(
                    onPressed: (){
                      setState(() {

                      });
                      chatController.sendMsg(chatController.msgController.text,
                      );
                      chatController.msgController.clear();
                    },
                    child: Icon(Icons.send,color: Colors.white,size: 18,),
                    backgroundColor: Colors.blue,
                    elevation: 0,
                  ),
                ],

              ).box.gray200.make(),
            ),
          ),
        ],
      ),    );
  }
}