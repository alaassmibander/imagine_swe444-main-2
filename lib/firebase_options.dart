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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBEdDpdro9eIQwQ5NOiAan4GqI3XLkgaoA',
    appId: '1:772736728571:android:66c23d985d54f376201f5e',
    messagingSenderId: '772736728571',
    projectId: 'imagine-swe444-ddc02',
    storageBucket: 'imagine-swe444-ddc02.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBz1Z8u0T5X1SYAceX8ib8QNf1cKXpsqqo',
    appId: '1:772736728571:ios:b69dee64e507fee2201f5e',
    messagingSenderId: '772736728571',
    projectId: 'imagine-swe444-ddc02',
    storageBucket: 'imagine-swe444-ddc02.appspot.com',
    androidClientId: '772736728571-6tmmcvcamed1glje193ragk7akfobp9q.apps.googleusercontent.com',
    iosClientId: '772736728571-2qc1vashmdabaq0lv9iq634nsndel88f.apps.googleusercontent.com',
    iosBundleId: 'com.example.imagineSwe',
  );
}
