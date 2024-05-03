import 'package:ebuuy/consts/consts.dart';
import 'package:ebuuy/controllers/qrController.dart';
import 'package:ebuuy/home/searchScreen.dart';

class FeaturedProductsScreen extends StatelessWidget{
  dynamic data;
  FeaturedProductsScreen(this.data);
  @override
  Widget build(BuildContext context) {
    var productController = Get.put(ProductController());
    var qrController =  Get.put((QrController()));
    return Scaffold(
      backgroundColor: redColor,
      appBar:AppBar(
        toolbarHeight: 70,
        automaticallyImplyLeading: false,
        backgroundColor: redColor,
        title: Container(
          width: 330,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5)
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Icon(Icons.search),
              TextField(
                enabled: false,
                decoration: InputDecoration(
                    hintText: "Search for product"
                ),
              ).box.width(200).make(),
              Icon(Icons.qr_code_scanner),
              Icon(Icons.mic),
            ],
          ),
        ).onTap(() {
          Get.to(()=>SearchScreen());
        }),
        actions: [
          IconButton(onPressed: (){
            qrController.scanQR();
          }, icon:const Icon(Icons.qr_code_scanner_outlined,color: Colors.white,),
          ),
          20.widthBox
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: GridView.builder(
          scrollDirection: Axis.vertical,
            itemCount: data.length,
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisExtent: 250,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              crossAxisCount:2,
            ),
            itemBuilder:(context,index){
              return productCart(
                  title: data[index]["p_name"],
                  image: data[index]["p_image"][0],
                  price: data[index]["p_price"]
              ).onTap(() {
                productController.getFav(data[index]["wishlist"]);
                Get.to(()=> ProductScreen(data: data[index],title: "${data[index]["sub_category"]}",));
              });
            }),
      ),
    );
  }

}