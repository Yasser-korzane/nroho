import 'Evaluation.dart';
import 'Personne.dart';
import 'Trajet.dart';
import 'Vehicule.dart';
import 'Notifications.dart';
class Utilisateur extends Personne{
  Evaluation evaluation;
  Vehicule vehicule;
  bool statut; // si true alors est un passager, si false alors est un conducteur
  List<Trajet> trajetsLances;
  List<Trajet> trajetsReserves;
  List<Trajet> Historique;
  static int nbUtilisateurs = 0;
  List<Notifications> notifications;
  String imageUrl ;
  String fcmTocken;
  bool ilYaUneNotification ;
  Utilisateur(super.identifiant, super.nom, super.prenom, super.email,super.motDePasse,
      super.numeroTelephone,this.evaluation, this.vehicule, this.statut,
      this.trajetsReserves,this.trajetsLances,this.Historique,this.notifications,this.imageUrl,this.fcmTocken,this.ilYaUneNotification);
  void afficher(){
    print("Id : $identifiant , Nom : $nom , Prenom : $prenom , email : $email");
  }
}
