import 'Evaluation.dart';
import 'Personne.dart';
import 'Trajet.dart';
import 'Vehicule.dart';
class Utilisateur extends Personne{
  Evaluation evaluation;
  Vehicule vehicule;
  bool statut;
  List<Trajet> trajets;
  static int nbUtilisateurs = 0;
  Utilisateur(super.identifiant, super.nom, super.prenom, super.email, super.motDePasse, super.numeroTelephone,this.evaluation, this.vehicule, this.statut, this.trajets);
  void lancerTrajet() {
    // Code pour lancer un trajet
  }
  void reserverTrajet() {
    // Code pour réserver un trajet
  }

  void modifierReservation() {
    // Code pour modifier une réservation
  }

  void modifierLancement() {
    // Code pour modifier un lancement
  }

  void annulerReservation() {
    // Code pour annuler une réservation
  }

  void annulerLancement() {
    // Code pour annuler un lancement
  }

  void accepterTrajet() {
    // Code pour accepter un trajet
  }

  void modifierProfil() {
    // Code pour modifier le profil de l'utilisateur
  }
  void afficherTrajetReservee() {
    // Code pour afficher les trajets réservés
  }

  void afficherTrajetLancee() {
    // Code pour afficher les trajets lancés
  }

  void afficherHistorique() {
    // Code pour afficher l'historique des trajets effectués
  }
}
