import 'package:ebuuy/consts/consts.dart';
import 'package:ebuuy/controllers/audioController.dart';

class SearchScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _searchScreen();
}

class _searchScreen extends  State<SearchScreen>{
  var voiceText = "";
  var speechToText = SpeechToText();
  var searchCon = TextEditingController();
  var audioController = Get.put(AudioController());
  var SearchData;
  var isListening = false;
  var data;
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 70,
        automaticallyImplyLeading: false,
        backgroundColor: redColor,
        leadingWidth: 50,
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_rounded,color: Colors.white,)),
        title: Container(
          width: 330,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5)
          ),
          child: Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(Icons.search),
                TextField(
                  controller: audioController.searchCon.value ,
                  onChanged: (val){

                    audioController.searchCon.value.text = val.toString();
                   setState(() {

                   });
                  },
                  decoration: InputDecoration(
                      hintText: "Search for product",
                  ),
                ).box.width(200).make(),
                  AvatarGlow(
                    animate: true,
                    repeat: true,
                    duration: Duration(milliseconds: 2000),
                    glowColor: redColor,
                    child: GestureDetector(
                      onTapDown: (val) async{
                        if(!isListening){
                          var available = await speechToText.initialize();
                          if(available){
                            setState(() {
                              isListening = true;
                              speechToText.listen(
                                onResult: (result){
                                  setState(() {
                                    audioController.searchCon.value.text = result.recognizedWords;
                                    audioController.voiceText.value = result.recognizedWords;
                                  });
                                }
                              );
                            });
                          }
                        }

                      },
                        onTapUp: (val){
                        setState(() {
                          isListening = false;
                        });
                        speechToText.stop();
                        },
                        child: isListening ? Icon(Icons.mic):Icon(Icons.mic_none),)
                  )
              ],
            ),
          ),
        ).onTap(() {
          Get.to(()=>SearchScreen());
        }),
      ),
      body:StreamBuilder(stream: FirebaseServices.getAllProduct(),
            builder: (BuildContext context,AsyncSnapshot snapshot){
              if(!snapshot.hasData){
                return Center(child: CircularProgressIndicator(),);
              }else if(snapshot.data!.docs.isEmpty){
                return Center(child: "No Result Found".text.make(),);
              }else{
                 data = snapshot.data!.docs;
                if(audioController.searchCon.value.text == null || audioController.searchCon.value.text == ""){
                  return Center(child: "Search Now".text.make(),);
                }
                return ListView.separated(
                    itemBuilder: (context,index){
                      if(data[index]["p_name"].toString().toLowerCase().contains(audioController.searchCon.value.text.toString().toLowerCase())){
                        return ListTile(
                          title: Text(data[index]["p_name"]),
                          trailing: const Icon(Icons.arrow_forward),
                          onTap: (){
                            Get.to(()=>ProductScreen(data: data[index], title: data[index]["sub_category"]));
                          },
                        );
                      }
                    },
                    separatorBuilder: (context,index){
                      return Divider();
                    },
                    itemCount: data.length);
              }
            }),


    );
  }

}