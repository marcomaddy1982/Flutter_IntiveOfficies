import 'package:flutter/foundation.dart';

import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:intive_offices/model/office.dart';
import 'package:rxdart/rxdart.dart';

class OfficesBloc {
  final WebSocketChannel channel;

  Sink<List<Office>> get _sink => _officeStream.sink;
  final _officeStream = BehaviorSubject<List<Office>>();
  Stream<List<Office>> offices;

  OfficesBloc({@required this.channel}) {
    offices = _officeStream.stream;
  }

  void dispose() {
    _officeStream.close();
  }

  void sink(List<Office> offices) {
    _sink.add(offices);
  }
}