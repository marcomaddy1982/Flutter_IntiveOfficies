import 'dart:convert';

Office officeFromJson(String str) {
  final jsonData = json.decode(str);
  return Office.fromJson(jsonData);
}

class Office {
  String locationId, city, address, lat, long, phone;

  Office({
    this.locationId,
    this.city,
    this.address,
    this.lat,
    this.long,
    this.phone
  });

  factory Office.fromJson(Map<String, dynamic> json) => Office(
    locationId: json["locationId"],
    city: json["city"],
    address: json["address"],
    lat: json["lat"],
    long: json["long"],
    phone: json["phone"],
  );

  Map<String, dynamic> toJson() => {
    "locationId": locationId,
    "city": city,
    "address": address,
    "lat": lat,
    "long": long,
    "phone": phone
  };
}