class Notifications {
  String id_conducteur;
  String id_pasagers;
  String id_trajetLance;
  String id_trajetReserve;
  String nom ;
  String prenom ;
  String villeDepart;
  String villeArrive;
  bool accepte_refuse;
  Notifications(this.id_conducteur, this.id_pasagers, this.id_trajetLance,this.id_trajetReserve,this.nom,this.prenom,this.villeDepart,this.villeArrive,this.accepte_refuse);
  Map<String, dynamic> toMap() {
    return {
      'id_conducteur': id_conducteur,
      'id_pasagers': id_pasagers,
      'id_trajetLance': id_trajetLance,
      'id_trajetReserve': id_trajetReserve,
      'nom': nom ,
      'prenom': prenom,
      'villeDepart': villeDepart,
      'villeArrive': villeArrive,
      'accepte_refuse': accepte_refuse,
    };
  }
  void afficher() {
    print('id_conducteur: ${id_conducteur}');
    print('id_pasagers: ${id_pasagers}');
    print('id_trajetLance: ${id_trajetLance}');
    print('id_trajetReserve: ${id_trajetReserve}');
    print('nom: ${nom}');
    print('prenom: ${prenom}');
    print('villeDepart: ${villeDepart}');
    print('villeArrive: ${villeArrive}');
    print('accepte_refuse: ${accepte_refuse}');
  }

}