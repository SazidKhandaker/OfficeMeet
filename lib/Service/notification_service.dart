import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart'
as tz;
import 'package:timezone/timezone.dart'
as tz;

class NotificationService {

  static final
  FlutterLocalNotificationsPlugin
  notificationsPlugin =

  FlutterLocalNotificationsPlugin();

  /// =========================
  /// INIT
  /// =========================
  static Future<void> init() async {

    tz.initializeTimeZones();

    const AndroidInitializationSettings
    androidSettings =

    AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );

    const InitializationSettings
    settings = InitializationSettings(

      android:
      androidSettings,
    );

    await notificationsPlugin
        .initialize(settings);
  }

  /// =========================
  /// SCHEDULE NOTIFICATION
  /// =========================
  static Future<void>
  scheduleMeetingNotification({

    required int id,

    required String title,

    required String body,

    required DateTime meetingTime,
  }) async {

    final notificationTime =

    meetingTime.subtract(
      const Duration(
        minutes: 30,
      ),
    );
    if (
    notificationTime.isBefore(
      DateTime.now(),
    )
    ) {

      return;
    }
    

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

          importance:
          Importance.max,

          priority:
          Priority.high,
        ),
      ),

      androidScheduleMode:
      AndroidScheduleMode
          .exactAllowWhileIdle,

      uiLocalNotificationDateInterpretation:

      UILocalNotificationDateInterpretation
          .absoluteTime,
    );
  }

  /// =========================
  /// CANCEL
  /// =========================
  static Future<void>
  cancelNotification(
      int id,
      ) async {

    await notificationsPlugin
        .cancel(id);
  }
}