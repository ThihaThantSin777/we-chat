import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';

class FCMService {
  static final FCMService _singleton = FCMService._internal();

  factory FCMService() => _singleton;

  FCMService._internal();

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  Future<Object>  getFCKToken() async {

    return messaging.getToken();
  }
}
