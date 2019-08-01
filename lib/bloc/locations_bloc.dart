import 'dart:convert';

import 'package:intive_offices/model/socket_event.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:intive_offices/model/location.dart';
import 'package:rxdart/rxdart.dart';

class LocationsBloc {
  final WebSocketChannel channel;

  Sink<List<Location>> get _sink => _locationStream.sink;
  final _locationStream = BehaviorSubject<List<Location>>();
  Stream<List<Location>> locations;

  LocationsBloc(this.channel) {
      locations = _locationStream.stream;
      channel.stream.listen((message) {
        SocketEvent socketEvent = eventFromJson(message);
        if(socketEvent.data.isNotEmpty && socketEvent.event == "event get locations") {
            List<Location> results = locationFromJson(socketEvent.data);
            _sink.add(results);
        }
      });
  }

  void dispose() {
    _locationStream.close();
  }

  void start() {
    SocketEvent event = SocketEvent(
      id: "id", 
      source: "client", 
      destination: "server", 
      event: "event get locations", 
      data: ""
    );
    String toJsonString = jsonEncode(event);
    channel.sink.add(toJsonString);
  }
}