import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:intive_offices/websocket/socket_manager.dart';
import 'package:intive_offices/model/office.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intive_offices/screen/screen_office.dart';

class MapOfficePage extends StatefulWidget {
  final String locationId;

  MapOfficePage(this.locationId);

  @override
  State<StatefulWidget> createState() {
    var socketManager = Injector.getInjector().get<SocketManager>();
    return MapOfficePageState(socketManager, locationId);
  }
}

class MapOfficePageState extends State<MapOfficePage> {
  final String locationId;
  final SocketManager socketManager;

  Completer<GoogleMapController> _controller = Completer();

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  MapOfficePageState(this.socketManager, this.locationId) {
    socketManager.sendOfficeEvent(locationId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Intive Offices"),
      ),
      body: Column(
        children: <Widget>[
          _buildOfficeStreamBuilder(),
        ],
      ),
    );
  }

  Widget _buildOfficeStreamBuilder() {
    return StreamBuilder(
              stream: socketManager.officesBloc.offices,
              builder: (context, snapshot) {
                if(snapshot.hasData) {
                    List<Office> offices = snapshot.data;
                    LatLng position = _buildOfficePosition(offices[0]);
                    List<Marker> markers = _buildOfficeMarkers(offices);
                    return _buildMap(position, markers);
                }
                return Container();
              },
            );
  }

  Widget _buildMap(LatLng position, List<Marker> markers) {
    return Expanded(
      child: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: position,
                zoom: 9.0,
              ),
              markers: Set<Marker>.of(markers),
      ));
  }

  LatLng _buildOfficePosition(Office office) {
   return LatLng(double.parse(office.lat), double.parse(office.long));
  }

  List<Marker> _buildOfficeMarkers(List<Office> offices) {
    return offices.map((office) => _buildMarker(office)).toList();
  }

  Marker _buildMarker(Office office) {
    return Marker(
      markerId: MarkerId(office.lat.toString()),
      position: _buildOfficePosition(office),
      infoWindow: InfoWindow(
        title: office.address, 
        snippet: office.officeType,
        onTap: () {
          _pushOfficeDetail(office);
        }
      ),
    );
  }

  void _pushOfficeDetail(Office office) {
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => OfficePage(office)));
  }
}