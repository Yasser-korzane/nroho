import 'package:appcouvoiturage/AppClasses/Utilisateur.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:appcouvoiturage/Models/Users.dart';
import 'package:appcouvoiturage/Services/base de donnee.dart';

class AuthService{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Users _userfromfirebase(User? user){//User is a firebase class and Users is my own class that i had create
    return Users(user!.uid);
  }
  Stream<Users> get user{
    return _auth.authStateChanges().map(_userfromfirebase);//equivalent a .map((User? user) => _userfromfirebase(user) )
  }

  // methode to login
  Future signIn(String email,String password) async{
    try{
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user =result.user;
      return _userfromfirebase(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }
  // methode to sign up
    Future signUp(String email,String password,Utilisateur utilisateur) async{
    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user =result.user;
      utilisateur.identifiant = user!.uid;
      BaseDeDonnee().creerUtilisateur(utilisateur);
      return _userfromfirebase(user);
    }catch(e){
      print(e.toString());
      return null;
    }
    }
  // methode to sign out
    Future signOut() async{
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
    }
}