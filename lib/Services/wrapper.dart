import 'package:appcouvoiturage/Models/Users.dart';
import 'package:appcouvoiturage/pages/begin.dart';
import 'package:appcouvoiturage/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users?>(context);
     if (user == null) {
      return Commancer();
    } else {
      return home();
    }
  }
}
