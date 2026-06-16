import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone_latest/flutter_native_timezone_latest.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {

  static final FlutterLocalNotificationsPlugin
  notificationsPlugin =
  FlutterLocalNotificationsPlugin();

  /// =========================
  /// TEST NOTIFICATION
  /// =========================

  static Future<void> testNotification() async {

    await notificationsPlugin.show(

      1,

      "Test Notification",

      "Notification Working 🚀",

      const NotificationDetails(

        android: AndroidNotificationDetails(

          'meeting_channel',

          'Meeting Notifications',

          channelDescription:
          'Meeting reminder notifications',

          importance: Importance.max,

          priority: Priority.high,

          playSound: true,

          enableVibration: true,

          fullScreenIntent: true,

          category:
          AndroidNotificationCategory.reminder,

          visibility:
          NotificationVisibility.public,

          ticker: "Meeting Reminder",
        ),
      ),
    );
  }

  /// =========================
  /// REQUEST PERMISSION
  /// =========================

  static Future<bool> requestPermission() async {

    final androidPlugin =
    notificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();

    final granted =
    await androidPlugin
        ?.requestNotificationsPermission();

    await androidPlugin
        ?.requestExactAlarmsPermission();

    return granted ?? false;
  }

  /// =========================
  /// INIT
  /// =========================

  static Future<void> init() async {

    tz.initializeTimeZones();

    final String currentTimeZone =
    await FlutterNativeTimezoneLatest
        .getLocalTimezone();

    tz.setLocalLocation(
      tz.getLocation(currentTimeZone),
    );

    const AndroidNotificationChannel
    channel =
    AndroidNotificationChannel(

      'meeting_channel',

      'Meeting Notifications',

      description:
      'Meeting reminder notifications',

      importance:
      Importance.max,
    );

    const AndroidInitializationSettings
    androidSettings =
    AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );

    const InitializationSettings
    settings =
    InitializationSettings(
      android: androidSettings,
    );

    await notificationsPlugin
        .initialize(settings);

    await notificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(
      channel,
    );
  }

  /// =========================
  /// SCHEDULE MEETING
  /// =========================

  static Future<void>
  scheduleMeetingNotification({

    required int id,

    required String title,

    required String body,

    required DateTime meetingTime,
  }) async {

    print(
      "FUNCTION ENTERED",
    );

    /// 10 MINUTES BEFORE

    final notificationTime =
    meetingTime.subtract(
      const Duration(
        minutes: 10,
      ),
    );

    print(
      "MEETING TIME: $meetingTime",
    );

    print(
      "NOTIFICATION TIME: $notificationTime",
    );

    print(
      "CURRENT TIME: ${DateTime.now()}",
    );

    if (notificationTime.isBefore(
      DateTime.now(),
    )) {

      print(
        "TIME PASSED",
      );

      return;
    }

    await notificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.requestExactAlarmsPermission();

    await notificationsPlugin
        .zonedSchedule(

      id,

      title,

      body,

      tz.TZDateTime.from(
        notificationTime,
        tz.local,
      ),

      const NotificationDetails(

        android:
        AndroidNotificationDetails(

          'meeting_channel',

          'Meeting Notifications',

          channelDescription:
          'Meeting reminder notifications',

          importance:
          Importance.max,

          priority:
          Priority.high,

          playSound: true,

          enableVibration: true,

          fullScreenIntent: true,

          visibility:
          NotificationVisibility.public,

          category:
          AndroidNotificationCategory.reminder,

          ticker:
          "Meeting Reminder",
        ),
      ),

      androidScheduleMode:
      AndroidScheduleMode
          .exactAllowWhileIdle,

      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation
          .absoluteTime,
    );

    print(
      "NOTIFICATION SCHEDULED SUCCESSFULLY",
    );

    final pending =
    await notificationsPlugin
        .pendingNotificationRequests();

    print(
      "TOTAL PENDING: ${pending.length}",
    );
  }

  /// =========================
  /// CANCEL SINGLE
  /// =========================

  static Future<void>
  cancelNotification(
      int id,
      ) async {

    await notificationsPlugin
        .cancel(id);
  }

  /// =========================
  /// CANCEL ALL
  /// =========================

  static Future<void>
  cancelAllNotifications()
  async {

    await notificationsPlugin
        .cancelAll();
  }

  /// =========================
  /// CHECK PENDING
  /// =========================

  static Future<void>
  checkPendingNotifications()
  async {

    final pending =
    await notificationsPlugin
        .pendingNotificationRequests();

    print(
      "TOTAL PENDING: ${pending.length}",
    );

    for (final item in pending) {

      print(
        "ID: ${item.id}",
      );

      print(
        "TITLE: ${item.title}",
      );
    }
  }
}