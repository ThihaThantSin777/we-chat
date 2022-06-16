import 'package:firebase_messaging/firebase_messaging.dart';

class FCMService {
  static final FCMService _singleton = FCMService._internal();

  factory FCMService() => _singleton;

  FCMService._internal();

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  Future<String?> getFCMToken()async{
    return messaging.getToken();
  }
}
