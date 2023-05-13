import 'package:appcouvoiturage/Models/Users.dart';
import 'package:appcouvoiturage/Services/auth.dart';
import 'package:appcouvoiturage/Services/localNotification.dart';
import 'package:appcouvoiturage/pages/begin.dart';
import 'package:appcouvoiturage/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:appcouvoiturage/Services/wrapper.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:appcouvoiturage/pages/welcomepage.dart';
import 'package:appcouvoiturage/pages/trajetdetailsconducteurs.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:appcouvoiturage/pages/page_recherche.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  NotificationSettings settings = await FirebaseMessaging.instance.requestPermission();
  print(settings.authorizationStatus);
  final fcm =await FirebaseMessaging.instance.getToken();
  print(fcm);
  /*LocalNotification.initialize();
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    LocalNotification.showNotification(message);
  });*/
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((_) {
    runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'Poppins'),
        home: MyApp(),
        /*routes: {
          "WelcomPage": (context) {
            return const WelcomePage();
          },
          "home": (context) {
            return const home();
          }
        },*/
      ),
    );
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamProvider<Users?>.value(
      catchError: (User, Users) => null,
      initialData: null,
      value: AuthService().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        /*initialRoute: '/commencer',
        routes: {
          '/signin':(context) => const Connexin(title: 'connextion '),
          '/signup':(context) => const MyHomePage(title: 'SingnUp'),
          '/commencer':(context) => const MyBeginPage(title: 'begin') ,
        },*/
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        home: WelcomePage(),
      ),
    );
  }
}
