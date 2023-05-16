import 'package:nroho/Models/Users.dart';
import 'package:nroho/Services/auth.dart';
import 'package:nroho/Services/localNotification.dart';
import 'package:nroho/pages/Verification.dart';
import 'package:nroho/pages/begin.dart';
import 'package:nroho/pages/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nroho/Services/wrapper.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:nroho/pages/welcomepage.dart';
import 'package:nroho/pages/trajetdetailsconducteurs.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:nroho/pages/page_recherche.dart';
import 'package:nroho/Services/notification.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  NotificationSettings settings =
      await FirebaseMessaging.instance.requestPermission();
  print(settings.authorizationStatus);
  final fcm = await FirebaseMessaging.instance.getToken();
  print(fcm);
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
          "/home": (context) {
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
//initialRoute: '/commencer',
            routes: {
/* '/signin':(context) => const Connexin(title: 'connextion '),
          '/signup':(context) => const MyHomePage(title: 'SingnUp'),
          '/commencer':(context) => const MyBeginPage(title: 'begin') ,*/
              '/home': (context) => home(),
            },
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
              useMaterial3: true,
            ),
            home: Builder(builder: (BuildContext context) {
              return WillPopScope(
                child: WelcomePage(),
                onWillPop: () async {
                  if (FirebaseAuth.instance.currentUser != null) {
                    if (FirebaseAuth.instance.currentUser != null) {
                      if (!FirebaseAuth.instance.currentUser!.emailVerified) {
                        FirebaseAuth.instance.currentUser!.delete();
                      }
                    }
                  }
                  print('L\'utilisateur a quitté l\'application');
                  return true;
                },
              );
            })));
  }
}
