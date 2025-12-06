// File generated for Flutter from your Firebase config
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) return web;
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
          'DefaultFirebaseOptions have not been configured for linux.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  // Web config (from Firebase console)
  static const FirebaseOptions web = FirebaseOptions(
    apiKey: "AIzaSyA0nenQC-LH2_IRWe5H-GDUz4nKoXYbng0",
    authDomain: "linkage2.firebaseapp.com",
    projectId: "linkage2",
    storageBucket: "linkage2.firebasestorage.app",
    messagingSenderId: "1028485301004",
    appId: "1:1028485301004:web:bdc3359ddf321985b73f29",
    measurementId: "G-PNH8NW0MQF",
  );

  // Android config (replace with actual values from Firebase console if needed)
  static const FirebaseOptions android = FirebaseOptions(
    apiKey: "AIzaSyBOtYN1oiTxWI6ueR1HhJJxUyuxMiWq0R8",
    appId: "1:1028485301004:android:6a40b150bb8dbbfab73f29",
    messagingSenderId: "1028485301004",
    projectId: "linkage2",
    storageBucket: "linkage2.firebasestorage.app",
  );

  // iOS config (replace with actual values from Firebase console)
  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: "AIzaSyDxV8yzlOl3aj42tXMUuE0m1izjH-Esqfw",
    appId: "1:1028485301004:ios:f1cad9e35f7de186b73f29",
    messagingSenderId: "1028485301004",
    projectId: "linkage2",
    storageBucket: "linkage2.firebasestorage.app",
    iosBundleId: "com.example.seniorConnect",
  );

  // macOS config (same as iOS for now)
  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: "AIzaSyDxV8yzlOl3aj42tXMUuE0m1izjH-Esqfw",
    appId: "1:1028485301004:ios:f1cad9e35f7de186b73f29",
    messagingSenderId: "1028485301004",
    projectId: "linkage2",
    storageBucket: "linkage2.firebasestorage.app",
    iosBundleId: "com.example.seniorConnect",
  );

  // Windows config (placeholder values)
  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: "AIzaSyA0nenQC-LH2_IRWe5H-GDUz4nKoXYbng0",
    appId: "1:1028485301004:web:bdc3359ddf321985b73f29",
    messagingSenderId: "1028485301004",
    projectId: "linkage2",
    storageBucket: "linkage2.firebasestorage.app",
  );
}
