import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_firebase/authentication/controller/authentication_binding.dart';
import 'package:my_firebase/authentication/presentation/authentication_screen.dart';
import 'package:my_firebase/splash_screen/splash_screen.dart';
import 'package:my_firebase/task_details/controller/task_details_binding.dart';
import 'package:my_firebase/task_details/presentation/task_details_screen.dart';
import 'package:my_firebase/task_list/controller/my_tasks_binding.dart';
import 'package:my_firebase/task_list/presentation/my_tasks.dart';
import 'package:my_firebase/update_task/controller/task_update_binding.dart';
import 'package:my_firebase/update_task/presentation/task_update_screen.dart';
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
          name: NavRoutes.splashScreenRoute,
          page: () => SplashScreen(),

          transition: Transition.cupertino,
        ),
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

        GetPage(
          name: NavRoutes.myTasksRoute,
          page: () => MyTasksScreen(),
          binding: MyTasksBinding(),
          transition: Transition.cupertino,
        ),

        GetPage(
          name: NavRoutes.taskUpdateRoute,
          page: () => TaskUpdateScreen(),
          binding: TaskUpdateBinding(),
          transition: Transition.cupertino,
        ),

        GetPage(
          name: NavRoutes.taskDetailsRoute,
          page: () => TaskDetailsScreen(),
          binding: TaskDetailsBinding(),
          transition: Transition.cupertino,
        ),
      ],
    );
  }
}

class NavRoutes {
  static const String initialRoute = "/my_tasks";

  static const String splashScreenRoute = "/splash_screen";

  static const String authenticationRoute = "/authentication";
  static const String userProfileRoute = "/user_profile";

  static const String myTasksRoute = "/my_tasks";
  static const String taskDetailsRoute = "/task_details";
  static const String taskUpdateRoute = "/task_update";
}
