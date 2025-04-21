import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:project/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project/screens/Article_view.dart';

class ApiService {
  final Dio _dio = Dio();

  Future<Response> getData(String path) async {
    return await _dio.get(path);
  }
}

class FirebaseService {
  // Create an instance of Firebase Messaging
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  // Function to initialize notifications
  Future<void> initNotification() async {
    // Request notification permission from user
    await _firebaseMessaging.requestPermission();

    // Fetch the FCM token for this device used in the app
    final String? FCMtoken = await _firebaseMessaging.getToken();

    // Print the FCM token (device token you would send to your server)
    log('FCM token: $FCMtoken');

    if (FCMtoken != null) {
      DocumentReference userRef = FirebaseFirestore.instance
          .collection('users')
          .doc(FCMtoken);
      try {
        await userRef.set({
          'fcmToken': FCMtoken,
          'lastUpdated': FieldValue.serverTimestamp(),
        }, SetOptions(merge: true));

        print('FCM token stored in Firestore under userToken document.');
      } catch (e) {
        print('Error storing FCM token: $e');
      }
    } else {
      print('Failed to get FCM token');
    }
    initPushNotifications();
  }

  // Function to handle received messages
  void handleNotification(RemoteMessage? message) {
    if (message == null) return;

    final String? url = message.data['link'];

    if (url != null && url.isNotEmpty) {
      navigatorKey.currentState?.push(
        MaterialPageRoute(builder: (context) => ArticleView(blogUrl: url)),
      );
    }
  }

  //function to handle foreground and background settings
  Future initPushNotifications() async {
    FirebaseMessaging.instance.getInitialMessage().then(handleNotification);

    FirebaseMessaging.onMessageOpenedApp.listen(handleNotification);
  }
}
