import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  late AndroidNotificationDetails androidPlatformChannelSpecifics;

  Future<void> init() async {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');

    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
      onDidReceiveLocalNotification: (id, title, body, payload) {},
    );

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (value) {
      print("NOTIFICATION: ${value}");
    });

    androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      "Expense Note",
      'Note Reminder',
      channelDescription: 'Remind you to take note',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );
  }

  void push(String title, String body) async {
    NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.show(
      DateTime.now().hashCode,
      title,
      body,
      platformChannelSpecifics,
    );
  }

  void scheduleReminderUser(DateTime dateTime) async {
    flutterLocalNotificationsPlugin.cancel(0);

    NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    tz.initializeTimeZones();

    await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      'Reminder: Start taking note?',
      'Click here to start taking note your transaction now. 📝',
      tz.TZDateTime.from(dateTime, tz.local),
      // tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
      platformChannelSpecifics,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }
}
