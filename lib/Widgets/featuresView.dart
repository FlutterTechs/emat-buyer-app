import '../consts/consts.dart';

Widget Featuresview({String? key,String? val}){
  return Row(
    children: [
      Expanded(
          flex: 1,
          child: Text(key!,style: const TextStyle(
            fontWeight: FontWeight.bold
          ),
          ),
      ),
      Text(":"),
      10.widthBox,
      Expanded(
          flex: 1,
          child: Text(val!,style: const TextStyle(
              fontWeight: FontWeight.bold
          ),)),
    ],
  ).box.p8.make();
}
