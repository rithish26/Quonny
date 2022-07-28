import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';
import 'package:quonny_quonnect/provider/hello.dart';
import 'package:quonny_quonnect/screens/demo_screen.dart';
import 'package:quonny_quonnect/screens/getting_started_screen.dart';
import 'package:quonny_quonnect/screens/login_screen.dart';
import 'package:quonny_quonnect/screens/questionaire.dart';
import 'package:quonny_quonnect/screens/quonnect.dart';
import 'package:quonny_quonnect/utils/routes.dart';
import 'package:firebase_core/firebase_core.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GoogleSignInProvider(),
      child: GetMaterialApp(
          theme: ThemeData(fontFamily: 'Raleway'),
          themeMode: ThemeMode.system,
          debugShowCheckedModeBanner: false,
          initialRoute: "/",
          routes: {
            "/": (context) => LoginScreen(),
            MyRoutes.demoPages: (context) => DemoScreens(),
            MyRoutes.gettingStartedRoute: (context) => GettingStartedScreen(),
            MyRoutes.questionaire: (context) => Questionaire(),
            MyRoutes.quonnect: (context) => QuonnectScreen(),
          } //
          ),
    );
  }
}
