import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotification{
  static final FlutterLocalNotificationsPlugin _notiPlugin=FlutterLocalNotificationsPlugin();
  static void initialize(){
    final InitializationSettings initializationSettings= InitializationSettings(
      android:  AndroidInitializationSettings(
        '@mipmap/ic_launcher'
      )
    );
    _notiPlugin.initialize(initializationSettings,onDidReceiveBackgroundNotificationResponse: (NotificationResponse details){
      print('onDidReceiveNotificaitonResponse Function');
      print(details.payload);
      print(details.payload!= null);
    }

    );
  }
  static void showNotification(RemoteMessage message){
    final NotificationDetails notiDetails = NotificationDetails(
      android:  AndroidNotificationDetails(
       'com.example.nroho',
        'app covoiturage',
        importance: Importance.max,
        priority: Priority.high,
      )
    );
    _notiPlugin.show(DateTime.now().microsecond,message.notification!.title,message.notification!.body, notiDetails,payload: message.toString());
  }
}