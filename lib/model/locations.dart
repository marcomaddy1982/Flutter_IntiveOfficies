import 'dart:convert';

List<Location> locationFromJson(String str) {
  final jsonData = json.decode(str);
  return List<Location>.from(jsonData.map((x) => Location.fromJson(x)));
}

class Location {
  String id, city, imageUrl;

  Location({
    this.id,
    this.city,
    this.imageUrl
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    id: json["id"],
    city: json["city"],
    imageUrl: json["imageUrl"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "city": city,
    "imageUrl": imageUrl
  };
}