import 'package:nroho/pages/home.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';


void handleNotification(context) {
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    Map<String, dynamic> data = message.data;
    // Appel de la fonction pour gérer l'ouverture de l'application
    openAppFromNotification(data,context);
  });
}

void openAppFromNotification(Map<String, dynamic> data,context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => home()),
  );
  // Traitement pour ouvrir l'application à partir de la notification
  // ...
}