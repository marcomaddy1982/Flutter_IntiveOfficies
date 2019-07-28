import 'dart:async';
import 'package:flutter/material.dart';

import 'package:intive_offices/bloc/office_bloc.dart';
import 'package:intive_offices/model/office.dart';

import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:intive_offices/screen/screen_office.dart';

class MapOfficePage extends StatefulWidget {
  final String locationId;

  MapOfficePage(this.locationId);

  @override
  State<StatefulWidget> createState() {
    var officeBloc = Injector.getInjector().get<OfficeBloc>();
    return MapOfficePageState(officeBloc, locationId);
  }
}

class MapOfficePageState extends State<MapOfficePage> {
  final String locationId;
  final OfficeBloc bloc;

  Completer<GoogleMapController> _controller = Completer();

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  MapOfficePageState(this.bloc, this.locationId) {
    bloc.start(locationId);
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
              stream: bloc.office,
              builder: (context, snapshot) {
                if(snapshot.hasData) {
                    LatLng position = _buildOfficePosition(snapshot.data);
                    List<Marker> markers = _buildOfficeMarker(snapshot.data);
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
                zoom: 11.0,
              ),
              markers: Set<Marker>.of(markers),
      ));
  }

  LatLng _buildOfficePosition(Office office) {
   return LatLng(double.parse(office.lat), double.parse(office.long));
  }

  List<Marker> _buildOfficeMarker(Office office) {
    Marker marker = Marker(
      markerId: MarkerId("selectedOffice"),
      position: _buildOfficePosition(office),
      infoWindow: InfoWindow(
        title: office.address, 
        snippet: "phone: " + office.phone,
        onTap: () {
          _pushOfficeDetail(office);
        }
      ),
    );
    return [marker];
  }

  void _pushOfficeDetail(Office office) {
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => OfficePage(office)));
  }
}