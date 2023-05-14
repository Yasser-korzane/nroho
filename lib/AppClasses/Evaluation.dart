class Evaluation {
  List<String> feedback;
  int etoiles;
  int nbSignalement;
  Evaluation(this.feedback, this.etoiles, this.nbSignalement);
  Map<String, dynamic> toMap() {
    return {
      'feedback': feedback,
      'etoiles': etoiles,
      'nbSignalement': nbSignalement,
    };
  }
}