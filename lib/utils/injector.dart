import 'package:web_socket_channel/io.dart';
import 'package:intive_offices/bloc/locations_bloc.dart';
import 'package:intive_offices/bloc/offices_bloc.dart';
import 'package:intive_offices/websocket/socket_manager.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';

class InjectionInit {
  static void init() {
    final injector = Injector.getInjector();
    injector.map<SocketManager>((i) => SocketManager(channel: IOWebSocketChannel.connect('ws://localhost:8080/sockets')));
    injector.map<LocationsBloc>(
        (i) => injector.get<SocketManager>().locationsBloc);
    injector.map<OfficesBloc>(
        (i) => injector.get<SocketManager>().officesBloc);
  }

  static void dispose() {
    Injector.getInjector().dispose();
  }
}