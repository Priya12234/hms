// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBM1S7T09nRz7XhuYazLWQTb_xze7Ey9ZQ',
    appId: '1:49950793840:web:c2b00fda1678b665a154b5',
    messagingSenderId: '49950793840',
    projectId: 'hostel-firebase-751c2',
    authDomain: 'hostel-firebase-751c2.firebaseapp.com',
    databaseURL: 'https://hostel-firebase-751c2-default-rtdb.firebaseio.com',
    storageBucket: 'hostel-firebase-751c2.appspot.com',
    measurementId: 'G-PDCH5SJL5C',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDssF0S80IfUDEBGfKZkyxT6fBlvdMUNMA',
    appId: '1:49950793840:android:e47f9f30643abde1a154b5',
    messagingSenderId: '49950793840',
    projectId: 'hostel-firebase-751c2',
    databaseURL: 'https://hostel-firebase-751c2-default-rtdb.firebaseio.com',
    storageBucket: 'hostel-firebase-751c2.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAkfzG28O0HArafjgt4jwD_bBXFEbuCpMA',
    appId: '1:49950793840:ios:e00c0aa82f23c39fa154b5',
    messagingSenderId: '49950793840',
    projectId: 'hostel-firebase-751c2',
    databaseURL: 'https://hostel-firebase-751c2-default-rtdb.firebaseio.com',
    storageBucket: 'hostel-firebase-751c2.appspot.com',
    iosClientId: '49950793840-uc5k226m61e3uvbtfairnm4m7pm0km3n.apps.googleusercontent.com',
    iosBundleId: 'com.example.hms',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAkfzG28O0HArafjgt4jwD_bBXFEbuCpMA',
    appId: '1:49950793840:ios:e00c0aa82f23c39fa154b5',
    messagingSenderId: '49950793840',
    projectId: 'hostel-firebase-751c2',
    databaseURL: 'https://hostel-firebase-751c2-default-rtdb.firebaseio.com',
    storageBucket: 'hostel-firebase-751c2.appspot.com',
    iosClientId: '49950793840-uc5k226m61e3uvbtfairnm4m7pm0km3n.apps.googleusercontent.com',
    iosBundleId: 'com.example.hms',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBM1S7T09nRz7XhuYazLWQTb_xze7Ey9ZQ',
    appId: '1:49950793840:web:97dc84a17e6e168ba154b5',
    messagingSenderId: '49950793840',
    projectId: 'hostel-firebase-751c2',
    authDomain: 'hostel-firebase-751c2.firebaseapp.com',
    databaseURL: 'https://hostel-firebase-751c2-default-rtdb.firebaseio.com',
    storageBucket: 'hostel-firebase-751c2.appspot.com',
    measurementId: 'G-WLHP21V5HQ',
  );
}
