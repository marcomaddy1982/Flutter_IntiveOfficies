import 'dart:convert';

import 'package:intive_offices/model/socket_event.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:intive_offices/model/office.dart';
import 'package:rxdart/rxdart.dart';

class OfficeBloc {
  final WebSocketChannel channel;

  Sink<List<Office>> get _sink => _officeStream.sink;
  final _officeStream = BehaviorSubject<List<Office>>();
  Stream<List<Office>> offices;

  OfficeBloc(this.channel) {
    offices = _officeStream.stream;
    channel.stream.listen((message) {
        SocketEvent socketEvent = eventFromJson(message);
        if(socketEvent.data.isNotEmpty && socketEvent.event == "event get office") {
            List<Office> results = officesFromJson(socketEvent.data);
            _sink.add(results);
        }
      });
  }

  void dispose() {
    _officeStream.close();
  }

  void start(String locationId) {
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