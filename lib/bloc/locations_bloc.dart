import 'dart:convert';

import 'package:intive_offices/model/socket_event.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:rxdart/rxdart.dart';

class LocationsBloc {
  final WebSocketChannel channel;

  LocationsBloc(this.channel);

  void dispose() {
    channel.sink.close();
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