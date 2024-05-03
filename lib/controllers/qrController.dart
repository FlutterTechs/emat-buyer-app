import 'package:ebuuy/consts/consts.dart';
import 'package:ebuuy/home/resultPage.dart';
import 'package:get/get.dart';

class QrController extends GetxController{
  var scanBarcode = "".obs;
  Future<void> scanQR() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
    print("datas of qr");
    print(barcodeScanRes);
     if(barcodeScanRes != null && barcodeScanRes != "" && barcodeScanRes != "-1"){
       scanBarcode.value = barcodeScanRes;
       Get.to(()=>ResultPage(productId: scanBarcode.value));
     }else{
       Get.back();
     }
  }

}