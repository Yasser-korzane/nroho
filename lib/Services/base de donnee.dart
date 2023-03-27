import 'package:cloud_firestore/cloud_firestore.dart';
class BaseDeDonnee{
  final CollectionReference UtilisateurCollection = FirebaseFirestore.instance.collection('Utilisateur');
}