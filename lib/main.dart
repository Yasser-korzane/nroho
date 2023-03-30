import 'package:appcouvoiturage/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:appcouvoiturage/pages/signup.dart';
import 'package:appcouvoiturage/pages/login.dart';
import 'package:appcouvoiturage/pages/connection.dart';
import 'package:appcouvoiturage/pages/profilepage.dart';
import 'package:appcouvoiturage/Services/wrapper.dart';
void main() {
  runApp(MaterialApp(
    theme: ThemeData(fontFamily: 'Poppins'),
    home: MyBeginPage(title: ""),
  ));
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      initialRoute: '/commencer',
      routes: {
        '/signin':(context) => const Connexin(title: 'connextion '),
        '/signup':(context) => const MyHomePage(title: 'SingnUp'),
        '/commencer':(context) => const MyBeginPage(title: 'begin') ,
      },
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const Connexin(title: 'Flutter Demo Home Page'),
    );
  }
}
