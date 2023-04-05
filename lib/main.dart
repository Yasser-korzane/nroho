import 'package:appcouvoiturage/Models/Users.dart';
import 'package:appcouvoiturage/Services/auth.dart';
import 'package:appcouvoiturage/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:appcouvoiturage/Services/wrapper.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:appcouvoiturage/pages/Historique.dart';
import 'package:appcouvoiturage/Shared/lodingEffect.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((_) {
    runApp(
      MaterialApp(
        theme: ThemeData(fontFamily: 'Poppins'),
        home: MyApp(),
       /* home: const home(),
        routes: {
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
        home: Wrapper(), //const Connexin(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}
