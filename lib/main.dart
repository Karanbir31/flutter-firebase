import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_firebase/authentication/controller/authentication_binding.dart';
import 'package:my_firebase/authentication/presentation/authentication_screen.dart';
import 'package:my_firebase/user_profile/controller/user_profile_binding.dart';
import 'package:my_firebase/user_profile/presentation/user_profile_screen.dart';

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
      initialRoute: NavRoutes.initialRoute,

      getPages: [
        GetPage(
          name: NavRoutes.authenticationRoute,
          page: () => AuthenticationScreen(),
          binding: AuthenticationBinding(),
          transition: Transition.cupertino,
        ),

        GetPage(
          name: NavRoutes.userProfileRoute,
          page: () => UserProfileScreen(),
          binding: UserProfileBinding(),
          transition: Transition.cupertino,
        ),
      ],
    );
  }
}

class NavRoutes {
  static const String initialRoute = "/user_profile";

  static const String authenticationRoute = "/authentication";
  static const String userProfileRoute = "/user_profile";
}
