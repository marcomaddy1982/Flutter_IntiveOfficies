import 'dart:convert';

SocketEvent eventFromJson(String str) {
  final jsonData = json.decode(str);
  return SocketEvent.fromJson(jsonData);
}

class SocketEvent {
  String id, source, destination, event, data;

  SocketEvent({
    this.id,
    this.source,
    this.destination,
    this.event,
    this.data,
  });

  factory SocketEvent.fromJson(Map<String, dynamic> json) => SocketEvent(
    id: json["id"],
    source: json["source"],
    destination: json["destination"],
    event: json["event"],
    data: json["data"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "source": source,
    "destination": destination,
    "event": event,
    "data": data,
  };
}