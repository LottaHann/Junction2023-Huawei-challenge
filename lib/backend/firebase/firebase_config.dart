import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyAY850o2tDRtAyedAUEsHFPeEiGBUc5jT0",
            authDomain: "bifi-6f0a4.firebaseapp.com",
            projectId: "bifi-6f0a4",
            storageBucket: "bifi-6f0a4.appspot.com",
            messagingSenderId: "180597014723",
            appId: "1:180597014723:web:7e67a8b80e306efed3e276",
            measurementId: "G-TJ1CEBESSF"));
  } else {
    await Firebase.initializeApp();
  }
}
