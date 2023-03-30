import 'package:firebase_auth/firebase_auth.dart';
import 'package:appcouvoiturage/Models/Users.dart';

class AuthService{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Users _userfromfirebase(User? user){//User is a firebase class and Users is my own class that i had create
    return Users(user!.uid);
  }
  Stream<Users> get user{
    return _auth.authStateChanges().map(_userfromfirebase);//equivalent a .map((User? user) => _userfromfirebase(user) )
  }

  // methode to login

  // methode to sign up

  // methode to sign out

}