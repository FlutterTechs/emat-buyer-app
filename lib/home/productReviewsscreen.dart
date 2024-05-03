import 'package:ebuuy/consts/consts.dart';

class ProductReviewsScreen extends StatelessWidget{
  dynamic data;
  ProductReviewsScreen(this.data);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_rounded,color: Colors.white,)),
        backgroundColor: redColor,
        title: "Reviews".text.white.bold.make(),
      ),
      backgroundColor: Colors.grey.shade200,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: data!="" ? ListView.separated(
            itemBuilder: (context,index){
              return ListTile(
                leading: Image.network(data[index]['image'].toString(),height: 100,width: 100,),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Customer : ${data[index]["customer_name"].toString()}",style: const TextStyle(
                        fontWeight: FontWeight.bold
                    ),),
                    Text("Feedback : ${data[index]["feedback"].toString()}"),
                    VxRating(onRatingUpdate: (val){},
                      isSelectable: false,
                      maxRating: 5,stepInt: true,count: 5,
                      value: double.parse(data[index]["ratings"]),)

                  ],
                ),
              ).box.white.make();
            },
            separatorBuilder:  (context,index){
             return Divider(height: 5,thickness: 4,color: Colors.grey.shade200,);
            },
            itemCount: data.length): Center(child: "No Review yet available".text.make(),)
      ),
    );
  }

}