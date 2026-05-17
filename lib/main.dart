import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth;
import 'package:flutter/material.dart';
import 'package:office_meet/DB/DefaultFirebaseOptions.dart' show DefaultFirebaseOptions;
import 'package:office_meet/homepage.dart' show HomePage;
import 'package:office_meet/splashscreen/splashscreen.dart' show Splashscreen, SplashScreen;
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(

    options:
    DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home:  FirebaseAuth.instance.currentUser != null
          ? const HomePage()
          : const SplashScreen(),
    );
  }
}

