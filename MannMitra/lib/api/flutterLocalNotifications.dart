// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:timezone/timezone.dart' as tz;
// import 'package:timezone/data/latest.dart' as tzdata;

// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//     FlutterLocalNotificationsPlugin();

// // Future<void> handleBackgroundMessage(RemoteMessage message) async {
// //   print('Title : ${message.notification?.title}');
// //   print('Body : ${message.notification?.body}');
// //   print('Payload : ${message.data}');
// // }

// class FlutterLocalNotifications {
//   Future<void> initializeNotifications() async {
//     const AndroidInitializationSettings initializationSettingsAndroid =
//         AndroidInitializationSettings('@mipmap/ic_launcher');
//     final InitializationSettings initializationSettings =
//         InitializationSettings(android: initializationSettingsAndroid);
//     await flutterLocalNotificationsPlugin.initialize(initializationSettings);
//   }

//   Future<void> scheduleDailyNotifications() async {
//     tzdata.initializeTimeZones();
//     tz.setLocalLocation(
//         tz.getLocation('Asia/Kolkata')); // Replace with your time zone

//     await flutterLocalNotificationsPlugin
//         .cancelAll(); // Clear existing notifications

//     // Morning Notification
//     await _scheduleMorningNotification();

//     // Night Notification
//     await _scheduleNightNotification();
//   }

//   Future<void> _scheduleMorningNotification() async {
//     final AndroidNotificationDetails androidPlatformChannelSpecificsMorning =
//         AndroidNotificationDetails(
//       'morning_channel_id', // Unique channel ID for morning
//       'Morning Channel', // Human-readable channel name
//       importance: Importance.high,
//       styleInformation: BigPictureStyleInformation(
//         DrawableResourceAndroidBitmap(
//             'morningnotification'), // Replace with your large icon
//         // largeIcon: DrawableResourceAndroidBitmap('morningnotification'), // Replace with your large icon
//         contentTitle: 'Good Morning', // Title of the notification
//         summaryText:
//             "Good morning! 🌞 Start your day with positivity and purpose. Remember, 'The only way to do great work is to love what you do.' - Steve Jobs", // Summary text
//         htmlFormatContent: true, // Enable HTML formatting in the body
//       ),
//       // largeIcon: DrawableResourceAndroidBitmap('morningnotification'), // Replace with your large icon
//       // Add other notification settings as needed
//     );

//     final NotificationDetails platformChannelSpecificsMorning =
//         NotificationDetails(android: androidPlatformChannelSpecificsMorning);

//     final tz.TZDateTime morningTime = tz.TZDateTime(
//       tz.local,
//       DateTime.now().year,
//       DateTime.now().month,
//       DateTime.now().day,
//       09, // Morning Hour
//       00, // Minute
//     );

//     await flutterLocalNotificationsPlugin.zonedSchedule(
//       0, // Notification ID (unique for each notification)
//       'Good Morning', // Morning Notification Title
//       'It\'s a new day!', // Morning Notification Body
//       morningTime,
//       platformChannelSpecificsMorning,
//       uiLocalNotificationDateInterpretation:
//           UILocalNotificationDateInterpretation.absoluteTime,
//       androidAllowWhileIdle: true,
//       payload:
//           'https://i.pinimg.com/564x/6d/4b/2f/6d4b2f2fea3f5a94acf033c3aca0ece1.jpg',
//     );
//   }

//   Future<void> _scheduleNightNotification() async {
//     final AndroidNotificationDetails androidPlatformChannelSpecificsNight =
//         AndroidNotificationDetails(
//       'night_channel_id', // Unique channel ID for night
//       'Night Channel', // Human-readable channel name
//       importance: Importance.high,
//       styleInformation: BigPictureStyleInformation(
//         DrawableResourceAndroidBitmap(
//             'nightnotification'), // Replace with your large icon
//         // largeIcon: DrawableResourceAndroidBitmap('morningnotification'), // Replace with your large icon
//         contentTitle: 'Good Night', // Title of the notification
//         summaryText:
//             "Reflect on your day. What did you accomplish? What can you improve? Tomorrow is a new chance to make progress. Sleep well! 😴", // Summary text
//         htmlFormatContent: true, // Enable HTML formatting in the body
//       ),
//       // largeIcon: DrawableResourceAndroidBitmap('nightnotification'), // Replace with your large icon
//       // Add other notification settings as needed
//     );

//     final NotificationDetails platformChannelSpecificsNight =
//         NotificationDetails(android: androidPlatformChannelSpecificsNight);

//     final tz.TZDateTime nightTime = tz.TZDateTime(
//       tz.local,
//       DateTime.now().year,
//       DateTime.now().month,
//       DateTime.now().day,
//       23, // Night Hour (8:00 PM)
//       00, // Minute
//     );

//     await flutterLocalNotificationsPlugin.zonedSchedule(
//       1, // Notification ID (unique for each notification)
//       'Good Night', // Night Notification Title
//       'Time to rest!', // Night Notification Body
//       nightTime,
//       platformChannelSpecificsNight,
//       uiLocalNotificationDateInterpretation:
//           UILocalNotificationDateInterpretation.absoluteTime,
//       androidAllowWhileIdle: true,
//       payload:
//           'https://i.pinimg.com/564x/39/39/27/3939272aeb836a1253cd2d977d68eea2.jpg',
//     );
//   }

// // Future<void> scheduleImageNotification() async {
// //   // final AndroidNotificationDetails androidPlatformChannelSpecificsImage =
// //   //     AndroidNotificationDetails(
// //   //   'image_channel_id', // Unique channel ID for image notification
// //   //   'Image Channel',    // Human-readable channel name
// //   //   importance: Importance.high,
// //   // );

// //   // final NotificationDetails platformChannelSpecificsImage =
// //   //     NotificationDetails(android: androidPlatformChannelSpecificsImage);

// //   // // Image notification
// //   // final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
// //   // final tz.TZDateTime scheduledDate = tz.TZDateTime(
// //   //   tz.local,
// //   //   now.year,
// //   //   now.month,
// //   //   now.day,
// //   //   12, // Hour (12:00 PM)
// //   //   0,  // Minute
// //   // );

// //   await flutterLocalNotificationsPlugin.zonedSchedule(
// //     2, // Notification ID (unique for each notification)
// //     'Image Notification', // Image Notification Title
// //     'Check out this image!', // Image Notification Body
// //     scheduledDate,
// //     platformChannelSpecificsImage,
// //     payload: 'image_path', // You can use this payload to specify the image path
// //     uiLocalNotificationDateInterpretation:
// //         UILocalNotificationDateInterpretation.absoluteTime,
// //     androidAllowWhileIdle: true,
// //   );
// // }
// }



// // class FirebaseAPI {
// //   final _firebaseMessaging = FirebaseMessaging.instance;
// //   Future<void> initNotifications() async {
// //     await _firebaseMessaging.requestPermission();
// //     final fcmToken = await _firebaseMessaging.getToken();
// //     print("Token:  $fcmToken");
// //     FirebaseMessaging.onBackgroundMessage((handleBackgroundMessage));
// //   }
// // }
