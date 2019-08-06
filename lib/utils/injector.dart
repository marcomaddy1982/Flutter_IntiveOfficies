import 'package:web_socket_channel/io.dart';
import 'package:intive_offices/bloc/locations_bloc.dart';
import 'package:intive_offices/bloc/offices_bloc.dart';
import 'package:intive_offices/websocket/socket_connector.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';

class InjectionInit {
  static void init() {
    final injector = Injector.getInjector();
    injector.map<SocketConnector>((i) => SocketConnector(channel: IOWebSocketChannel.connect('ws://localhost:8080/sockets')));
    injector.map<LocationsBloc>(
        (i) => injector.get<SocketConnector>().locationsBloc);
    injector.map<OfficesBloc>(
        (i) => injector.get<SocketConnector>().officesBloc);
  }

  static void dispose() {
    Injector.getInjector().dispose();
  }
}