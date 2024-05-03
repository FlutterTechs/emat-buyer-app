import 'package:ebuuy/consts/consts.dart';
import 'package:ebuuy/home/brandsProductScreen.dart';
import 'package:ebuuy/home/sellerProductScreen.dart';

class TopSellerScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: redColor,
      appBar: AppBar(
        backgroundColor: redColor,
        automaticallyImplyLeading: false,
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: const Icon(Icons.arrow_back_rounded,color: Colors.white,)),
        title: "Top Sellers".text.white.bold.make(),
      ),
      body: FutureBuilder(future: FirebaseServices.getSeller(),
          builder: (BuildContext context,AsyncSnapshot snapshot){
          if(!snapshot.hasData){
             return Center(child: CircularProgressIndicator(),);
          }else if(snapshot.data!.docs.isEmpty){
            return Center(child: "No Data Found".text.make(),);
          }else{
            var data = snapshot.data.docs;
            return  Container(
            padding: const EdgeInsets.all(12),
            child: Column(
               children: [
               Expanded(
                     flex: 1,
          child: GridView.builder(
          scrollDirection: Axis.vertical,
          itemCount: data.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisExtent: 200,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12),
          itemBuilder: (context,index){
          return Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Padding(padding: const EdgeInsets.all(12),
          child: data[index]["name"].toString().text.bold.color(darkFontGrey).make(),
          ),
          Image.network(data[index]["logo"],height: 120,width: 200,fit: BoxFit.cover,),

          ],
          ).box.white.shadow.roundedSM.make().onTap(() {
            Get.to(()=>SellerProductScreen(data: data[index]));
          });
          }),
          ),
          ],
          ),
          );
          }
          })
    );
  }

}