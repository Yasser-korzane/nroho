import 'package:flutter/material.dart';
class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("app bar")),
    );
  }
}