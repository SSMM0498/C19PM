class Locality {
  String localityName;
  int newCases;
  bool isRegion;

  Locality({
    this.localityName,
    this.newCases,
    this.isRegion,
  });

  Map<String, dynamic> toMap() {
    return {
      'localityName': localityName,
      'newCases': newCases,
      'isRegion': isRegion,
    };
  }

  factory Locality.fromMap(Map<String, dynamic> map) {
    return Locality(
      localityName: map['localityName'] ?? '',
      newCases: map['newCases'] ?? 0,
      isRegion: (map['adminLevel'] == 'region') ? true : false ?? false,
    );
  }

  static Locality initLocality() {
    return Locality(
      localityName: '',
      newCases: 0,
      isRegion: true,
    );
  }
}
