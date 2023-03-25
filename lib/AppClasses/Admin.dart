import 'Personne.dart';
import 'Utilisateur.dart';
class Admin extends Personne{
  String codeAdmin;
  List<Utilisateur> listeDesUtilisateurs ;
  Admin(super.identifiant, super.nom, super.prenom, super.email, super.motDePasse, super.numeroTelephone,this.codeAdmin,this.listeDesUtilisateurs);
  void ajouterUtilisateur(Utilisateur utilisateur) {
    listeDesUtilisateurs.add(utilisateur);
  }

  void supprimerUtilisateur(Utilisateur utilisateur) {
    listeDesUtilisateurs.remove(utilisateur);
  }

  void managerBdd() {
    // Code for managing the database
  }

  void consulterTrajet() {
    // Code for consulting the travel itinerary
  }

  void modifierTrajet() {
    // Code for modifying the travel itinerary
  }

  void annulerTrajet() {
    // Code for canceling the travel itinerary
  }

  void evaluerUtilisateur(Utilisateur utilisateur, int rating) {
  }

  void afficherCommentairesUtilisateur(Utilisateur utilisateur) {
    // Code for displaying user comments
  }
}