import 'package:appcouvoiturage/Models/Users.dart';
import 'package:appcouvoiturage/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:appcouvoiturage/main.dart';
import 'package:appcouvoiturage/pages/connection.dart';
import 'package:provider/provider.dart';
import 'package:appcouvoiturage/pages/login.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users?>(context);
     if (user == null) {
      return MyBeginPage(title: 'test',);
    } else {
      return home();
    }
  }
}
