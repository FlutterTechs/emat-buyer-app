import 'package:ebuuy/consts/consts.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:io';
class NotificationService{
  final  _notificationPlugin = FlutterLocalNotificationsPlugin();
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  void requestPermission()async{
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true
    );

    if(settings.authorizationStatus == AuthorizationStatus.authorized){
      if (kDebugMode) {
        print("User Granted Permission");
      }
    }
    else if(settings.authorizationStatus == AuthorizationStatus.provisional){
      if (kDebugMode) {
        print("User Granted Promission permission");
      }
    }else{
      if (kDebugMode) {
        print("User denied permission");
      }
    }
  }

  Future<String?> getDeviceToken() async{
   String? token = await messaging.getToken();
   if (kDebugMode) {
     print(token);
   }
   return token;
  }

  void isTokenRefresh() async{
    messaging.onTokenRefresh.listen((event) {
      event.toString();
    });
  }

  void firebaseInit(BuildContext context){
    FirebaseMessaging.onMessage.listen((event) {
      if (kDebugMode) {
        print(event.notification?.title.toString());
        print(event.notification?.body.toString());
      }
      if(Platform.isAndroid){
      initlocal(context, event);
      showNotification(event);
      }else{
        showNotification(event);
      }

    });
  }

  Future<void> setInteractMessage(BuildContext context) async{
    RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    if(initialMessage != null){
      handleMessage(context,initialMessage);
    }
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      handleMessage(context, event);
    });
  }

  void handleMessage(BuildContext context,RemoteMessage message){
    if(message.data["type"] == "msg"){
      Get.to(()=>Home());
    }
  }



  void initlocal(BuildContext context,RemoteMessage message) async{
    var androidInitializationSettings = const AndroidInitializationSettings("@mipmap/ic_launcher");
    var iosInitializationSettings = const DarwinInitializationSettings();

    var InitlizationSettings = InitializationSettings(
      iOS: iosInitializationSettings,
      android: androidInitializationSettings
    );

    await _notificationPlugin.initialize(
        InitlizationSettings,
      onDidReceiveNotificationResponse: (payload){

      }
    );

  }

  Future<void> showNotification(RemoteMessage message) async{
    AndroidNotificationChannel channel = AndroidNotificationChannel(
        "200",
        "chats",
        importance: Importance.max);

    AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
      channel.id.toString(),
      channel.name.toString(),
      channelDescription: "demo",
      importance: Importance.high,
      priority: Priority.high,
      ticker: "Ticker"
    );

    DarwinNotificationDetails darwinNotificationDetail = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentBanner: true,
      presentList: true,
      presentSound: true
    );


    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: darwinNotificationDetail
    );

    Future.delayed(Duration.zero,(){
      _notificationPlugin.show(
          0,
          message.notification?.title.toString(),
          message.notification?.body.toString(),
          notificationDetails);
    });

  }




}