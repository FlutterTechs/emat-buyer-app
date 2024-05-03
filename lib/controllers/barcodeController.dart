import 'package:ebuuy/consts/consts.dart';

class BarcodeController extends GetxController{

  var result = "";
  Future<void> SimpleBarcode() async{
    result = await FlutterBarcodeScanner.scanBarcode(
        "#ff6666",
        "Cancel",
        true,
        ScanMode.QR);
  }
}