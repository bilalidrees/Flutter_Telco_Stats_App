// import 'dart:io';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:flutter_native_timezone/flutter_native_timezone.dart';
// import 'package:rxdart/subjects.dart';
// import 'package:timezone/data/latest_all.dart' as tz;
// import 'package:timezone/timezone.dart' as tz;
//
// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//     FlutterLocalNotificationsPlugin();
//
// final BehaviorSubject<ReceivedNotification> didReceiveLocalNotificationSubject =
//     BehaviorSubject<ReceivedNotification>();
//
// final BehaviorSubject<String?> selectNotificationSubject =
//     BehaviorSubject<String?>();
//
// class ReceivedNotification {
//   ReceivedNotification({
//     required this.id,
//     required this.title,
//     required this.body,
//     required this.payload,
//   });
//
//   final int id;
//   final String? title;
//   final String? body;
//   final String? payload;
// }
//
// String? selectedNotificationPayload;
//
// class PaddedElevatedButton extends StatelessWidget {
//   const PaddedElevatedButton({
//     required this.buttonText,
//     required this.onPressed,
//     Key? key,
//   }) : super(key: key);
//
//   final String buttonText;
//   final VoidCallback onPressed;
//
//   @override
//   Widget build(BuildContext context) => Padding(
//         padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
//         child: ElevatedButton(
//           onPressed: onPressed,
//           child: Text(buttonText),
//         ),
//       );
// }
//
// class LocalNotification extends StatefulWidget {
//   const LocalNotification({Key? key}) : super(key: key);
//
//   @override
//   _State createState() => _State();
// }
//
// class _State extends State<LocalNotification> {
//   void initialze() async {
//     await _configureLocalTimeZone();
//
//     const AndroidInitializationSettings initializationSettingsAndroid =
//         AndroidInitializationSettings('app_icon');
//
//     /// Note: permissions aren't requested here just to demonstrate that can be
//     /// done later
//     final IOSInitializationSettings initializationSettingsIOS =
//         IOSInitializationSettings(
//             requestAlertPermission: false,
//             requestBadgePermission: false,
//             requestSoundPermission: false,
//             onDidReceiveLocalNotification: (
//               int id,
//               String? title,
//               String? body,
//               String? payload,
//             ) async {
//               didReceiveLocalNotificationSubject.add(
//                 ReceivedNotification(
//                   id: id,
//                   title: title,
//                   body: body,
//                   payload: payload,
//                 ),
//               );
//             });
//     final InitializationSettings initializationSettings =
//         InitializationSettings(
//       android: initializationSettingsAndroid,
//       iOS: initializationSettingsIOS,
//     );
//     await flutterLocalNotificationsPlugin.initialize(initializationSettings,
//         onSelectNotification: (String? payload) async {
//       if (payload != null) {
//         debugPrint('notification payload: $payload');
//       }
//       selectedNotificationPayload = payload;
//       selectNotificationSubject.add(payload);
//     });
//   }
//
//   Future<void> _configureLocalTimeZone() async {
//     tz.initializeTimeZones();
//     final String? timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
//     tz.setLocalLocation(tz.getLocation(timeZoneName!));
//   }
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     initialze();
//     _requestPermissions();
//     _configureDidReceiveLocalNotificationSubject();
//     _configureSelectNotificationSubject();
//   }
//
//   void _requestPermissions() {
//     flutterLocalNotificationsPlugin
//         .resolvePlatformSpecificImplementation<
//             IOSFlutterLocalNotificationsPlugin>()
//         ?.requestPermissions(
//           alert: true,
//           badge: true,
//           sound: true,
//         );
//     flutterLocalNotificationsPlugin
//         .resolvePlatformSpecificImplementation<
//             MacOSFlutterLocalNotificationsPlugin>()
//         ?.requestPermissions(
//           alert: true,
//           badge: true,
//           sound: true,
//         );
//   }
//
//   void _configureDidReceiveLocalNotificationSubject() {
//     didReceiveLocalNotificationSubject.stream
//         .listen((ReceivedNotification receivedNotification) async {
//       await showDialog(
//         context: context,
//         builder: (BuildContext context) => CupertinoAlertDialog(
//           title: receivedNotification.title != null
//               ? Text(receivedNotification.title!)
//               : null,
//           content: receivedNotification.body != null
//               ? Text(receivedNotification.body!)
//               : null,
//           actions: <Widget>[
//             CupertinoDialogAction(
//               isDefaultAction: true,
//               onPressed: () async {
//                 // Navigator.of(context, rootNavigator: true).pop();
//                 // await Navigator.push(
//                 //   context,
//                 //   MaterialPageRoute<void>(
//                 //     builder: (BuildContext context) =>
//                 //         SecondPage(receivedNotification.payload),
//                 //   ),
//                 // );
//               },
//               child: const Text('Ok'),
//             )
//           ],
//         ),
//       );
//     });
//   }
//
//   void _configureSelectNotificationSubject() {
//     selectNotificationSubject.stream.listen((String? payload) async {
//       await Navigator.pushNamed(context, '/secondPage');
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Padding(
//         padding: const EdgeInsets.all(8),
//         child: Center(
//           child: Column(
//             children: <Widget>[
//               SizedBox(
//                 height: 200,
//               ),
//               PaddedElevatedButton(
//                 buttonText: 'Show plain notification with payload',
//                 onPressed: () async {
//                   await _showNotification();
//                 },
//               ),
//               PaddedElevatedButton(
//                 buttonText: 'Schedule notification to appear in 5 seconds '
//                     'based on local time zone',
//                 onPressed: () async {
//                   await _zonedScheduleNotification();
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Future<void> _showNotification() async {
//     const AndroidNotificationDetails androidPlatformChannelSpecifics =
//         AndroidNotificationDetails(
//             'your channel id', 'your channel name', 'your channel description',
//             importance: Importance.max,
//             priority: Priority.high,
//             ticker: 'ticker');
//     const NotificationDetails platformChannelSpecifics =
//         NotificationDetails(android: androidPlatformChannelSpecifics);
//     await flutterLocalNotificationsPlugin.show(
//         0, 'plain title', 'plain body', platformChannelSpecifics,
//         payload: 'item x');
//   }
//
//   Future<void> _zonedScheduleNotification() async {
//     tz.TZDateTime time = tz.TZDateTime.now(tz.local);
//
//     await flutterLocalNotificationsPlugin.zonedSchedule(
//         0,
//         'scheduled title',
//         'scheduled body',
//         tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
//         const NotificationDetails(
//             android: AndroidNotificationDetails('your channel id',
//                 'your channel name', 'your channel description')),
//         androidAllowWhileIdle: true,
//         uiLocalNotificationDateInterpretation:
//             UILocalNotificationDateInterpretation.absoluteTime);
//   }
//
//   @override
//   void dispose() {
//     didReceiveLocalNotificationSubject.close();
//     selectNotificationSubject.close();
//     super.dispose();
//   }
// }
