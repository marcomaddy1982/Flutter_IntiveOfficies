import 'package:web_socket_channel/io.dart';
import 'package:intive_offices/bloc/locations_bloc.dart';
import 'package:intive_offices/websocket/socket_connector.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';

class InjectionInit {
  static void init() {
    final injector = Injector.getInjector();
    injector.map<SocketConnector>((i) => SocketConnector(channel: IOWebSocketChannel.connect('ws://10.176.50.65:3000/sockets')),
        isSingleton: true);
    injector.map<LocationsBloc>(
        (i) => new LocationsBloc(injector.get<SocketConnector>().channel));
  }

  static void dispose() {
    Injector.getInjector().dispose();
  }
}