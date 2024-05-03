import 'package:ebuuy/consts/consts.dart';
import 'package:ebuuy/home/brandsProductScreen.dart';

class BrandScreen extends StatelessWidget{
  const BrandScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
       appBar: AppBar(
         automaticallyImplyLeading: false,
         title: Text("Top Brands",style: TextStyle(color: Colors.white),),
         backgroundColor: redColor,
         leading: IconButton(onPressed: (){
           Navigator.pop(context);
         }, icon: Icon(Icons.arrow_back,color: Colors.white,)),
       ),
       body: FutureBuilder(
           future: FirebaseServices.GetBrands(),
           builder: (BuildContext context,AsyncSnapshot snapshot){
              if(!snapshot.hasData){
                return Center(child: CircularProgressIndicator(),);
              }else if(snapshot.data!.docs.isEmpty){
                return Center(child: "No Brands Found".text.make(),);
              } else{
                var data = snapshot.data!.docs;
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
                                   child:data[index]["name"].toString().text.bold.color(darkFontGrey).make(),
                                 ),
                                 Image.network(data[index]["img"].toString(),height: 120,width: 200,fit: BoxFit.cover,),

                               ],
                             ).box.white.shadow.roundedSM.make().onTap(() {
                              Get.to(()=>BrandsProductScreen(data: data[index]));
                             });
                           }),
                     ),
                   ],
                 ),
               );
              }           
           }),
    );
  }
  
}