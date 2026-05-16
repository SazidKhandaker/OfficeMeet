import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {

  static FirebaseOptions get currentPlatform {

    if (kIsWeb) {
      throw UnsupportedError(
        'Firebase options are not configured for web.',
      );
    }

    switch (defaultTargetPlatform) {

      case TargetPlatform.android:

        return android;

      default:

        throw UnsupportedError(
          'This platform is not supported.',
        );
    }
  }

  static const FirebaseOptions android =
  FirebaseOptions(

    apiKey:
    'AIzaSyAhnJ67qHlDxfSjeioYPEGEWUsIIDjjN2A',

    appId:
    '1:953246735182:android:15e909dd091ce60d6c5c1f',

    messagingSenderId:
    '953246735182',

    projectId:
    'office-meet-a66eb',

    storageBucket:
    'office-meet-a66eb.firebasestorage.app',
  );
}