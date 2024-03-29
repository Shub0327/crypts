// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyDI1KOU03ltJ2lBGfNBUMlqGjuyHMY2h8c',
    appId: '1:1015715869783:web:844b633f62873015679f12',
    messagingSenderId: '1015715869783',
    projectId: 'crypts-cc506',
    databaseURL: 'https://crypts-cc506-default-rtdb.firebaseio.com',
    authDomain: 'crypts-cc506.firebaseapp.com',
    storageBucket: 'crypts-cc506.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAzMNrZT7OjK2mNmwuZO4EjvjVIX_gkySg',
    appId: '1:1015715869783:android:2729f49fc7b5144d679f12',
    messagingSenderId: '1015715869783',
    projectId: 'crypts-cc506',
    databaseURL: 'https://crypts-cc506-default-rtdb.firebaseio.com',
    storageBucket: 'crypts-cc506.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAmKKibCGiYWvLhwMmuUrwqUJ9HkNrZlG4',
    appId: '1:1015715869783:ios:830d37ba37b674d4679f12',
    messagingSenderId: '1015715869783',
    projectId: 'crypts-cc506',
    storageBucket: 'crypts-cc506.appspot.com',
    iosClientId: '1015715869783-mdim5musu9beti55h9htj6gg145frmr9.apps.googleusercontent.com',
    iosBundleId: 'com.example.crypts',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAmKKibCGiYWvLhwMmuUrwqUJ9HkNrZlG4',
    appId: '1:1015715869783:ios:830d37ba37b674d4679f12',
    messagingSenderId: '1015715869783',
    projectId: 'crypts-cc506',
    storageBucket: 'crypts-cc506.appspot.com',
    iosClientId: '1015715869783-mdim5musu9beti55h9htj6gg145frmr9.apps.googleusercontent.com',
    iosBundleId: 'com.example.crypts',
  );
}
