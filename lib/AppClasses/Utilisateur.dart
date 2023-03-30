import 'Evaluation.dart';
import 'Personne.dart';
import 'Trajet.dart';
import 'Vehicule.dart';
class Utilisateur extends Personne{
  Evaluation evaluation;
  Vehicule vehicule;
  bool statut; // si true alors est un passager, si false alors est un conducteur
  List<Trajet> trajetsLances;
  List<Trajet> trajetsReserves;
  List<Trajet> Historique;
  static int nbUtilisateurs = 0;
  Utilisateur(super.identifiant, super.nom, super.prenom, super.email,super.motDePasse,
      super.numeroTelephone,this.evaluation, this.vehicule, this.statut,
      this.trajetsReserves,this.trajetsLances,this.Historique);
  void lancerTrajet() {
    // Code pour lancer un trajet
  }
  void reserverTrajet() {
    // Code pour réserver un trajet
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

  void afficherTrajetReservee() {
    // Code pour afficher les trajets réservés
  }

  void afficherTrajetLancee() {
    // Code pour afficher les trajets lancés
  }

  void afficherHistorique() {
    // Code pour afficher l'historique des trajets effectués
  }
  void ajouterHistorique(Trajet trajet) {
    Historique.add(trajet);
  }
  void ajouterTrajetReserve(Trajet trajet) {
    trajetsReserves.add(trajet);
  }
  void ajouterTrajetLance(Trajet trajet) {
    trajetsLances.add(trajet);
  }
}
