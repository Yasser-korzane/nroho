abstract class Personne{
  int identifiant ;
  String nom ;
  String prenom ;
  String email ;
  String motDePasse ;
  String numeroTelephone ;
  Personne(this.identifiant, this.nom,this.prenom, this.email, this.motDePasse,
      this.numeroTelephone);
  void connexion(){}
  void deconnexion(){}
  void afficherCompteUtilisateur(){}
  void afficherMonProfil(){}
  void signalerUtilisateur(){}
}
