import 'package:ebuuy/consts/consts.dart';

class AudioController extends GetxController{
  var speechToText = SpeechToText();
  var  isSpeechEnable = false;
  var searchCon = TextEditingController().obs;
  var voiceText = "".obs;
  var confidencelevel = 0;

}