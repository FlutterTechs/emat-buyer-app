import 'package:ebuuy/consts/consts.dart';

Widget Label({required String label,required String value}){
  return Container(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        "$label :".text.white.make(),
        "$value".text.underline.white.make(),
      ],
    ),
  );
}