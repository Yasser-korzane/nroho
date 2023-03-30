import 'package:flutter/material.dart';
import 'package:appcouvoiturage/main.dart';
import 'package:appcouvoiturage/Models/Users.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Users = Provider.of(context);
    //return home page or log in page
    return Connexin(title: 'connexion',);
  }
}
