import 'package:ebuuy/consts/consts.dart';

import 'categories_detailsScreen.dart';

class TopCategoryScreen extends StatelessWidget{
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
        title: "Top Categories".text.white.bold.make(),
      ),
      body: Container(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: GridView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: 9,
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
                          child:categoriesNameList[index].text.bold.color(darkFontGrey).make(),
                        ),
                        Image.asset(categoriesImageList[index],height: 120,width: 200,fit: BoxFit.cover,),

                      ],
                    ).box.white.shadow.roundedSM.make().onTap(() {
                      Get.to(()=> CategoriesSetailsScreen(title: categoriesNameList[index],));

                    });
                  }),
            ),
          ],
        ),
      ),
    );
  }

}