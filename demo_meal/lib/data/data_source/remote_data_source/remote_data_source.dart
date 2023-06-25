import 'dart:convert';
import 'package:demo_meal/utils/app_constansts.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class RemoteDataSource {
//get data from firebase collections
  Future<List<Map<String, dynamic>>> getDataCollection(String path) async {
    // make reference to data endpoint
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection(path);
    // get data
    QuerySnapshot querySnapshot = await collectionReference.get();
    print("query snapshot is =>");
    print(querySnapshot);

    // get exact data from the response
    List<Map<String, dynamic>> dataList = [];
    querySnapshot.docs.forEach((DocumentSnapshot document) {
      //print("recieved data is =>"+document.data().toString());
      dataList.add(document.data() as Map<String, dynamic>);
    });

    /*  print("Data is =>");
print(dataList);*/
    return dataList;
  }
//get Data from firebase Documentation
  getDataDocumentation(String collectionPath, String documentId) async {
    CollectionReference data =
        FirebaseFirestore.instance.collection(collectionPath);
    var datafetched = await data.doc(documentId).get();
    print("data is => " + datafetched.data().toString());
    return datafetched.data() as Map<String, dynamic>;
  }
// add document to specific collection with Id generated at app
  addDataDocument(String collectionPath, dynamic data) async {
    print('reached => ' + data.toString());
    final collectionReference =
        FirebaseFirestore.instance.collection(collectionPath);
    final documentReference = collectionReference.doc(data['id']);
    await documentReference.set(data);
  }
// update special field in many documents at specific collection
  updateDocumentAttribute(String collectionPath, List<String> documentIds,
      String attributeName, String newValue) async {
    final collectionReference =
        FirebaseFirestore.instance.collection(collectionPath);
    // check if documents exist and then update
    for (final documentId in documentIds) {
      final documentReference = collectionReference.doc(documentId);
      final documentSnapshot = await documentReference.get();

      if (documentSnapshot.exists) {
        final data = documentSnapshot.data();
        data![attributeName] = newValue;
        await documentReference.update(data);
      }
    }
  }

  signIn(String email, String password) async {
    try {
      UserCredential cerdintial = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      print(e);
    }
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  // send notification to one or more devices at the same time
  Future<void> sendPushNotification(String title, String body, List<String> deviceTokens) async {
    // key for the firebase messaging service
    final serverKey = 'AAAA05iK2IE:APA91bGSAPbkQzRPP1iVNLzlqQoNX4HahR37T7Y8xaEztuQUxpduMTADEDD2sHpkdRmsz55x_qTzTlFg-DCD1HvJ1Myxp1eudCmwJKzhAbjcoEgz5nEMB8Sc7yDazw7-5i4vnpG_4H4n'; // Replace with your FCM server key

    final url = Uri.parse('https://fcm.googleapis.com/fcm/send');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'key=$serverKey',
    };

    final data = {
      'notification': {
        'title': title,
        'body': body,
      },
      'registration_ids': deviceTokens,
    };

     await http.post(url,headers: headers, body: jsonEncode(data));


  }


  //// notification services///
  /*
  when app in background or terminated it  notification appear from server directly
  but if app is in foreground we will need to use flutter local notification plugin
  */
  // make android channel to recieve notification
  final androidChannel = const AndroidNotificationChannel(
      "high_importance_channel", "High Importance Notifications",
      description: "This Channel is used for important notification",
      importance: Importance.defaultImportance);

  final localNotification = FlutterLocalNotificationsPlugin();
  final firebaseMessaging = FirebaseMessaging.instance;

  Future initLocalNotification() async {
    const android = AndroidInitializationSettings('mipmap/ic_launcher');
    const settings = InitializationSettings(android: android);
    await localNotification.initialize(settings);
    final platform=localNotification.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
    await platform?.createNotificationChannel(androidChannel);
  }
  // function that init notification service in the device and get permission
  Future<void> initNotifications() async {
    await firebaseMessaging.requestPermission();
    final fcmToken = await firebaseMessaging.getToken();
    await addDataDocument(AppConstants.notificationTokens, {'token':fcmToken.toString()});
    print("token is =>" + fcmToken.toString());
    initPushNotifications();
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    initPushNotifications();
    initLocalNotification();

  }

  Future initPushNotifications() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    FirebaseMessaging.onMessage.listen((message) {
      // extract notification
      final notification=message.notification;
      if(notification==null)
        return;
      // if there is notification start your one
      localNotification.show(notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(android: AndroidNotificationDetails(
            androidChannel.id,
            androidChannel.name,
            channelDescription: androidChannel.description,
            icon:'mipmap/ic_launcher'
        )
        ),
      );

    });

  }
}
// control what should appear when app not in foreground
Future<void> handleBackgroundMessage(RemoteMessage message) async {
  print('Title: ${message.notification?.title}');
  print('Title: ${message.notification?.body}');
  print('Title: ${message.data}');
}
