import 'dart:convert';

List<Location> locationFromJson(String str) {
  final jsonData = json.decode(str);
  return List<Location>.from(jsonData.map((x) => Location.fromJson(x)));
}

class Location {
  String id, city, imageUrl;
  int officesNumber;

  Location({
    this.id,
    this.city,
    this.imageUrl,
    this.officesNumber
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    id: json["id"],
    city: json["city"],
    imageUrl: json["imageUrl"],
    officesNumber: json["officesNumber"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "city": city,
    "imageUrl": imageUrl,
    "officesNumber": officesNumber
  };
}