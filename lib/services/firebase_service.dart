// import 'dart:convert';

// import 'package:firebase_messaging/firebase_messaging.dart';
// import '../../main.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// class FirebaseService {
//   final _firebaseMessaging = FirebaseMessaging.instance;
//   var _androidNotificationChannel = AndroidNotificationChannel(
//     'hellohome',
//     'hellohome_bell_notification',
//     description: 'This is notification for hellohome bell',
//     importance: Importance.defaultImportance,
//   );

//   final _localNotification = FlutterLocalNotificationsPlugin();

//   Future<void> initNotifications() async {
//     await _firebaseMessaging.requestPermission();
//     final fcmToken = await _firebaseMessaging.getToken();
//     print("Token $fcmToken");
//     initPushNotifications();
//     initLocalNotification();
//   }

//   Future<void> handleBackgroundMessage(RemoteMessage message) async {
//     if (message != null) {
//       print('Title: ${message.notification?.title}');
//       print('Body: ${message.notification?.body}');
//       print('Title: ${message?.data}');
//     }
//   }

//   void handleMessage(RemoteMessage? message) {
//     if (message == null) return;

//     // navigatorKey.currentState
//     //     ?.pushNamed(MyFlowerpotPage.route, arguments: message);
//   }

//   Future initLocalNotification() async {
//     const AndroidInitializationSettings initializationSettingsAndroid =
//         AndroidInitializationSettings('app_icon');

//     /// Note: permissions aren't requested here just to demonstrate that can be
//     /// done later
//     final IOSInitializationSettings initializationSettingsIOS =
//         IOSInitializationSettings(
//       requestAlertPermission: true,
//       requestBadgePermission: true,
//       requestSoundPermission: true,
//       // onDidReceiveLocalNotification:
//       //     (int id, String title, String body, String payload) async {
//       // didReceiveLocalNotificationSubject.add(ReceivedNotification(
//       //     id: id, title: title, body: body, payload: payload
//       // ));
//       // }
//     );
//     final InitializationSettings initializationSettings =
//         InitializationSettings(
//             android: initializationSettingsAndroid,
//             iOS: initializationSettingsIOS);

//     await _localNotification.initialize(initializationSettings,
//         onSelectNotification: (payload) {
//       final message = RemoteMessage.fromMap(jsonDecode(payload!));
//       handleMessage(message);
//     });

//     final platform = _localNotification.resolvePlatformSpecificImplementation<
//         AndroidFlutterLocalNotificationsPlugin>();

//     await platform?.createNotificationChannelGroup(
//         AndroidNotificationChannelGroup(
//             _androidNotificationChannel.id, _androidNotificationChannel.name));
//   }

//   Future initPushNotifications() async {
//     await FirebaseMessaging.instance
//         .setForegroundNotificationPresentationOptions(
//             alert: true, badge: true, sound: true);

//     FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
//     FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
//     // FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
//     FirebaseMessaging.onMessage.listen((message) {
//       final notification = message.notification;
//       if (notification == null) return;
//       _localNotification.show(
//           notification.hashCode,
//           notification.title,
//           notification.body,
//           NotificationDetails(
//             android: AndroidNotificationDetails(
//               _androidNotificationChannel.id,
//               _androidNotificationChannel.name,
//               channelDescription: _androidNotificationChannel.description,
//               ticker: 'ticker',
//               icon: 'app_icon',
//             ),
//             iOS: IOSNotificationDetails(),
//           ),
//           payload: jsonEncode(message.toMap()));
//     });
//   }
// }
