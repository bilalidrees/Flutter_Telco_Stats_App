import 'package:intl/intl.dart';
import 'package:zong_islamic_web_app/src/model/prayer.dart';
import 'package:zong_islamic_web_app/src/model/prayer_information.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:rxdart/subjects.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

final BehaviorSubject<ReceivedNotification> didReceiveLocalNotificationSubject =
    BehaviorSubject<ReceivedNotification>();

final BehaviorSubject<String?> selectNotificationSubject =
    BehaviorSubject<String?>();

class ReceivedNotification {
  ReceivedNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.payload,
  });

  final int id;
  final String? title;
  final String? body;
  final String? payload;
}

String? selectedNotificationPayload;

class PrayerConvertion {
  String? sunriseTimeStart, sunsetTimeStart, zawalTimeStart, chashtNamazTime;
  PrayerInfo? _prayerInfo;
  String? currentTime;
  String? nowText, nextText;
  List<Prayer> prayerList = [];

  Future<void> prayerUpdates(PrayerInfo? prayerInfo) async {
    prayerList.clear();
    _prayerInfo = prayerInfo;
    prayerList.add(Prayer(
        index: 0,
        namazName: "Fajr",
        namazTime: _prayerInfo!.fajr!,
        isCurrentNamaz: false));
    prayerList.add(
      Prayer(
          index: 1,
          namazName: "Zuhr",
          namazTime: _prayerInfo!.dhuhr!,
          isCurrentNamaz: false),
    );
    prayerList.add(
      Prayer(
          index: 2,
          namazName: "Asr",
          namazTime: _prayerInfo!.asr!,
          isCurrentNamaz: false),
    );
    prayerList.add(
      Prayer(
          index: 3,
          namazName: "Maghrib",
          namazTime: _prayerInfo!.maghrib!,
          isCurrentNamaz: false),
    );
    prayerList.add(
      Prayer(
          index: 4,
          namazName: "Isha",
          namazTime: _prayerInfo!.isha!,
          isCurrentNamaz: false),
    );
    await initialze();
    _requestPermissions();
    _configureDidReceiveLocalNotificationSubject();
    _configureSelectNotificationSubject();
    await getPrayerTime();
    await getHeadingText();
  }

  Future<void> initialze() async {
    await _configureLocalTimeZone();

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');

    /// Note: permissions aren't requested here just to demonstrate that can be
    /// done later
    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
            requestAlertPermission: false,
            requestBadgePermission: false,
            requestSoundPermission: false,
            onDidReceiveLocalNotification: (
              int id,
              String? title,
              String? body,
              String? payload,
            ) async {
              didReceiveLocalNotificationSubject.add(
                ReceivedNotification(
                  id: id,
                  title: title,
                  body: body,
                  payload: payload,
                ),
              );
            });
    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String? payload) async {
      if (payload != null) {
        debugPrint('notification payload: $payload');
      }
      selectedNotificationPayload = payload;
      selectNotificationSubject.add(payload);
    });
  }

  Future<void> _configureLocalTimeZone() async {
    tz.initializeTimeZones();
    final String? timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName!));
  }

  void _requestPermissions() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            MacOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  void _configureDidReceiveLocalNotificationSubject() {
    didReceiveLocalNotificationSubject.stream
        .listen((ReceivedNotification receivedNotification) async {
      // await showDialog(
      //   context: context,
      //   builder: (BuildContext context) => CupertinoAlertDialog(
      //     title: receivedNotification.title != null
      //         ? Text(receivedNotification.title!)
      //         : null,
      //     content: receivedNotification.body != null
      //         ? Text(receivedNotification.body!)
      //         : null,
      //     actions: <Widget>[
      //       CupertinoDialogAction(
      //         isDefaultAction: true,
      //         onPressed: () async {
      //           // Navigator.of(context, rootNavigator: true).pop();
      //           // await Navigator.push(
      //           //   context,
      //           //   MaterialPageRoute<void>(
      //           //     builder: (BuildContext context) =>
      //           //         SecondPage(receivedNotification.payload),
      //           //   ),
      //           // );
      //         },
      //         child: const Text('Ok'),
      //       )
      //     ],
      //   ),
      // );
    });
  }

  void _configureSelectNotificationSubject() {
    // selectNotificationSubject.stream.listen((String? payload) async {
    //   await Navigator.pushNamed(context, '/secondPage');
    // });
  }

  Future<void> getPrayerTime() async {
    // GETTING ZAWAL AND SUNRISE TIME START
    sunriseTimeStart = await getDecreasedTime(_prayerInfo!.sunrise, 15);
    sunsetTimeStart = await getDecreasedTime(_prayerInfo!.sunset, 6);
    zawalTimeStart = await getDecreasedTime(_prayerInfo!.dhuhr, 40);
    chashtNamazTime = await getDecreasedTime(zawalTimeStart, 120);
    currentTime = DateFormat('HH:mm:ss').format(DateTime.now());
    await setPrayerTimeImages();
    await setLocalNotification();
  }

  Future<String> getDecreasedTime(String? time, int decreaseFactor) async {
    List<String> splittedTime = time!.split(':');
    DateTime prayerTime = DateTime(
        0, 0, 0, int.parse(splittedTime[0]), int.parse(splittedTime[1]), 0, 0);
    prayerTime = DateTime(0, 0, 0, int.parse(splittedTime[0]),
        prayerTime.minute - decreaseFactor, 0, 0);
    String hr = "0${prayerTime.hour}";
    hr = hr.substring(hr.length - 2);
    String mnt = "0${prayerTime.minute}";
    mnt = mnt.substring(mnt.length - 2);
    return "$hr:$mnt";
  }

  Future<bool> setPrayerTimeImages() async {
    if (getIntoSeconds(currentTime!)! >=
            getIntoSeconds("${_prayerInfo!.fajr}")! &&
        getIntoSeconds(currentTime!)! <
            getIntoSeconds("${_prayerInfo!.sunrise}")!) {
      prayerList[0].isCurrentNamaz = true;
    } else if (getIntoSeconds(currentTime!)! >=
            getIntoSeconds("${_prayerInfo!.sunrise}")! &&
        getIntoSeconds(currentTime!)! <
            getIntoSeconds("${_prayerInfo!.dhuhr}")!) {
      prayerList[0].isCurrentNamaz = false;
    } else if (getIntoSeconds(currentTime!)! >=
            getIntoSeconds("${_prayerInfo!.dhuhr}")! &&
        getIntoSeconds(currentTime!)! <
            getIntoSeconds("${_prayerInfo!.asr}")!) {
      prayerList[1].isCurrentNamaz = true;
    } else if (getIntoSeconds(currentTime!)! >=
            getIntoSeconds("${_prayerInfo!.asr}")! &&
        getIntoSeconds(currentTime!)! < getIntoSeconds(sunsetTimeStart!)!) {
      prayerList[2].isCurrentNamaz = true;
    } else if (getIntoSeconds(currentTime!)! >=
            getIntoSeconds(sunsetTimeStart!)! &&
        getIntoSeconds(currentTime!)! <
            getIntoSeconds("${_prayerInfo!.maghrib}")!) {
      prayerList[2].isCurrentNamaz = false;
    } else if (getIntoSeconds(currentTime!)! >=
            getIntoSeconds("${_prayerInfo!.maghrib}")! &&
        getIntoSeconds(currentTime!)! <
            getIntoSeconds("${_prayerInfo!.isha}")!) {
      prayerList[3].isCurrentNamaz = true;
    } else if (getIntoSeconds(currentTime!)! >=
            getIntoSeconds("${_prayerInfo!.isha}")! &&
        getIntoSeconds(currentTime!)! < getIntoSeconds('23:59:59')!) {
      prayerList[4].isCurrentNamaz = true;
    } else if (getIntoSeconds(currentTime!)! >= getIntoSeconds('00:00:00')! &&
        getIntoSeconds(currentTime!)! <
            getIntoSeconds("${_prayerInfo!.fajr}")!) {
      prayerList[4].isCurrentNamaz = true;
    }
    return true;
  }

  setLocalNotification() async {
    tz.TZDateTime time = tz.TZDateTime.now(tz.local);
    int? currentTimeInSeconds =
        getIntoSeconds("${time.hour.toString()}:${time.minute.toString()}");
    prayerList.forEach((prayer) {
      var nextNamazTimeInSeconds =
          getIntoSeconds(prayerList[prayer.index].namazTime);
      if (nextNamazTimeInSeconds! > currentTimeInSeconds!) {
        _zonedScheduleNotification(
            nextNamazTimeInSeconds, currentTimeInSeconds, prayer);
      }
    });
  }

  getHeadingText() async {
    if (getIntoSeconds(currentTime!)! >=
            getIntoSeconds("${_prayerInfo!.fajr}")! &&
        getIntoSeconds(currentTime!)! < getIntoSeconds(sunriseTimeStart)!) {
      nowText = "Now Fajr";
      nextText = "Next Sunrise";
    } else if (getIntoSeconds(currentTime!)! >=
            getIntoSeconds(sunriseTimeStart)! &&
        getIntoSeconds(currentTime!)! <
            getIntoSeconds("${_prayerInfo!.sunrise}")!) {
      nowText = "Now Fajr";
      nextText = "Next Sunrise";
    } else if (getIntoSeconds(currentTime!)! >=
            getIntoSeconds("${_prayerInfo!.sunrise}")! &&
        getIntoSeconds(currentTime!)! < getIntoSeconds(chashtNamazTime)!) {
      nowText = "Now Ishraq";
      nextText = "Next Chasht";
    } else if (getIntoSeconds(currentTime!)! >=
            getIntoSeconds(chashtNamazTime)! &&
        getIntoSeconds(currentTime!)! < getIntoSeconds(zawalTimeStart)!) {
      nowText = "Now Chasht";
      nextText = "Next Zawal";
    } else if (getIntoSeconds(currentTime!)! >=
            getIntoSeconds(zawalTimeStart)! &&
        getIntoSeconds(currentTime!)! <
            getIntoSeconds("${_prayerInfo!.dhuhr}")!) {
      nowText = "Zawal Time";
      nextText = "Next Zuhr ${_prayerInfo!.dhuhr}";
    } else if (getIntoSeconds(currentTime!)! >=
            getIntoSeconds("${_prayerInfo!.dhuhr}")! &&
        getIntoSeconds(currentTime!)! <
            getIntoSeconds("${_prayerInfo!.asr}")!) {
      nowText = "Now Zuhr";
      nextText = "Next Asr ${_prayerInfo!.asr}";
    } else if (getIntoSeconds(currentTime!)! >=
            getIntoSeconds("${_prayerInfo!.asr}")! &&
        getIntoSeconds(currentTime!)! < getIntoSeconds(sunsetTimeStart!)!) {
      nowText = "Now Asr";
      nextText = "Next Sunset";
    } else if (getIntoSeconds(currentTime!)! >=
            getIntoSeconds(sunsetTimeStart!)! &&
        getIntoSeconds(currentTime!)! <
            getIntoSeconds("${_prayerInfo!.maghrib}")!) {
      nowText = "Now Asr";
      nextText = "Next Sunset";
    } else if (getIntoSeconds(currentTime!)! >=
            getIntoSeconds("${_prayerInfo!.maghrib}")! &&
        getIntoSeconds(currentTime!)! <
            getIntoSeconds("${_prayerInfo!.isha}")!) {
      nowText = "Now Maghrib";
      nextText = "Next Ish ${_prayerInfo!.isha}";
    } else if (getIntoSeconds(currentTime!)! >=
            getIntoSeconds("${_prayerInfo!.isha}")! &&
        getIntoSeconds(currentTime!)! < getIntoSeconds('23:59:59')!) {
      nowText = "Now Isha";
      nextText = "Next Fajr ${_prayerInfo!.fajr}";
    } else if (getIntoSeconds(currentTime!)! >= getIntoSeconds('00:00:00')! &&
        getIntoSeconds(currentTime!)! <
            getIntoSeconds("${_prayerInfo!.fajr}")!) {
      nowText = "Now Isha";
      nextText = "Next Fajr ${_prayerInfo!.fajr}";
    }
  }

  int? getIntoSeconds(String? time) {
    List<String> splittedTime = time!.split(':');
    int hr_sec = int.parse(splittedTime[0]) * 60 * 60;
    int min_sec = int.parse(splittedTime[1]) * 60;
    return hr_sec + min_sec;
  }

  Future<void> _showNotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
            'your channel id', 'your channel name', 'your channel description',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        0, 'plain title', 'plain body', platformChannelSpecifics,
        payload: 'item x');
  }

  Future<void> _zonedScheduleNotification(
      int nextNamazTime, int currentTimeInSeconds, Prayer prayer) async {
    var difference = nextNamazTime - currentTimeInSeconds;

    await flutterLocalNotificationsPlugin.zonedSchedule(
        prayer.index,
        '${prayer.namazName} Namaz Time',
        '${prayer.namazTime}',
        tz.TZDateTime.now(tz.local).add(Duration(seconds: difference)),
        const NotificationDetails(
            android: AndroidNotificationDetails('your channel id',
                'your channel name', 'your channel description')),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }
}
