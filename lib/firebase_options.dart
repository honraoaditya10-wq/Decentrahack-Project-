
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;


class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAhtMa2YJlwva4iOKXrb_jnoHBG00G-nfE',
    appId: '1:59913156015:web:c7426789ccae1848502b5a',
    messagingSenderId: '59913156015',
    projectId: 'wastenot-1aa27',
    authDomain: 'wastenot-1aa27.firebaseapp.com',
    storageBucket: 'wastenot-1aa27.firebasestorage.app',
    measurementId: 'G-MLFTYZGJVN',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAVNeHYg_YwvPWEOxwTJSf7g1diC8ZLc2k',
    appId: '1:59913156015:android:7e2f4f33dff042ba502b5a',
    messagingSenderId: '59913156015',
    projectId: 'wastenot-1aa27',
    storageBucket: 'wastenot-1aa27.firebasestorage.app',
  );
}
