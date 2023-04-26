class Notifications {
  String id_conducteur;
  String id_pasagers;
  String id_trajet;
  Notifications(this.id_conducteur, this.id_pasagers, this.id_trajet);
  Map<String, dynamic> toMap() {
    return {
      'id_conducteur': id_conducteur,
      'id_pasagers': id_pasagers,
      'id_trajet': id_trajet,
    };
  }
}