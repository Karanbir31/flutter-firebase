import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_firebase/authentication/controller/authentication_binding.dart';
import 'package:my_firebase/authentication/presentation/authentication_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Android will use google-services.json automatically
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/authentication",

      getPages: [
        GetPage(
          name: "/authentication",
          page: () => AuthenticationScreen(),
          binding: AuthenticationBinding(),
          transition: Transition.cupertino,
        ),
      ],
    );
  }
}

/*
.\gradlew signingReport


> Task :firebase_core:signingReport
Variant: debugAndroidTest
Config: debug
Store: C:\Users\Karan\.android\debug.keystore
Alias: AndroidDebugKey
MD5: 7F:34:DD:C8:82:D9:C2:30:9E:BD:72:8A:50:31:85:A1
SHA1: BD:E7:B9:33:90:1F:7B:42:C1:77:13:A8:23:C5:41:88:F3:4B:B5:34
SHA-256: 47:15:00:B4:E0:9F:21:A2:D1:4A:BD:E5:9D:11:6B:B7:43:54:68:BC:55:FE:D9:A1:5E:20:D1:86:1B:EB:00:11
Valid until: Monday, 28 June 2055
----------


 */
