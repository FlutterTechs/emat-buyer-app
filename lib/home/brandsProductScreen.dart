import 'package:ebuuy/consts/consts.dart';

class BrandsProductScreen extends StatefulWidget{
 dynamic data;
 BrandsProductScreen({super.key, required this.data});
  @override
  State<StatefulWidget> createState() => _brandsProductScreen(data: data);

}

class _brandsProductScreen extends State<BrandsProductScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  dynamic data;
  _brandsProductScreen({required this.data});
  @override
  Widget build(BuildContext context) {
    var productController = Get.find<ProductController>();
    return bgWidget(child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
           title: data["name"].toString().text.white.fontFamily(bold).make(),
          leading: IconButton(onPressed: (){
            Navigator.pop(context);
          }, icon: Icon(Icons.arrow_back,color: Colors.white,)),
        ),
        body: FutureBuilder(
            future: FirebaseServices.GetVendorProduct(data["vendor_id"]),
            builder: (BuildContext context,AsyncSnapshot snapshot){
              if(!snapshot.hasData){
                return Center(child: CircularProgressIndicator(),);
              }else if(snapshot.data!.docs.isEmpty){
                return Center(child: Text("No Data Found"),);
              }else{
                var data = snapshot.data!.docs;
                return SafeArea(
                  top: true,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      children: [
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: List.generate(productController.subcat.length, (index) {
                              print("Lenght");
                              print(productController.subcat.length);
                              return "${productController.subcat[index]}".text.color(darkFontGrey).fontFamily(semibold).makeCentered().box.size(120, 60).roundedSM.white.margin(const EdgeInsets.symmetric(horizontal: 4)).make();
                            }),
                          ),
                        ),
                        20.heightBox,
                        Expanded(
                          child: Container(
                            child: GridView.builder(
                                itemCount: data.length,
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  mainAxisExtent: 250,
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 8,
                                  crossAxisSpacing: 8,
                                ),
                                itemBuilder: (context,index){
                                  return productCart(
                                      title: data[index]["p_name"],
                                      image: data[index]["p_image"][0],
                                      price: data[index]["p_price"]
                                  ).onTap(() {
                                    productController.getFav(data[index]["wishlist"]);
                                    Get.to(()=> ProductScreen(data: data[index],title: "${data[index]["p_name"]}",));
                                  });
                                }),
                          ),
                        )

                      ],
                    ),
                  ),
                );
              }
            })
    ));
  }
}