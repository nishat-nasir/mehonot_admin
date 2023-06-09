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
    apiKey: 'AIzaSyCu1QoBfUa19l9lSa1silom6CUQ0Pp-ZAI',
    appId: '1:710449776748:web:7be316c8d1f2fa02927049',
    messagingSenderId: '710449776748',
    projectId: 'mehonot-bd',
    authDomain: 'mehonot-bd.firebaseapp.com',
    storageBucket: 'mehonot-bd.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAM5oXzpMd5g1iSBfEYcu_kZ_2oGzW-DYM',
    appId: '1:710449776748:android:3dc905c3e28cdcac927049',
    messagingSenderId: '710449776748',
    projectId: 'mehonot-bd',
    storageBucket: 'mehonot-bd.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDKfig5s0FPoolriir9iVdeR1OKU_I99Ko',
    appId: '1:710449776748:ios:ff4a85e2cf388268927049',
    messagingSenderId: '710449776748',
    projectId: 'mehonot-bd',
    storageBucket: 'mehonot-bd.appspot.com',
    iosClientId: '710449776748-48hpbo0e5d7methakir1jkgumfa49qc6.apps.googleusercontent.com',
    iosBundleId: 'com.example.mehonotAdmin',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDKfig5s0FPoolriir9iVdeR1OKU_I99Ko',
    appId: '1:710449776748:ios:d61e83d1d9308afb927049',
    messagingSenderId: '710449776748',
    projectId: 'mehonot-bd',
    storageBucket: 'mehonot-bd.appspot.com',
    iosClientId: '710449776748-9hl33b2tfb0vba43dnbuqrj4bpafpi24.apps.googleusercontent.com',
    iosBundleId: 'com.example.mehonotAdmin.RunnerTests',
  );
}
