//Flutter Packages
import 'package:flutter/material.dart';

// Third Party Packages
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:flutter_native_timezone/flutter_native_timezone.dart';

class NotificationService with ChangeNotifier {
  List<int> recurringNoificationIds = [];

  void addRecurringNotificationIds(int id) {
    recurringNoificationIds.add(id);
  }

  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  Future<void> initialize() async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    IOSInitializationSettings iosInitializationSettings =
        IOSInitializationSettings();

    final InitializationSettings initializationSettings =
        new InitializationSettings(
            android: androidInitializationSettings,
            iOS: iosInitializationSettings);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> instantNotification() async {
    var android = AndroidNotificationDetails('id', 'channel', 'desc');
    var ios = IOSNotificationDetails();

    var platform = new NotificationDetails(android: android, iOS: ios);

    await _flutterLocalNotificationsPlugin
        .show(0, 'Demo', 'Demo Again', platform, payload: "Welcome");
  }

  Future<void> scheduledNotification(
    int id,
    String taskName,
    String taskInfo,
    int days,
    int hours,
    int minutes,
  ) async {
    tz.initializeTimeZones();
    String dtz = await FlutterNativeTimezone.getLocalTimezone();
    if (dtz == "Asia/Calcutta") {
      dtz = "Asia/Kolkata";
    }
    final localTimeZone = tz.getLocation(dtz);
    tz.setLocalLocation(localTimeZone);

    await _flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      'Routinger',
      taskName,
      tz.TZDateTime.now(tz.local).add(
        Duration(
          hours: hours,
          minutes: minutes,
          days: days,
        ),
      ),
      const NotificationDetails(
          android: AndroidNotificationDetails(
              'scheduledNotif', 'scheduledNotif', 'scheduledNotif')),
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true,
    );
  }

  Future<void> recurringNotif(
    int id,
    String taskName,
    String taskInfo,
    int days,
    int hours,
    int minutes,
  ) async {
    tz.initializeTimeZones();
    String dtz = await FlutterNativeTimezone.getLocalTimezone();
    if (dtz == "Asia/Calcutta") {
      dtz = "Asia/Kolkata";
    }
    final localTimeZone = tz.getLocation(dtz);
    tz.setLocalLocation(localTimeZone);

    // await _flutterLocalNotificationsPlugin.cancelAll();
    await _flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      'Routinger',
      taskName,
      tz.TZDateTime.now(tz.local).add(
        Duration(
          hours: hours,
          minutes: minutes,
          days: days,
        ),
      ),
      const NotificationDetails(
          android: AndroidNotificationDetails(
              'recurringNotif', 'recurringNotif', 'recurringNotif')),
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true,
      matchDateTimeComponents: DateTimeComponents.time,
    );
    final List<PendingNotificationRequest> pendingNotificationRequests =
        await _flutterLocalNotificationsPlugin.pendingNotificationRequests();
    print(pendingNotificationRequests.length.toString() + " Something");
    for (int i = 0; i < pendingNotificationRequests.length; i++) {
      print(pendingNotificationRequests[i].title.toString() + " YES");
    }
  }

  Future<void> cancelNotification(int id) async {
    await _flutterLocalNotificationsPlugin.cancel(id);
  }
}
