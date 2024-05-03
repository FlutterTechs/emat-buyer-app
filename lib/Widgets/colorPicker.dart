import 'package:ebuuy/consts/consts.dart';
import 'package:flutter/material.dart';

class ColorPickerRow extends StatefulWidget {
  var availableColor;
  ColorPickerRow(this.availableColor, {super.key});
  @override
  _ColorPickerRowState createState() => _ColorPickerRowState(availableColor: availableColor);
}

class _ColorPickerRowState extends State<ColorPickerRow> {
  var productController = Get.put(ProductController());
  _ColorPickerRowState({required this.availableColor});
  var availableColor;
  List<dynamic> myColor = [];
  Color? selectedColor; // Default selected color
  @override
  Widget build(BuildContext context) {
    myColor = availableColor.map((e){
      String hexColorCode = '0x' + e.toRadixString(16).padLeft(8, '0');
      return Color(int.parse(hexColorCode));
    }).toList();
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(availableColor.length, (index) {
          print(availableColor[index]);
          return buildColorPickerButton(Color(availableColor[index]));

        })
      ),
    );
  }

  Widget buildColorPickerButton(color) {
    var bgColor;
    String colorHex = "0x"+color.value.toRadixString(16).padLeft(8, '0');
     switch(colorHex.toLowerCase()){
       case "0x00ff0000":
         bgColor = Colors.red;
         break;
       case "0x000000ff":
         bgColor = Colors.blue;
         break;
         case "0x00808080":
       bgColor = Colors.grey;
       break;
       case "0x00008000":
       bgColor = Colors.green;
       break;
       case "0x00ffffff":
         bgColor = Colors.white;
         break;
       case "0x00ffc0cb":
         bgColor = Colors.pink;
         break;
       case "0x00ffff00":
         bgColor = Colors.yellow;
         break;
       case "0x00000000":
         bgColor = Colors.black;
         break;
       case "0x0000ffff":
         bgColor = Colors.cyan;
         break;
       case "0x00a020f0":
         bgColor = Colors.purple;
         break;
         case "0x00add8e6":
       bgColor = Colors.lightBlue;
       break;
       case "0x0ffa5000":
       bgColor = Colors.orange;
       break;
       default:
         bgColor = Colors.white;
         break;
     }
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shadowColor: bgColor,
        elevation: 5,
        backgroundColor: bgColor,
        surfaceTintColor: bgColor,
        padding: EdgeInsets.all(20),
      ),
      onPressed: () {
        setState(() {
          print("Color code");
          var ourColor = "0x"+color.value.toRadixString(16).padLeft(8, '0');
          productController.productColor = ourColor;
          print("selcted Color : $ourColor");
          selectedColor = color;
        });
      },
      child: selectedColor == color ? Icon(Icons.check): Text(""),
    );
  }
}