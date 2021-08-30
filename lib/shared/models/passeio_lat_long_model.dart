import 'dart:convert';

class PasseioLatLongModel {
  int passeioId;
  String latitude;
  String longitude;
  PasseioLatLongModel({
    required this.passeioId,
    required this.latitude,
    required this.longitude,
  });

  PasseioLatLongModel copyWith({
    int? passeioId,
    String? latitude,
    String? longitude,
  }) {
    return PasseioLatLongModel(
      passeioId: passeioId ?? this.passeioId,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'passeioId': passeioId,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  factory PasseioLatLongModel.fromMap(Map<String, dynamic> map) {
    return PasseioLatLongModel(
      passeioId: map['passeioId'],
      latitude: map['latitude'],
      longitude: map['longitude'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PasseioLatLongModel.fromJson(String source) =>
      PasseioLatLongModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'PasseioLatLongModel(passeioId: $passeioId, latitude: $latitude, longitude: $longitude)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PasseioLatLongModel &&
        other.passeioId == passeioId &&
        other.latitude == latitude &&
        other.longitude == longitude;
  }

  @override
  int get hashCode =>
      passeioId.hashCode ^ latitude.hashCode ^ longitude.hashCode;
}
