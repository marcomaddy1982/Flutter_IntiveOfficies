import 'package:flutter/foundation.dart';
import 'dart:convert';

import 'package:intive_offices/model/socket_event.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'package:intive_offices/bloc/offices_bloc.dart';
import 'package:intive_offices/model/office.dart';

import 'package:intive_offices/bloc/locations_bloc.dart';
import 'package:intive_offices/model/location.dart';

class SocketConnector {
  final WebSocketChannel channel;
  LocationsBloc locationsBloc;
  OfficesBloc officesBloc;

  SocketConnector({@required this.channel}) {
    locationsBloc = LocationsBloc(channel: channel);
    officesBloc = OfficesBloc(channel: channel);

    channel.stream.listen((message) {
        SocketEvent socketEvent = eventFromJson(message);
        if(socketEvent.data.isNotEmpty && socketEvent.event == "event get locations") {
            List<Location> locations = locationFromJson(socketEvent.data);
            locationsBloc.sink(locations);
        } else if(socketEvent.data.isNotEmpty && socketEvent.event == "event get office") {
            List<Office> offices = officesFromJson(socketEvent.data);
            officesBloc.sink(offices);
        }
      });
  }

  void sendLocationEvent() {
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

  void sendOfficeEvent(String locationId) {
    SocketEvent event = SocketEvent(
      id: "id", 
      source: "client", 
      destination: "server", 
      event: "event get office", 
      data: locationId
    );
    String toJsonString = jsonEncode(event);
    channel.sink.add(toJsonString);
  }
}