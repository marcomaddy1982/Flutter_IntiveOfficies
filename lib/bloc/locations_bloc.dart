import 'package:flutter/foundation.dart';

import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:intive_offices/model/location.dart';
import 'package:rxdart/rxdart.dart';

class LocationsBloc {
  final WebSocketChannel channel;

  Sink<List<Location>> get _sink => _locationStream.sink;
  final _locationStream = PublishSubject<List<Location>>();
  Stream<List<Location>> locations;

  LocationsBloc({@required this.channel}) {
      locations = _locationStream.stream;
  }

  void dispose() {
    _locationStream.close();
  }

  void sink(List<Location> locations) {
    _sink.add(locations);
  }
}