import 'package:flutter/material.dart';

import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:intive_offices/websocket/socket_manager.dart';

import 'package:intive_offices/model/location.dart';
import 'package:intive_offices/screen/screen_map_office.dart';
import 'package:intive_offices/screen/screen_empty.dart';


class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    var socketManager = Injector.getInjector().get<SocketManager>();
    return HomePageState(socketManager);
  }
}

class HomePageState extends State<HomePage> {
  final SocketManager socketManager;

  HomePageState(this.socketManager) {
    socketManager.sendLocationEvent();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Intive Offices"),
      ),
      body: Column(
        children: <Widget>[
          _buildLocationsStreamBuilder(),
        ],
      ),
    );
  }

  Widget _buildLocationsStreamBuilder() {
    return StreamBuilder(
              stream: socketManager.locationsBloc.locations,
              builder: (context, snapshot) {
                if(snapshot.hasData) {
                  return _buildLocationList(snapshot.data);
                } 
                return ScreenEmpty();
              },
            );
  }

  Widget _buildLocationList(List<Location> locations) {
    return Expanded(
      child: ListView.separated(
        key: Key('locations-list'),
        itemCount: locations.length,
        itemBuilder: (BuildContext ctxt, int index) =>_buildLocationItem(locations[index]),
        separatorBuilder: (context, index) { return Divider(); },
      )
    );
  }

  Widget _buildLocationItem(Location location) {
    return ListTile(
      leading: CircleAvatar(backgroundImage: NetworkImage(location.imageUrl)),
      trailing: Icon(Icons.keyboard_arrow_right),
      title: Text(location.city),
      subtitle: Text("offices number: " + location.officesNumber.toString()),
      onTap: () { 
          _pushMapOfficeDetail(location.id);
       }
    );
  }

  void _pushMapOfficeDetail(String locationId) {
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => MapOfficePage(locationId)));
  }
}
