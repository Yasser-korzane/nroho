class PlusInformations{
  bool fumeur ;
  bool bagage ;
  bool animaux ;
  int nbPlaces ;
  PlusInformations(this.fumeur, this.bagage, this.animaux, this.nbPlaces);
  Map<String, dynamic> toMap() {
    return {
      'fumeur': fumeur,
      'bagage': bagage,
      'animaux': animaux,
      'nbPlaces': nbPlaces,
    };
  }
}