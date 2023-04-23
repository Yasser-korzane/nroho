class cardLancer {
  final String firstName;
  final String lastName;
  final  String heurDepar ;
  final  String heureArrive ;
  final String placeDepart ;
  final  String placeArrive ;
  final  double nombraStar ;
  final   int price ;

  int nbPassager = 0;

  cardLancer(
      { required this.firstName ,
        required this.lastName ,
        required this.heurDepar ,
        required this.heureArrive ,
        required this.nbPassager ,
        required this.nombraStar ,
        required this.placeArrive ,
        required this.placeDepart,
        required this.price});
}