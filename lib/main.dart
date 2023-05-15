import 'package:appcouvoiturage/Models/Users.dart';
import 'package:appcouvoiturage/Services/auth.dart';
import 'package:appcouvoiturage/pages/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:appcouvoiturage/pages/welcomepage.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  NotificationSettings settings =
      await FirebaseMessaging.instance.requestPermission();
  print(settings.authorizationStatus);
  final fcm = await FirebaseMessaging.instance.getToken();
  print(fcm);
  /*LocalNotification.initialize();
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    LocalNotification.showNotification(message);
  });*/
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((_) {
    runApp(
      GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'Poppins'),
        home: WillPopScope(
            onWillPop: () async {
              return false;
            },
            child:  const MyApp()),
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
                onWillPop: () async {
                  // Action lorsque l'utilisateur quitte l'application
                  if (FirebaseAuth.instance.currentUser != null) {
                    if (!FirebaseAuth.instance.currentUser!.emailVerified) {
                      FirebaseAuth.instance.currentUser!.delete();
                    }
                  }
                  print('L\'utilisateur a quitté l\'application');
                  return false;
                },
                child: const WelcomePage(),
              );
            })));
  }
}



class KApp extends StatefulWidget {
  const KApp({super.key});

  @override
  State<KApp> createState() => _KAppState();
}

class _KAppState extends State<KApp> {

  double height = 0, width = 0;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(child: 
            const Text('cdafsd'), onPressed: () {
              setState(() {
                
                width = 100;
                height = 100;
              });
            },),
            AnimatedContainer(
              duration: 
            const Duration(seconds: 4),
                height: height,
                width: width,
                color: Colors.red,
              )
            
          ],
        ),
      )
    );
  }
}