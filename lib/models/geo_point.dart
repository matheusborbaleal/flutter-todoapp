class GeoPoint {
  final double latitude;
  final double longitude;

  GeoPoint({required this.latitude, required this.longitude});

  Map<String, dynamic> toMap() {
    return {
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  factory GeoPoint.fromMap(Map<String, dynamic> map) {
    return GeoPoint(
      latitude: map['latitude'].toDouble(),
      longitude: map['longitude'].toDouble(),
    );
  }
}