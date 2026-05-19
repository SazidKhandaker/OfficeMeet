import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:office_meet/DB/DefaultFirebaseOptions.dart';
import 'package:office_meet/Service/notification_service.dart' show NotificationService;
import 'package:office_meet/homepage.dart';
import 'package:office_meet/splashscreen/splashscreen.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(

    options:
    DefaultFirebaseOptions.currentPlatform,
  );
  await NotificationService.init();
  runApp(
    const MyApp(),
  );
}

class MyApp
    extends StatelessWidget {

  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return MaterialApp(

      debugShowCheckedModeBanner:
      false,

      title:
      'Office Meet',

      /// =========================
      /// APP THEME
      /// =========================
      theme: ThemeData(

        brightness:
        Brightness.dark,

        scaffoldBackgroundColor:
        const Color(
          0xFF0B0618,
        ),

        colorScheme:
        ColorScheme.fromSeed(

          brightness:
          Brightness.dark,

          seedColor:
          Colors.deepPurple,
        ),

        useMaterial3: true,
      ),

      home:

      FirebaseAuth
          .instance
          .currentUser
          !=
          null

          ? const HomePage()

          : const SplashScreen(),
    );
  }
}
