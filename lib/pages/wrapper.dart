import 'package:appcouvoiturage/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:appcouvoiturage/pages/signup.dart';
import 'package:appcouvoiturage/pages/login.dart';
class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return home or auth
    return MyHomePage(title: 'title');
  }
}
