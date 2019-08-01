import 'dart:convert';

List<Office> officesFromJson(String str) {
  final jsonData = json.decode(str);
  return List<Office>.from(jsonData.map((x) => Office.fromJson(x)));
}

class Office {
  String locationId, city, address, lat, long, phone, email, description, officeType;
  int employeesNumber;
  List<String> images;

  Office({
    this.locationId,
    this.city,
    this.address,
    this.lat,
    this.long,
    this.phone,
    this.email,
    this.description,
    this.officeType,
    this.employeesNumber,
    this.images
  });

  factory Office.fromJson(Map<String, dynamic> json) => Office(
    locationId: json["locationId"],
    city: json["city"],
    address: json["address"],
    lat: json["lat"],
    long: json["long"],
    phone: json["phone"],
    email: json["email"],
    description: json["description"],
    officeType: json["officeType"],
    employeesNumber: json["employeesNumber"],
    images: List<String>.from(json["images"]),
  );

  Map<String, dynamic> toJson() => {
    "locationId": locationId,
    "city": city,
    "address": address,
    "lat": lat,
    "long": long,
    "phone": phone,
    "email": email,
    "description": description,
    "officeType": officeType,
    "employeesNumber": employeesNumber,
    "images": images
  };
}