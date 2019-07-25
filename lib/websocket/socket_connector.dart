import 'package:flutter/foundation.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class SocketConnector {
  final WebSocketChannel channel;
  SocketConnector({@required this.channel});
}