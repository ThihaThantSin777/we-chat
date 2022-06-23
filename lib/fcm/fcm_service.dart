import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:wechat_app/pages/we_chat_chatting_room_page.dart';
import 'package:wechat_app/pages/we_chat_discover_page.dart';


class FCMService {
  static final FCMService _singleton = FCMService._internal();

  factory FCMService() => _singleton;

  FCMService._internal();

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  Future<String?> getFCMToken() async {
    return messaging.getToken();
  }
  AndroidNotificationChannel channel = const AndroidNotificationChannel(
    'high importance channel',
    'High Importance Notifications',
    description: 'This channel is used for important notifications',
    importance: Importance.max,
  );

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  AndroidInitializationSettings initializationSettingsAndroid =
      const AndroidInitializationSettings('ic_launcher');

  IOSInitializationSettings initializationSettingsIOS= const IOSInitializationSettings();

  Stream onMessageOpenedApp()=>FirebaseMessaging.onMessageOpenedApp;

  Future getInitialMessage()=>messaging.getInitialMessage();


  FlutterLocalNotificationsPlugin localNotification() {
    return flutterLocalNotificationsPlugin;
  }

  void listenForMessage(GlobalKey<NavigatorState> navigatorKey) async {

    await requestNotificationPermissionForIOS();
    await turnOnIOSForegroundNotification();

    await initFlutterLocalNotification(navigatorKey);
    await registerChannel();

    FirebaseMessaging.onMessageOpenedApp.listen((remoteMessage) {
      if(remoteMessage.data['route_name']=='discover'){
        Navigator.of(navigatorKey.currentState!.context).pushReplacement(MaterialPageRoute(builder: (context){
          return const WeChatDiscoverPage();
        }));
      }else if(remoteMessage.data['route_name']=='chat'){
        Navigator.of(navigatorKey.currentState!.context).pushReplacement(MaterialPageRoute(builder: (context){
          return   WeChatChattingRoomPage(friID: remoteMessage.data['receiver_id']);
        }));
      }
    });
    messaging.getInitialMessage().then((remoteMessage) {
      if(remoteMessage!=null){
        if(remoteMessage.data['route_name']=='discover'){
          Navigator.of(navigatorKey.currentState!.context).pushReplacement(MaterialPageRoute(builder: (context){
            return const WeChatDiscoverPage();
          }));
        }else if(remoteMessage.data['route_name']=='chat'){
          Navigator.of(navigatorKey.currentState!.context).pushReplacement(MaterialPageRoute(builder: (context){
            return   WeChatChattingRoomPage(friID: remoteMessage.data['receiver_id']);
          }));
        }
      }
    });

    FirebaseMessaging.onMessage.listen((remoteMessage) {
      debugPrint('Notification Sent From Server while in foreground');
      RemoteNotification? notification = remoteMessage.notification;
      AndroidNotification? android = remoteMessage.notification?.android;

      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
                android: AndroidNotificationDetails(
                  channel.id,
                  channel.name,
                  channelDescription: channel.description,
                  icon: android.smallIcon,
                )),
            payload: remoteMessage.data['receiver_id'].toString());
      }
    });
  }

  Future requestNotificationPermissionForIOS() {
    return messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }

  Future turnOnIOSForegroundNotification() {
    return FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }
  Future initFlutterLocalNotification(GlobalKey<NavigatorState> navigatorKey) {
    final InitializationSettings initializationSettings =
    InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
      macOS: null,
    );
    return flutterLocalNotificationsPlugin.initialize(initializationSettings,onSelectNotification: (payload){
      Navigator.of(navigatorKey.currentState!.context).push(MaterialPageRoute(builder: (context){
        return   WeChatChattingRoomPage(friID: payload??'');
      }));
    });
  }

  Future? registerChannel() {
    return flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }
}
